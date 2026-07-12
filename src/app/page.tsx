import { SearchBar } from "@/components/SearchBar";
import { SymptomSearchBar } from "@/components/SymptomSearchBar";
import { Search, Activity, Pill, TrendingDown, CheckCircle2 } from "lucide-react";

export default function Home() {
  return (
    <div className="min-h-screen bg-transparent transition-colors duration-300">
      {/* HERO SECTION */}
      <div className="relative overflow-hidden pt-16 pb-32">
        {/* Modern Radial Gradient Backdrop */}
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,var(--color-secondary),transparent_45%),radial-gradient(circle_at_bottom_left,oklch(0.72_0.14_85_/_0.05),transparent_45%)] dark:bg-[radial-gradient(circle_at_top_right,oklch(0.19_0.03_185_/_0.15),transparent_45%),radial-gradient(circle_at_bottom_left,oklch(0.76_0.13_85_/_0.02),transparent_45%)]" />

        {/* Decorative Blur Blobs */}
        <div className="absolute top-10 right-10 w-[400px] h-[400px] bg-primary/10 dark:bg-primary/5 rounded-full blur-3xl -mr-32 -mt-32 pointer-events-none animate-pulse" style={{ animationDuration: '8s' }} />
        <div className="absolute bottom-10 left-10 w-[400px] h-[400px] bg-accent/10 dark:bg-accent/5 rounded-full blur-3xl -ml-32 -mb-32 pointer-events-none animate-pulse" style={{ animationDuration: '10s' }} />

        {/* Hero Content */}
        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-6 pb-16 min-h-[calc(75vh-80px)] flex items-center">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center w-full">
            
            {/* Left Column: Value Proposition & Search */}
            <div className="lg:col-span-7 text-left space-y-8 flex flex-col items-start">
              {/* Trust Badge */}
              <div className="inline-flex items-center gap-2 px-4 py-2 bg-secondary text-secondary-foreground border border-primary/10 rounded-full text-xs font-bold tracking-wide uppercase shadow-sm hover:shadow transition-all duration-300 animate-fade-in">
                <CheckCircle2 className="w-4 h-4 text-primary" />
                Trusted by 10,000+ Pakistanis
              </div>

              {/* Main Headline */}
              <div className="space-y-4 animate-fade-in-up" style={{ animationDelay: "0.1s" }}>
                <h1 className="text-5xl md:text-6xl font-extrabold tracking-tight leading-[1.15] text-foreground">
                  Find Your Medicine's
                  <br />
                  <span className="bg-gradient-to-r from-primary via-[#14A3A8] to-accent bg-clip-text text-transparent dark:from-primary dark:to-accent animate-gradient">
                    Cheaper Twin
                  </span>
                </h1>

                <p className="text-base md:text-lg text-muted-foreground max-w-xl leading-relaxed font-normal">
                  Instantly compare medicine prices in Pakistan, locate chemical-identical generic alternatives, and save money on your healthcare.
                </p>
              </div>

              {/* Search Bar - Hero CTA */}
              <div className="w-full pt-2 pb-4 animate-fade-in-up" style={{ animationDelay: "0.2s" }}>
                <SearchBar />
              </div>

              {/* Statistics Row */}
              <div className="flex flex-wrap gap-4 text-xs text-muted-foreground pt-2 animate-fade-in-up font-semibold" style={{ animationDelay: "0.3s" }}>
                <div className="flex items-center gap-2 bg-card px-4 py-2 rounded-full border border-border shadow-xs">
                  <span className="text-primary font-bold">✓</span>
                  <span>5,000+ medicines</span>
                </div>
                <div className="flex items-center gap-2 bg-card px-4 py-2 rounded-full border border-border shadow-xs">
                  <span className="text-primary font-bold">✓</span>
                  <span>Real-time prices</span>
                </div>
                <div className="flex items-center gap-2 bg-card px-4 py-2 rounded-full border border-border shadow-xs">
                  <span className="text-primary font-bold">✓</span>
                  <span>Independent comparison</span>
                </div>
              </div>
            </div>

            {/* Right Column: Premium Hand-Drawn "Cheaper Twins" SVG Illustration */}
            <div className="lg:col-span-5 flex justify-center items-center w-full animate-fade-in-up" style={{ animationDelay: "0.2s" }}>
              <div className="relative w-full max-w-[430px] aspect-square flex items-center justify-center">
                <HeroIllustration />
              </div>
            </div>

          </div>
        </div>

        {/* Curved waves divider (Psychologist4 inspired shape) */}
        <div className="absolute bottom-0 left-0 right-0 w-full overflow-hidden leading-none z-10 pointer-events-none">
          <svg viewBox="0 0 1200 120" preserveAspectRatio="none" className="relative block w-full h-[60px] text-muted/30 fill-current transition-colors duration-300">
            <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V120H0V0C26.9,8.75,57.05,18.3,81,25.69,154.06,48.07,242.09,71.22,321.39,56.44Z"></path>
          </svg>
        </div>
      </div>

      {/* HOW IT WORKS SECTION */}
      <div className="relative py-24 px-4 sm:px-6 lg:px-8 bg-muted/30 border-y border-border transition-colors duration-300">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16 space-y-4 reveal">
            <h2 className="text-4xl font-extrabold text-foreground tracking-tight">
              How It Works
            </h2>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto leading-relaxed">
              Three simple steps to unlock significant savings on your prescription costs.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 lg:gap-10">
            {/* Step 1 */}
            <div className="group relative bg-card rounded-2xl p-8 shadow-xs hover:shadow-lg transition-all duration-300 border border-border hover:border-primary/45 transform hover:-translate-y-1 reveal delay-100">
              <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-300" />

              <div className="relative z-10 space-y-6">
                <div className="w-12 h-12 bg-primary/10 text-primary rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform duration-300">
                  <Search className="w-6 h-6" />
                </div>

                <div className="space-y-2">
                  <h3 className="text-xl font-bold text-foreground">1. Search Medicine</h3>
                  <p className="text-muted-foreground text-sm leading-relaxed font-medium">
                    Type in any brand name or active salt formula. We scan the catalog in milliseconds to find matches.
                  </p>
                </div>
              </div>
            </div>

            {/* Step 2 */}
            <div className="group relative bg-card rounded-2xl p-8 shadow-xs hover:shadow-lg transition-all duration-300 border border-border hover:border-accent/45 transform hover:-translate-y-1 reveal delay-200">
              <div className="absolute inset-0 bg-gradient-to-br from-accent/5 to-transparent rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-300" />

              <div className="relative z-10 space-y-6">
                <div className="w-12 h-12 bg-accent/10 text-accent rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform duration-300">
                  <Pill className="w-6 h-6" />
                </div>

                <div className="space-y-2">
                  <h3 className="text-xl font-bold text-foreground">2. Find Alternatives</h3>
                  <p className="text-muted-foreground text-sm leading-relaxed font-medium">
                    Instantly view clinically equivalent medicines containing the exact same active ingredients and strength.
                  </p>
                </div>
              </div>
            </div>

            {/* Step 3 */}
            <div className="group relative bg-card rounded-2xl p-8 shadow-xs hover:shadow-lg transition-all duration-300 border border-border hover:border-primary/45 transform hover:-translate-y-1 reveal delay-300">
              <div className="absolute inset-0 bg-gradient-to-br from-emerald-500/5 to-transparent rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-300" />

              <div className="relative z-10 space-y-6">
                <div className="w-12 h-12 bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform duration-300">
                  <TrendingDown className="w-6 h-6" />
                </div>

                <div className="space-y-2">
                  <h3 className="text-xl font-bold text-foreground">3. Compare & Save</h3>
                  <p className="text-muted-foreground text-sm leading-relaxed font-medium">
                    Compare maximum retail prices side-by-side, read simplified side-effects, and select the best value option.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* AI SYMPTOM SEARCH SECTION */}
      <div className="relative py-24 px-4 sm:px-6 lg:px-8 bg-transparent">
        <div className="max-w-4xl mx-auto reveal delay-100">
          <div className="text-center mb-8 space-y-4">
            <div className="inline-flex items-center gap-2 px-3 py-1 bg-purple-500/10 text-purple-700 dark:text-purple-300 border border-purple-500/20 rounded-full text-[10px] font-bold uppercase tracking-wider">
              <Activity className="w-3.5 h-3.5" />
              Symptom Router AI
            </div>

            <h2 className="text-3xl md:text-4xl font-extrabold text-foreground tracking-tight">
              Or Describe Your Symptoms
            </h2>
            <p className="text-base text-muted-foreground max-w-2xl mx-auto leading-relaxed font-medium">
              Describe how you feel in simple terms, and our AI assistant will suggest relevant medicine groups for you to compare.
            </p>
          </div>

          <SymptomSearchBar />
        </div>
      </div>
    </div>
  );
}

