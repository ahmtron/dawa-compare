import { createClient } from "@/lib/supabase/server";
import { notFound } from "next/navigation";
import { Pill, Building2, Beaker, ShieldAlert, AlertTriangle, Scale, TrendingDown, CheckCircle2, Info } from "lucide-react";
import { PriceHistoryChart } from "@/components/PriceHistoryChart";
import { AiSideEffectSummary } from "@/components/AiSideEffectSummary";
import { BackButton } from "@/components/BackButton";
import { getCompositionSignature, getLatestPrice, filterClinicallyEquivalent } from "@/lib/medicine-utils";
import Link from "next/link";
import { MedicineDetailIllustration } from "@/components/illustrations/MedicineDetailIllustration";
import { NearbyPharmaciesSection } from "@/components/NearbyPharmaciesSection";

export default async function MedicinePage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const supabase = await createClient();

  // 1. Fetch medicine detail
  const { data: med, error: medError } = await supabase
    .from("medicines")
    .select(`
      *,
      category:categories(name),
      manufacturer:manufacturers(name, country),
      compositions:medicine_compositions(
        strength_value,
        strength_unit,
        generic:generics(id, name, description)
      ),
      prices:price_records(price, currency, recorded_at, source)
    `)
    .eq("id", id)
    .single();

  if (medError || !med) {
    notFound();
  }

  // Calculate latest price and history
  const sortedPrices = [...(med.prices || [])].sort(
    (a, b) => new Date(a.recorded_at).getTime() - new Date(b.recorded_at).getTime()
  );
  const latestPriceObj = getLatestPrice(med.prices || []);
  const currentPrice = latestPriceObj?.price ?? null;

  const chartData = sortedPrices.map((p) => ({
    date: new Date(p.recorded_at).toLocaleDateString("en-GB", { month: "short", year: "numeric" }),
    price: Number(p.price),
    currency: p.currency,
  }));

  // 2. Fetch generic alternatives — match on composition signature (all salts)
  let cheaperAlternatives: any[] = [];
  let sideEffects: any[] = [];
  if (med.compositions && med.compositions.length > 0) {
    // Build signature of current medicine's composition
    const currentCompositions = med.compositions.map((c: any) => ({
      generic_id: c.generic.id,
      generic_name: c.generic.name,
      strength_value: c.strength_value,
      strength_unit: c.strength_unit,
    }));
    const currentSignature = getCompositionSignature(currentCompositions);

    // Get all medicines with compositions matching current medicine's generics
    const genericIds = med.compositions.map((c: any) => c.generic.id);
    const { data: allCompositions } = await supabase
      .from('medicine_compositions')
      .select(`
        medicine_id,
        generic:generics(id, name),
        strength_value,
        strength_unit,
        medicine:medicines(
          id, brand_name,
          category:categories(name),
          manufacturer:manufacturers(name),
          prices:price_records(price, currency, recorded_at)
        )
      `)
      .in('generic_id', genericIds)
      .limit(100);

    if (allCompositions && allCompositions.length > 0) {
      // Group compositions by medicine_id
      const medicineMap = new Map<string, any>();

      allCompositions.forEach((comp: any) => {
        if (comp.medicine_id === med.id) return; // Skip current medicine

        if (!medicineMap.has(comp.medicine_id)) {
          medicineMap.set(comp.medicine_id, {
            id: comp.medicine_id,
            brandName: comp.medicine.brand_name,
            category: comp.medicine.category?.name,
            manufacturer: comp.medicine.manufacturer?.name,
            prices: comp.medicine.prices,
            compositions: [],
          });
        }

        medicineMap.get(comp.medicine_id).compositions.push({
          generic_id: comp.generic.id,
          generic_name: comp.generic.name,
          strength_value: comp.strength_value,
          strength_unit: comp.strength_unit,
        });
      });

      // Filter to medicines with identical composition signature
      const equivalentMedicines = Array.from(medicineMap.values()).filter((alt: any) => {
        const altSignature = getCompositionSignature(alt.compositions);
        return altSignature === currentSignature;
      });

      // Get latest prices and filter cheaper alternatives
      cheaperAlternatives = equivalentMedicines
        .map((alt: any) => {
          const latestAltPrice = getLatestPrice(alt.prices);
          return {
            id: alt.id,
            brandName: alt.brandName,
            category: alt.category,
            manufacturer: alt.manufacturer,
            price: latestAltPrice?.price ?? null,
            currency: latestAltPrice?.currency ?? 'PKR',
          };
        })
        .filter((alt: any) => alt.price !== null && currentPrice !== null && alt.price < currentPrice)
        .sort((a: any, b: any) => a.price - b.price);
    }

    // 4. Fetch side effects of these generics
    const { data: effects } = await supabase
      .from("side_effects")
      .select(`
        id,
        description,
        severity,
        generic_id
      `)
      .in("generic_id", genericIds);

    if (effects) {
      // Deduplicate side effects by name, keeping highest severity
      const uniqueEffectsMap = new Map<string, any>();
      effects.forEach((eff: any) => {
        const existing = uniqueEffectsMap.get(eff.description);
        if (!existing || (eff.severity === 'severe' && existing.severity !== 'severe')) {
          uniqueEffectsMap.set(eff.description, eff);
        }
      });
      const uniqueEffects = Array.from(uniqueEffectsMap.values());
      const severityOrder: Record<string, number> = { severe: 0, moderate: 1, mild: 2 };
      uniqueEffects.sort((a, b) => (severityOrder[a.severity] ?? 2) - (severityOrder[b.severity] ?? 2));
      sideEffects = uniqueEffects.slice(0, 5);
    }
  }

  return (
    <div className="max-w-5xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
      {/* Back Button */}
      <div className="mb-6">
        <BackButton />
      </div>

      {/* Header Card */}
      <div className="bg-card text-card-foreground rounded-2xl border border-border shadow-xs overflow-hidden mb-8 transition-colors duration-300">
        <div className="p-6 md:p-8 grid grid-cols-1 md:grid-cols-12 items-center gap-6">
          <div className="md:col-span-6">
            <div className="flex flex-wrap items-center gap-3 mb-1">
              <h1 className="text-3xl md:text-4xl font-extrabold text-foreground tracking-tight">{med.brand_name}</h1>
              {med.prescription_required && (
                <span className="bg-destructive/10 text-destructive text-[10px] font-extrabold uppercase px-2.5 py-1 rounded-md border border-destructive/20 flex items-center gap-1.5 tracking-wider animate-pulse">
                  <ShieldAlert className="w-3.5 h-3.5" /> Rx Required
                </span>
              )}
            </div>
            
            <div className="flex flex-wrap gap-4 text-sm text-muted-foreground mt-3 font-medium">
              <div className="flex items-center gap-1.5">
                <Building2 className="w-4 h-4 text-muted-foreground/75" />
                {med.manufacturer?.name || "Unknown Manufacturer"}
              </div>
              <div className="flex items-center gap-1.5">
                <Pill className="w-4 h-4 text-muted-foreground/75" />
                {med.dosage_form || "Tablet/Capsule"}{med.pack_size ? " · " + med.pack_size : ""}
              </div>
            </div>
          </div>
          
          <div className="md:col-span-3 flex justify-center">
            <div className="w-44 h-32 shrink-0">
              <MedicineDetailIllustration />
            </div>
          </div>
          
          <div className="md:col-span-3 bg-muted/40 border border-border/80 p-5 rounded-xl text-center transition-colors duration-300">
            <p className="text-[10px] text-muted-foreground font-bold uppercase tracking-wider mb-1.5">Current Price</p>
            {latestPriceObj ? (
              <>
                <p className="text-3xl font-black text-accent tracking-tight">
                  <span className="text-sm font-semibold text-muted-foreground mr-1 uppercase">{latestPriceObj.currency}</span>
                  {latestPriceObj.price.toLocaleString()}
                </p>
                <p className="text-[10px] text-muted-foreground/80 mt-1">Source: {sortedPrices[sortedPrices.length - 1]?.source}</p>
              </>
            ) : (
              <p className="text-base font-bold text-muted-foreground">Price not available</p>
            )}
          </div>
        </div>
        
        {/* Composition Strip */}
        <div className="bg-muted/30 border-t border-border p-4 px-6 md:px-8 transition-colors duration-300">
          <h3 className="text-[10px] font-bold text-muted-foreground mb-2.5 flex items-center gap-1.5 uppercase tracking-wider">
            <Beaker className="w-3.5 h-3.5 text-primary" /> Active Ingredients
          </h3>
          <div className="flex flex-wrap gap-2">
            {med.compositions?.map((comp: any) => (
              <div key={comp.generic.id} className="bg-card border border-border px-3 py-1.5 rounded-lg text-sm font-bold text-primary shadow-xs transition-colors duration-300">
                {comp.generic.name} {comp.strength_value && comp.strength_value + (comp.strength_unit || 'mg')}
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2 space-y-8">
          {/* Cheaper Alternatives */}
          <section>
            <h2 className="text-xl font-extrabold text-foreground mb-4 flex items-center gap-2">
              <TrendingDown className="w-5 h-5 text-emerald-500" /> Cheaper Alternatives
            </h2>
            
            {cheaperAlternatives.length > 0 ? (
              <div className="space-y-3">
                {cheaperAlternatives.map(alt => {
                  const savings = currentPrice ? (((currentPrice - alt.price) / currentPrice) * 100).toFixed(0) : 0;
                  
                  return (
                    <Link key={alt.id} href={"/medicine/" + alt.id} className="block group">
                      <div className="bg-card border border-border rounded-xl p-4 flex justify-between items-center shadow-xs hover:shadow-md hover:border-emerald-500/35 transition-all duration-300 transform group-hover:-translate-y-0.5">
                        <div className="min-w-0 flex-1">
                          <p className="text-base font-bold text-foreground group-hover:text-primary transition-colors duration-300 truncate">
                            {alt.brandName}
                          </p>
                          <p className="text-xs text-muted-foreground truncate font-medium mt-0.5">{alt.manufacturer || alt.category || alt.genericName}</p>
                        </div>
                        <div className="flex items-center gap-3 flex-shrink-0 ml-4">
                          <span className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 text-xs font-bold px-2.5 py-1 rounded-full border border-emerald-500/20">
                            Save {savings}%
                          </span>
                          <p className="text-lg font-black text-emerald-600 dark:text-emerald-400 tracking-tight">
                            <span className="text-[10px] font-bold text-muted-foreground mr-0.5 uppercase">{alt.currency}</span>
                            {alt.price.toLocaleString()}
                          </p>
                        </div>
                      </div>
                    </Link>
                  );
                })}
              </div>
            ) : (
              <div className="bg-emerald-500/5 border border-emerald-500/10 rounded-xl p-6 text-center transition-colors duration-300">
                <CheckCircle2 className="w-10 h-10 text-emerald-500 mx-auto mb-3 animate-pulse" />
                <p className="text-base font-bold text-foreground mb-1">
                  {med.brand_name} is already the cheapest option!
                </p>
                <p className="text-sm text-muted-foreground max-w-sm mx-auto leading-relaxed">
                  No generic equivalents with the exact same chemical formulation are priced lower than this brand.
                </p>
              </div>
            )}
          </section>

          {/* Price History */}
          <section className="space-y-4">
            <h2 className="text-xl font-extrabold text-foreground">Price History</h2>
            <div className="bg-card border border-border rounded-xl p-6 shadow-xs transition-colors duration-300">
              <PriceHistoryChart data={chartData} />
            </div>
          </section>
        </div>

        <div className="space-y-8">
          {/* Side Effects — top 5 common only */}
          <section>
            <h2 className="text-xl font-extrabold text-foreground mb-4 flex items-center gap-2">
              <AlertTriangle className="w-5 h-5 text-amber-500" /> Common Side Effects
            </h2>
            
            {sideEffects.length > 0 && med.compositions?.[0]?.generic?.id && (
              <AiSideEffectSummary genericId={med.compositions[0].generic.id} />
            )}

            <div className="bg-card border border-border rounded-xl shadow-xs overflow-hidden transition-colors duration-300">
              {sideEffects.length > 0 ? (
                <ul className="divide-y divide-border/60">
                  {sideEffects.map(effect => (
                    <li key={effect.id} className="px-4 py-3.5 flex items-center gap-3 last:border-0">
                      <div className={"w-2 h-2 rounded-full flex-shrink-0 " + (
                        effect.severity === 'severe' ? 'bg-destructive' :
                        effect.severity === 'moderate' ? 'bg-amber-500' : 'bg-muted-foreground/30'
                      )} />
                      <span className="text-sm font-semibold text-foreground">{effect.description}</span>
                      <span className={"ml-auto text-[10px] font-bold px-2.5 py-0.5 rounded-full capitalize flex-shrink-0 uppercase tracking-wider " + (
                        effect.severity === 'severe' ? 'bg-destructive/10 text-destructive' :
                        effect.severity === 'moderate' ? 'bg-amber-500/10 text-amber-600 dark:text-amber-400' : 'bg-muted text-muted-foreground'
                      )}>{effect.severity || 'mild'}</span>
                    </li>
                  ))}
                </ul>
              ) : (
                <div className="p-6 text-center text-muted-foreground text-sm">
                  No side effects reported in database. Consult a doctor.
                </div>
              )}
            </div>

            {/* Disclaimer */}
            <div className="mt-3 flex items-start gap-2 text-xs text-muted-foreground px-1">
              <Info className="w-3.5 h-3.5 flex-shrink-0 mt-0.5 text-primary" />
              <p>Showing common side effects only. Consult your doctor or pharmacist for a complete list.</p>
            </div>
          </section>

          {/* Nearby Pharmacies */}
          <NearbyPharmaciesSection medicineName={med.brand_name} />
        </div>
      </div>
    </div>
  );
}
