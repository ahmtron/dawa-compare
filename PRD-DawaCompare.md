# Product Requirements Document (PRD)
## DawaCompare — Medicine Price & Generic Alternative Comparator

| | |
|---|---|
| **Version** | 1.0 |
| **Date** | July 10, 2026 |
| **Status** | Draft — ready for AI-assisted ("vibe coding") build |
| **Owner** | You (Student Project) |
| **Working name** | DawaCompare *(alternatives: SaltMatch, MediRate PK — rename freely, it's just a placeholder used consistently through this doc and the TRD)* |

> This PRD is written to be fed directly into an AI coding tool (Claude Code, Cursor, etc.) alongside `TRD-DawaCompare.md`. It defines **what** to build and **why**. The TRD defines **how**. Read both before writing the first line of code.

---

## 1. Executive Summary

DawaCompare is a web app that helps people in Pakistan (and, structurally, any country with brand-heavy pharmaceutical markets) discover that the expensive branded medicine they're about to buy is chemically identical — same **salt formula** / active ingredient — to a cheaper brand sitting on the same shelf. The user searches a medicine, sees every brand that shares its generic composition, compares prices side-by-side, reads side effects in plain language, and (later) finds a nearby pharmacy.

It is not a pharmacy, not an e-commerce store, and not a medical authority. It is an **information and comparison layer** on top of public drug data — closer to a "GoodRx" or "1mg substitutes" experience than a hospital system.

---

## 2. Problem Statement

- In Pakistan, the same active ingredient (e.g. Paracetamol 500mg) is sold under dozens of brand names at very different prices, because branded/marketed drugs carry marketing and packaging costs that generics don't.
- Most patients don't know their prescribed brand has a cheaper twin — they just buy what the doctor wrote on the slip or what the pharmacist hands them.
- There is no single, easy, Pakistan-relevant tool that says: *"This brand and that brand contain the exact same salt — here's the price difference."*
- Existing sources (DRAP's website, manufacturer leaflets) are fragmented, hard to search, and not written for a normal person comparing prices at the counter.

**DawaCompare's job:** turn "what's actually in this medicine, and what else contains it" into a 10-second lookup.

---

## 3. Goals

### 3.1 Product goals
1. Let a user search any medicine and instantly see its **generic/salt formula**.
2. Show **all brand alternatives** with the same salt formula, ranked by price.
3. Show **price history** for a medicine so users understand price trends (not just a snapshot).
4. Present **side effects** in language a non-medical person can understand.
5. Suggest **similar medicines** (same therapeutic use, different salt — e.g. other pain relievers).
6. Give an **admin** a real CRUD dashboard to manage the medicine catalog, not just a seeded static dataset.
7. (Stretch) Show **nearby pharmacies** on a map.

### 3.2 Goals specific to "this needs to impress an evaluator"
A grader (or anyone reviewing the repo/live demo) should be able to see, within two minutes, that this is **not** a copy-pasted template:
- Real, working search over a real dataset (not 5 hardcoded medicines).
- A genuinely useful comparison table + a chart, not just cards.
- A working authenticated admin area with real Create/Read/Update/Delete, not a mockup.
- At least one feature that clearly uses AI *purposefully* (not a decorative chatbot bolted on).
- Clean, deliberate visual design — see [Section 10](#10-design--branding-direction).
- Transparent handling of data limitations (see [Section 11](#11-legal-ethical--data-integrity-notes)) — this signals maturity, not weakness.

### 3.3 Non-goals (explicitly out of scope for v1)
- This is **not** an e-commerce checkout or delivery platform. No cart, no payments.
- This is **not** a diagnostic tool. It never tells a user what disease they have.
- This is **not** a dosage calculator. It never tells a user how much of something to take.
- No prescription verification or controlled-substance handling.
- No real-time live pharmacy stock/inventory (that requires pharmacy partnerships, out of scope).
- No mobile native app — responsive web only.

---

## 4. Target Users & Personas

| Persona | Description | Core need |
|---|---|---|
| **Ayesha, 29, Lahore** | Buys medicine for her household, price-conscious, uses her phone for everything. | "Is there a cheaper version of what the doctor prescribed?" |
| **Imran, 61, retired** | On regular medication for a chronic condition, limited tech confidence. | Large text, simple search, clear side-effect info, low cognitive load. |
| **Sana, pharmacy/pharmD student** | Uses the site to cross-check generic equivalence and study drug classes. | Accurate salt formula data, side effects, therapeutic categories. |
| **Admin (you / site owner)** | Maintains the medicine catalog and prices. | Fast, low-friction CRUD; bulk import; confidence data isn't silently wrong. |

---

## 5. Scope

### 5.1 MVP (v1 — build this first, this is the demo-day target)
1. Landing page
2. Medicine search with autocomplete
3. Medicine detail page: salt formula, generic alternatives, price comparison, side effects, similar medicines
4. Compare tool (2–3 medicines side by side)
5. Filters (price range, category, dosage form, prescription-required)
6. Admin dashboard with full CRUD (medicines, generics, prices, categories)
7. Price history chart (see honest note in §11.3 about how history is populated)
8. One AI-powered feature: **symptom → relevant medicine category search** (Gemini)
9. One AI-powered feature: **plain-language side effect summarizer** (Gemini)
10. Medical disclaimer present on every page that shows health content

### 5.2 Phase 2 (build after MVP is solid, or list as "future work" in your report — either is fine)
1. Nearby pharmacies map (Leaflet + OpenStreetMap, see TRD §7.4)
2. AI-assisted admin data entry (paste raw text → auto-filled CRUD form)
3. User accounts for regular users (save favorites, price-drop alerts)
4. Urdu language toggle
5. CSV/label photo upload with OCR (Gemini multimodal) for admin
6. Public API for the dataset

---

## 6. Core Features — Detailed Requirements

### 6.1 Landing Page
**Purpose:** Establish trust and get the user searching within seconds — this is the "wow, this looks like a real product" moment.

Must include:
- Hero section with a prominent search bar (not buried below the fold) and one clear sentence of value proposition (e.g., "Find out if your medicine has a cheaper twin.")
- 3–4 short "how it works" steps (Search → Compare → Save)
- A live stat strip (e.g., "X medicines indexed · Y generics mapped · Z brands compared") pulled from the real database count, not hardcoded
- A "Popular searches" row (chips like Panadol, Brufen, Augmentin) that link straight into search results
- A visible, non-alarming medical disclaimer in the footer and referenced near any health content
- Clear navigation to: Search, Compare, About/Disclaimer, Admin login (can be a small footer link, doesn't need to be prominent)

**Acceptance criteria:**
- *Given* a first-time visitor, *when* the landing page loads, *then* the search bar is visible without scrolling on a 1366×768 desktop and on a 390px-wide mobile viewport.
- *Given* the stat strip, *when* the database is queried, *then* the numbers shown match `SELECT count(*)` on the relevant tables (no hardcoded placeholder numbers in the shipped version).

### 6.2 Search & Discovery
- Search by **brand name**, **generic/salt name**, or partial match on either.
- Autocomplete/typeahead with debounce (don't fire a query on every keystroke).
- Each result row shows: brand name, generic name, dosage form, lowest available price, prescription-required badge.
- Empty state ("No results for X — try searching by generic name instead") instead of a blank screen.
- Search results are filterable (see §6.5) without a full page reload.

**Acceptance criteria:**
- *Given* a user types "panadol", *when* results return, *then* Panadol (brand) and its generic Paracetamol appear, plus other Paracetamol-brand alternatives.
- *Given* a user types a generic name like "ibuprofen", *when* results return, *then* every brand mapped to that generic is shown, sorted by price ascending by default.

### 6.3 Medicine Detail Page
This is the core page of the product. Tabs or sections for:

| Section | Content |
|---|---|
| **Overview** | Brand name, manufacturer, dosage form, pack size, prescription status, image, DRAP registration number if available |
| **Salt formula / composition** | Active ingredient(s) with strength (e.g., "Paracetamol 500mg") |
| **Generic alternatives** | Every other brand with the *exact same* composition, sorted by price, with % cheaper/more expensive than the current medicine clearly shown |
| **Price history** | Line chart of recorded prices over time for this medicine (see §11.3) |
| **Side effects** | List with severity tag (mild/moderate/severe), sourced text, and an optional "explain simply" AI rewrite |
| **Similar medicines** | Other medicines in the *same therapeutic category* but a *different* salt (e.g., other pain relievers) — clearly labeled as "similar use, different composition" so it's never confused with a generic alternative |

**Acceptance criteria:**
- *Given* a medicine detail page, *when* it loads, *then* "Generic alternatives" only ever contains medicines with an identical composition set — never a partial or different match (this must be enforced at the query level, not left to chance).
- *Given* no other brand shares the exact composition, *when* the alternatives section renders, *then* it shows an honest empty state ("No generic alternatives currently in our database") rather than hiding the section or showing unrelated items.
- *Given* a medicine with fewer than 2 recorded price points, *when* the price history chart renders, *then* it shows a clear "not enough data yet" state instead of a broken/empty chart.

### 6.4 Compare Tool
- User can add 2–3 medicines to a compare tray from search results or detail pages.
- Compare view: side-by-side table — salt formula, strength, price, pack size, manufacturer, prescription status.
- Highlight the cheapest option per row where applicable.

### 6.5 Filters
Applied to search/browse results:
- Price range (min–max slider or inputs)
- Category / therapeutic class (dropdown, e.g. Analgesic, Antibiotic, Antacid)
- Dosage form (tablet, syrup, injection, cream, drops…)
- Prescription required (yes/no toggle)
- Manufacturer (multi-select, optional for v1)

### 6.6 Admin Dashboard
Protected behind login (admin/editor role only — see TRD §9).

Must support full CRUD on:
- Medicines (brand-level records)
- Generics/salts
- Categories
- Prices (adding a new price record — this is how price history actually grows)
- Pharmacies (Phase 2)

Must also include:
- A simple bulk-import tool (CSV upload → preview → confirm → insert) for seeding data at scale
- A basic admin overview: total medicines, recently added items, recently updated prices
- An audit trail (who changed what, when) — small effort, big credibility with a technical evaluator

**Acceptance criteria:**
- *Given* an admin adds a new medicine with a composition and an initial price, *when* they save, *then* the medicine immediately appears in public search and its detail page renders correctly with no manual cache-clear step required.
- *Given* a non-admin (or logged-out) user, *when* they navigate directly to an admin URL, *then* they are redirected to login and cannot read or write admin data (enforced server-side, not just hidden UI).

### 6.7 AI-Powered Features (Google Gemini via AI Studio free key)
Two AI features are in MVP scope; more are Phase 2. All AI features follow the guardrails in §9.

1. **"Describe your symptom" search assist** — user types something like "I have a headache and fever" in plain language. The AI maps this to relevant OTC *categories/generic names already in the database* (e.g., Paracetamol, Ibuprofen) and the app then runs a normal search against those. The AI never invents a drug name that isn't in the database, never diagnoses, never gives dosage.
2. **Plain-language side effect summary** — the AI rewrites the stored clinical side-effect text into a short, plain-language bullet list on the medicine detail page, clearly labeled "AI-simplified summary" with a link to view the original source text.

**Acceptance criteria:**
- *Given* a symptom query, *when* the AI responds, *then* the app only ever surfaces medicines/generics that already exist in the database — the AI output is used to *filter/route* a real query, never to fabricate a result shown to the user.
- *Given* any AI-generated health text is displayed, *when* it renders, *then* it is visually labeled as AI-generated and sits next to (not instead of) the disclaimer.

### 6.8 Trust, Safety & Disclaimers
- A persistent, non-intrusive medical disclaimer: *"DawaCompare provides pricing and composition information for reference only. It is not medical advice. Always consult a licensed doctor or pharmacist before starting, stopping, or switching any medication."*
- Every medicine record shows a "data last updated" timestamp.
- Data source attribution visible somewhere on the detail page (e.g., "Composition data: [source]. Pricing: [source], as of [date].").

### 6.9 Nearby Pharmacies (Phase 2 / stretch goal)
- Map view (Leaflet + OpenStreetMap) centered on user's location (with permission prompt) or a manually entered city.
- Pharmacy markers pulled from OpenStreetMap's `amenity=pharmacy` data via the Overpass API — see TRD §7.4.
- Clicking a marker shows name/address; this is **directory data, not live stock or price**, and should say so.

---

## 7. Key User Flows

**Flow A — Price-conscious search**
Landing page → search "Augmentin" → result list shows Augmentin + other Amoxicillin/Clavulanate brands → tap Augmentin → detail page shows 3 cheaper alternatives with the same composition → tap "Compare" on two of them → side-by-side table confirms savings → done.

**Flow B — Symptom-first search**
Landing page → user doesn't know a medicine name, types "sore throat and mild fever" into the AI search assist → AI maps to Paracetamol/throat lozenge categories → user sees relevant OTC options within those categories → clicks through to a detail page like any normal search result.

**Flow C — Admin adds a new medicine**
Admin logs in → Admin → Medicines → "Add new" → fills brand name, selects/creates generic + strength, category, manufacturer, initial price → saves → record is immediately visible on the public site and appears in relevant "generic alternatives" lists.

---

## 8. Non-Functional Requirements

| Category | Requirement |
|---|---|
| **Performance** | Search results return in under ~500ms for a database of a few thousand records; use pagination/limit, not "load everything." |
| **Responsiveness** | Fully usable on mobile (390px+), tablet, and desktop. Mobile-first, since most Pakistani users will hit this on a phone. |
| **Accessibility** | WCAG AA-reasonable contrast, real semantic HTML, alt text on medicine images, keyboard-navigable forms — important both ethically (older users, §4) and because it's an easy, visible quality signal to a grader. |
| **Localization** | English for v1; currency displayed as **PKR (Rs.)**; Urdu toggle is Phase 2. |
| **Security** | Admin routes protected server-side; no API keys (Gemini, Supabase service role) ever shipped to the browser — see TRD §10. |
| **SEO (nice-to-have)** | Each medicine detail page should have a real, unique `<title>` and meta description generated from its data. |
| **Reliability** | Graceful empty/error/loading states everywhere — no raw stack traces or blank white screens shown to a user. |

---

## 9. AI Guardrails (applies to every AI feature, MVP and future)

These are product requirements, not just engineering details — put them in the PRD because they define what the product is *allowed* to do:

1. The AI **never** generates a dosage, frequency, or duration of use.
2. The AI **never** diagnoses a condition or tells a user what they have.
3. The AI **never** invents a medicine, brand, or generic name that doesn't exist in the database — it only classifies/routes/summarizes real stored data.
4. If a symptom query includes red-flag language (e.g., chest pain, difficulty breathing, severe bleeding), the assistant should stop and show a "please seek medical attention" message instead of a product list.
5. Every AI-touched piece of health content is visually labeled as AI-generated/AI-simplified.

---

## 10. Design & Branding Direction

The single biggest thing separating "impressive project" from "AI slop" is restraint and specificity. Guidance for whoever builds the UI (yourself or an AI coding tool):

- **Palette:** pick one primary color that reads as trustworthy/clinical (a deep teal, blue, or forest green work well for health products) + neutrals. Avoid the generic purple-to-pink SaaS gradient — it instantly reads as templated.
- **Typography:** one clean sans-serif for UI text, a slightly heavier weight for numbers/prices (prices are the emotional core of this product — make them easy to scan).
- **Icons:** use a real icon set (e.g., lucide-react), never emoji as functional icons.
- **Copy:** specific to this product and to Pakistan's context ("Find your medicine's cheaper twin" beats "Welcome to the future of healthcare").
- **States:** design loading skeletons, empty states, and error states *on purpose* — don't leave them as an afterthought. This is one of the fastest tells of a rushed AI-generated build.
- **Data density:** the comparison table and detail page are information-dense by nature — use whitespace and clear hierarchy (price should be the most visually dominant number on any card) rather than cramming.
- **Motion:** subtle only — a hover state, a smooth tab transition. Nothing that slows the user down.

---

## 11. Legal, Ethical & Data Integrity Notes

Be upfront about these — both in the product (disclaimers) and in your project report (it shows you understand the domain, which matters a lot to an evaluator):

1. **This is not a medical authority.** DawaCompare aggregates publicly available composition, pricing, and labeling information. It does not replace a pharmacist or doctor.
2. **Cross-market data is mixed by design, and must be labeled.** Some data (e.g., Kaggle's Indian medicine datasets) reflects the Indian market — different brand names, different regulator, prices in INR. It's still useful for validated generic↔brand↔side-effect *structure*, but must never be silently presented as Pakistani pricing. Tag every price record with its `source` and `currency` (see TRD schema) and only show a "PKR" price where it's genuinely PKR.
3. **DRAP's public product list carries its own disclaimer** stating it's a provisional list not intended for research/statistical citation. Treat DRAP data as a manually spot-checked reference for a *curated sample* of well-known medicines (30–100 entries is plenty for a strong demo), not as a bulk-scraped source of truth.
4. **Price history will start mostly empty — and that's fine, say so.** A brand-new project has no real historical price data. Two honest options: (a) seed a handful of clearly-labeled illustrative points (source = "Seed/demo data"), or (b) let the chart genuinely fill in over the weeks you run the admin dashboard, and show a "not enough data yet" state until then (§6.3). Don't fabricate a fake-looking smooth price history and present it as real — a sharp evaluator will ask.
5. **Respect dataset licenses.** Some Kaggle datasets used for reference (e.g., the 1mg-derived dataset) are CC BY-NC-SA — fine for a non-commercial student/portfolio project, but attribute the source and don't relicense it as your own.
6. **No PII beyond what's needed.** Only the admin needs an account/login in v1. Don't collect user data you don't need.

---

## 12. Success Criteria / Definition of Done (MVP)

- [ ] Deployed, publicly reachable URL (not just localhost)
- [ ] At least 150–300 real medicine records loaded (seeded from the datasets in the TRD appendix), not 5 demo items
- [ ] Search → detail → generic alternatives → compare flow works end-to-end with real data
- [ ] Price history chart renders correctly (including its "not enough data" state)
- [ ] Side effects display with at least one AI-simplified example
- [ ] Symptom-search AI feature works and correctly restricts itself to real DB entries
- [ ] Admin can log in, and can create/edit/delete a medicine and see it reflected publicly within seconds
- [ ] Disclaimer visible on every health-content page
- [ ] Fully responsive on a real phone, not just a resized browser window
- [ ] README explains the data sources, their limitations, and how to reseed the database

---

## 13. Open Assumptions (flagged so you can change them freely)

- Assumed the primary market/currency is Pakistan/PKR; the architecture works for any country by changing the seed data.
- Assumed no real payment/e-commerce is needed.
- Assumed a single admin/editor role is enough (no multi-level permission system).
- Assumed Google AI Studio's free Gemini tier is sufficient for demo-level traffic (see TRD §7.3 for current limits — these change, so re-check before your demo).

---

## 14. Glossary

| Term | Meaning |
|---|---|
| **Salt formula / generic name / active ingredient** | The actual chemical compound that makes a medicine work (e.g., Paracetamol), independent of brand. |
| **Brand name** | The marketed name a manufacturer sells a medicine under (e.g., Panadol is a brand of Paracetamol). |
| **Generic alternative** | A different brand with the *identical* active ingredient(s) and strength. |
| **Similar medicine** | A different medicine used for a similar purpose but with a *different* active ingredient. |
| **MRP** | Maximum Retail Price — the regulator-set ceiling price in Pakistan (set by DRAP). |
| **DRAP** | Drug Regulatory Authority of Pakistan — the government body that registers drugs and sets MRPs. |

---

*See `TRD-DawaCompare.md` for architecture, database schema, API design, exact data source links, and the phase-by-phase build plan.*