/* Custom Hand-Drawn Inline SVG Illustration Component */
function HeroIllustration() {
  return (
    <svg 
      viewBox="0 0 500 500" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
      className="w-full h-full text-foreground drop-shadow-sm select-none pointer-events-none"
    >
      {/* 1. Background Grid & Sparkles (Doodle Style) */}
      {/* Hand-drawn Stars */}
      <path 
        d="M60 120 L70 135 L85 125 L75 145 L90 155 L70 155 L60 170 L55 150 L35 150 L50 140 Z" 
        fill="oklch(0.72 0.14 85 / 0.5)" 
        stroke="currentColor" 
        strokeWidth="1.5" 
        strokeLinecap="round" 
        strokeLinejoin="round"
        className="animate-float-slow"
      />
      <path 
        d="M420 80 L425 90 L435 83 L428 95 L438 102 L425 102 L420 112 L417 99 L407 99 L415 92 Z" 
        fill="oklch(0.72 0.14 85 / 0.5)" 
        stroke="currentColor" 
        strokeWidth="1.5" 
        strokeLinecap="round" 
        strokeLinejoin="round"
        className="animate-float-slower"
      />
      
      {/* Small Star Sparks */}
      <g stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" className="text-muted-foreground/60 animate-pulse">
        {/* Left top spark */}
        <path d="M120 70 L120 82 M114 76 L126 76" />
        {/* Right bottom spark */}
        <path d="M380 380 L380 392 M374 386 L386 386" />
        {/* Mid right spark */}
        <path d="M440 220 L440 230 M435 225 L445 225" />
      </g>

      {/* Doodle Dot Grids */}
      <g fill="currentColor" className="text-muted-foreground/30">
        <circle cx="80" cy="240" r="2.5" />
        <circle cx="95" cy="240" r="2.5" />
        <circle cx="80" cy="255" r="2.5" />
        <circle cx="95" cy="255" r="2.5" />
        <circle cx="80" cy="270" r="2.5" />
        <circle cx="95" cy="270" r="2.5" />
        
        <circle cx="410" cy="310" r="2.5" />
        <circle cx="425" cy="310" r="2.5" />
        <circle cx="410" cy="325" r="2.5" />
        <circle cx="425" cy="325" r="2.5" />
      </g>

      {/* Dotted Connections / Swirls */}
      <path 
        d="M170 120 C 230 70, 270 70, 330 120" 
        stroke="currentColor" 
        strokeWidth="2" 
        strokeDasharray="4 6" 
        strokeLinecap="round"
        className="text-primary/60"
      />

      {/* 2. Foliage/Plants at the bottom (Sketched Psychologist4 style) */}
      <g stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" className="text-primary/40">
        {/* Left Foliage */}
        <path d="M50 450 Q 70 380 65 350 M65 350 Q 55 330 45 340 Q 55 355 65 350 M65 370 Q 80 360 85 375" />
        <path d="M30 450 Q 40 400 35 385 M35 385 Q 25 375 20 380 Q 30 395 35 385" />
        
        {/* Right Foliage */}
        <path d="M450 450 Q 430 390 435 360 M435 360 Q 445 340 455 350 Q 445 365 435 360 M435 380 Q 420 370 415 385" />
      </g>

      {/* 3. Left Capsule Character ("Expensive Twin") */}
      <g className="animate-float-slow" style={{ transformOrigin: '180px 250px' }}>
        {/* Capsule Main Shape (Slightly irregular/hand-drawn path) */}
        <path 
          d="M135 150 C135 110, 185 110, 185 150 L185 270 C185 310, 135 310, 135 270 Z" 
          fill="var(--color-card)" 
          stroke="currentColor" 
          strokeWidth="2.25" 
          strokeLinejoin="round" 
        />
        
        {/* Bottom half coloring (Coral/Peach style from reference) */}
        <path 
          d="M135 210 L185 210 C185 210, 185 270, 185 270 C185 310, 135 310, 135 270 Z" 
          fill="oklch(0.82 0.08 30)" 
          stroke="currentColor" 
          strokeWidth="2.25" 
          strokeLinejoin="round"
        />

        {/* Happy Face Details */}
        {/* Smile Closed Eyes */}
        <path d="M148 165 Q152 161 156 165" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        <path d="M164 165 Q168 161 172 165" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        
        {/* Blushing cheeks (soft transparent orange-pink) */}
        <circle cx="145" cy="173" r="5" fill="oklch(0.7 0.15 20 / 0.45)" />
        <circle cx="174" cy="173" r="5" fill="oklch(0.7 0.15 20 / 0.45)" />

        {/* Cute Smile mouth */}
        <path d="M154 176 Q160 182 166 176" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />

        {/* Stick Arms holding sign */}
        <path d="M135 230 C120 230, 110 240, 115 255" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        <path d="M185 230 C195 235, 198 245, 192 258" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />

        {/* Price Tag Box (Rs. 100) */}
        <g transform="translate(75, 255)">
          <rect x="0" y="0" width="70" height="34" rx="8" fill="var(--color-card)" stroke="currentColor" strokeWidth="2" />
          <text 
            x="35" 
            y="21" 
            textAnchor="middle" 
            fill="currentColor" 
            fontSize="12" 
            fontWeight="900" 
            fontFamily="var(--font-heading)"
            className="tracking-tight"
          >
            Rs. 100
          </text>
        </g>
      </g>

      {/* 4. Right Capsule Character ("Cheaper Twin" - Mint Green) */}
      <g className="animate-float-slower" style={{ transformOrigin: '320px 250px' }}>
        {/* Capsule Main Shape (Slightly rotated right) */}
        <path 
          d="M285 170 C285 130, 335 130, 335 170 L335 290 C335 330, 285 330, 285 290 Z" 
          fill="var(--color-card)" 
          stroke="currentColor" 
          strokeWidth="2.25" 
          strokeLinejoin="round" 
        />
        
        {/* Bottom half coloring (Soft mint green matching Medic4) */}
        <path 
          d="M285 230 L335 230 C335 230, 335 290, 335 290 C335 330, 285 330, 285 290 Z" 
          fill="oklch(0.92 0.08 150)" 
          stroke="currentColor" 
          strokeWidth="2.25" 
          strokeLinejoin="round"
        />

        {/* Smiley Face Details */}
        {/* Wide Open Happy Eyes */}
        <circle cx="299" cy="182" r="2.5" fill="currentColor" />
        <circle cx="319" cy="182" r="2.5" fill="currentColor" />
        
        {/* Blushing cheeks */}
        <circle cx="294" cy="190" r="5.5" fill="oklch(0.7 0.15 20 / 0.45)" />
        <circle cx="324" cy="190" r="5.5" fill="oklch(0.7 0.15 20 / 0.45)" />

        {/* Big Smile */}
        <path d="M304 193 Q309 199 314 193" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />

        {/* Stick Arms holding sign */}
        <path d="M285 250 C275 255, 272 265, 278 278" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        <path d="M335 250 C350 250, 360 240, 355 255" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />

        {/* Price Tag Box (Rs. 30 with green Checkmark) */}
        <g transform="translate(330, 255)">
          <rect x="0" y="0" width="85" height="34" rx="8" fill="var(--color-card)" stroke="currentColor" strokeWidth="2" />
          <text 
            x="36" 
            y="21" 
            textAnchor="middle" 
            fill="oklch(0.48 0.12 185)" 
            fontSize="12" 
            fontWeight="900" 
            fontFamily="var(--font-heading)"
            className="tracking-tight"
          >
            Rs. 30
          </text>
          {/* Checkmark icon */}
          <path d="M66 21 L70 25 L76 17" stroke="oklch(0.6 0.18 140)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
        </g>
      </g>
    </svg>
  );
}
