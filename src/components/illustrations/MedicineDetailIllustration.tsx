// Doctor character with clipboard, pointing to details, with floating stars
export function MedicineDetailIllustration({ className = "" }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 420 320"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`w-full h-full select-none pointer-events-none ${className}`}
    >
      {/* Background stars */}
      <g stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" className="text-yellow-400/60 dark:text-yellow-300/40">
        <path d="M40 50 L40 62 M34 56 L46 56" />
        <path d="M370 240 L370 248 M366 244 L374 244" />
      </g>
      {/* Decorative 4-point star */}
      <path d="M360 70 L364 82 L376 86 L364 90 L360 102 L356 90 L344 86 L356 82 Z"
        fill="oklch(0.72 0.14 85 / 0.55)" stroke="currentColor" strokeWidth="1.25" strokeLinecap="round" className="text-yellow-500/60 dark:text-yellow-300/40" />

      {/* Floating cross elements */}
      <g stroke="currentColor" strokeWidth="1.25" strokeLinecap="round" className="text-primary/30">
        <path d="M70 180h8v-8M78 180v8h8" />
        <path d="M330 180h8v-8M338 180v8h8" />
      </g>

      {/* Main Doctor Character Body */}
      {/* Blue scrubs dress/coat */}
      <path d="M155 175 C150 160 140 140 145 115 Q 155 90 185 88 Q 215 90 225 115 C230 140 220 160 215 175 L230 290 L140 290 Z"
        fill="oklch(0.96 0.015 185)" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="dark:fill-muted/20" />
      
      {/* Stethoscope */}
      <path d="M165 95 C165 125 205 125 205 95" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" className="text-muted-foreground" />
      <path d="M185 120 L185 135 C185 140 195 142 195 147" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" className="text-muted-foreground" />
      <circle cx="195" cy="149" r="3.5" fill="currentColor" className="text-muted-foreground" />

      {/* Head */}
      <ellipse cx="185" cy="70" rx="30" ry="32" fill="oklch(0.88 0.04 50)" stroke="currentColor" strokeWidth="2" />
      {/* Hair */}
      <path d="M158 62 Q 162 38 185 36 Q 208 38 212 62 Q 200 55 185 56 Q 170 55 158 62 Z" fill="oklch(0.3 0.06 80)" stroke="currentColor" strokeWidth="1.5" />
      
      {/* Glasses */}
      <ellipse cx="174" cy="68" rx="8" ry="8" stroke="currentColor" strokeWidth="1.5" fill="none" />
      <ellipse cx="196" cy="68" rx="8" ry="8" stroke="currentColor" strokeWidth="1.5" fill="none" />
      <line x1="182" y1="68" x2="188" y2="68" stroke="currentColor" strokeWidth="1.5" />

      {/* Smile */}
      <path d="M178 78 Q 185 84 192 78" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />

      {/* Blushing cheeks */}
      <ellipse cx="165" cy="76" rx="5" ry="3.5" fill="oklch(0.7 0.15 20 / 0.45)" />
      <ellipse cx="205" cy="76" rx="5" ry="3.5" fill="oklch(0.7 0.15 20 / 0.45)" />

      {/* Left hand holding Clipboard */}
      <path d="M150 155 C 130 162 120 185 125 205" stroke="currentColor" strokeWidth="7" strokeLinecap="round" fill="none" />
      
      {/* Clipboard */}
      <g transform="translate(85, 175)">
        <rect x="0" y="0" width="44" height="60" rx="4" fill="var(--color-card)" stroke="currentColor" strokeWidth="2" />
        <rect x="14" y="-4" width="16" height="8" rx="2" fill="currentColor" className="text-muted-foreground" />
        {/* Lines on clipboard */}
        <line x1="8" y1="14" x2="36" y2="14" stroke="currentColor" strokeWidth="1.5" className="text-muted-foreground/60" />
        <line x1="8" y1="26" x2="36" y2="26" stroke="currentColor" strokeWidth="1.5" className="text-muted-foreground/60" />
        <line x1="8" y1="38" x2="28" y2="38" stroke="currentColor" strokeWidth="1.5" className="text-muted-foreground/60" />
        <path d="M12 48 L16 52 L26 44" stroke="oklch(0.6 0.18 140)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="none" />
      </g>

      {/* Right arm pointing up to highlight detail info */}
      <path d="M220 155 C 240 148 245 130 248 115" stroke="currentColor" strokeWidth="7" strokeLinecap="round" fill="none" />

      {/* Speech bubble: Safe Alternatives */}
      <g transform="translate(258, 65)">
        <path d="M0 0 Q 0 -8 8 -8 L86 -8 Q 94 -8 94 0 L94 48 Q 94 56 86 56 L40 56 L28 70 L26 56 L8 56 Q 0 56 0 48 Z"
          fill="var(--color-card)" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
        <text x="47" y="22" textAnchor="middle" fill="currentColor" fontSize="10" fontWeight="700" fontFamily="var(--font-heading)">Clinical</text>
        <text x="47" y="34" textAnchor="middle" fill="oklch(0.48 0.12 185)" fontSize="10.5" fontWeight="900" fontFamily="var(--font-heading)">Equivalents</text>
        <text x="47" y="47" textAnchor="middle" fill="currentColor" fontSize="8" fontWeight="600" opacity="0.6">Verified by DRAP</text>
      </g>
    </svg>
  );
}
