// Balance scale with capsule characters on each side, comparing prices
export function CompareIllustration({ className = "" }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 420 320"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`w-full h-full select-none pointer-events-none ${className}`}
    >
      {/* Background stars */}
      <g stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" className="text-yellow-400/60 dark:text-yellow-300/40">
        <path d="M40 80 L40 92 M34 86 L46 86" />
        <path d="M370 70 L370 78 M366 74 L374 74" />
      </g>

      {/* Dotted Connections / Curves */}
      <path 
        d="M90 180 C 130 110, 290 110, 330 190" 
        stroke="currentColor" 
        strokeWidth="2" 
        strokeDasharray="4 6" 
        strokeLinecap="round"
        className="text-primary/40"
      />

      {/* Main Balance Scale */}
      {/* Stand */}
      <path d="M210 280 L210 130" stroke="currentColor" strokeWidth="4" strokeLinecap="round" className="text-muted-foreground" />
      <path d="M180 280 L240 280" stroke="currentColor" strokeWidth="4" strokeLinecap="round" className="text-muted-foreground" />
      <circle cx="210" cy="130" r="6" fill="currentColor" className="text-muted-foreground" />

      {/* Crossbar (Tilted down on the left, up on the right) */}
      {/* Pivot point at 210, 150 */}
      <g transform="rotate(10, 210, 150)">
        <line x1="110" y1="150" x2="310" y2="150" stroke="currentColor" strokeWidth="4.5" strokeLinecap="round" />
        
        {/* Scale hanger lines */}
        <line x1="110" y1="150" x2="90" y2="230" stroke="currentColor" strokeWidth="1.5" strokeDasharray="3 3" />
        <line x1="110" y1="150" x2="130" y2="230" stroke="currentColor" strokeWidth="1.5" strokeDasharray="3 3" />
        <path d="M80 230 L140 230" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />

        <line x1="310" y1="150" x2="290" y2="190" stroke="currentColor" strokeWidth="1.5" strokeDasharray="3 3" />
        <line x1="310" y1="150" x2="330" y2="190" stroke="currentColor" strokeWidth="1.5" strokeDasharray="3 3" />
        <path d="M280 190 L340 190" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
      </g>

      {/* Left Capsule (Heavy, Expensive, Sad/Sweating Capsule) */}
      <g transform="translate(85, 158) rotate(-5)" className="animate-float-slow" style={{ transformOrigin: '25px 50px' }}>
        <path 
          d="M10 10 C10 -15, 40 -15, 40 10 L40 70 C40 95, 10 95, 10 70 Z" 
          fill="var(--color-card)" 
          stroke="currentColor" 
          strokeWidth="2" 
          strokeLinejoin="round" 
        />
        <path 
          d="M10 40 L40 40 C40 40, 40 70, 40 70 C40 95, 10 95, 10 70 Z" 
          fill="oklch(0.82 0.08 30)" 
          stroke="currentColor" 
          strokeWidth="2" 
          strokeLinejoin="round"
        />
        {/* Sad Face */}
        <circle cx="21" cy="24" r="2" fill="currentColor" />
        <circle cx="31" cy="24" r="2" fill="currentColor" />
        <path d="M22 32 Q26 28 30 32" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" />
        <circle cx="16" cy="29" r="4.5" fill="oklch(0.7 0.15 20 / 0.45)" />
        <circle cx="36" cy="29" r="4.5" fill="oklch(0.7 0.15 20 / 0.45)" />
        {/* Sweat droplet */}
        <path d="M36 15 Q38 18 36 21 Q34 21 34 18 Z" fill="oklch(0.48 0.12 185)" opacity="0.8" />
      </g>

      {/* Right Capsule (Light, Cheaper, Smiling Happy Capsule) */}
      <g transform="translate(285, 108) rotate(5)" className="animate-float-slower" style={{ transformOrigin: '25px 50px' }}>
        <path 
          d="M10 10 C10 -15, 40 -15, 40 10 L40 70 C40 95, 10 95, 10 70 Z" 
          fill="var(--color-card)" 
          stroke="currentColor" 
          strokeWidth="2" 
          strokeLinejoin="round" 
        />
        <path 
          d="M10 40 L40 40 C40 40, 40 70, 40 70 C40 95, 10 95, 10 70 Z" 
          fill="oklch(0.92 0.08 150)" 
          stroke="currentColor" 
          strokeWidth="2" 
          strokeLinejoin="round"
        />
        {/* Happy Face */}
        <circle cx="21" cy="24" r="2" fill="currentColor" />
        <circle cx="31" cy="24" r="2" fill="currentColor" />
        <path d="M22 30 Q26 34 30 30" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" />
        <circle cx="16" cy="29" r="4.5" fill="oklch(0.7 0.15 20 / 0.45)" />
        <circle cx="36" cy="29" r="4.5" fill="oklch(0.7 0.15 20 / 0.45)" />
      </g>

      {/* Speech bubbles / Indicators */}
      {/* Expensive bubble */}
      <g transform="translate(15, 230)">
        <rect x="0" y="0" width="60" height="26" rx="6" fill="var(--color-card)" stroke="currentColor" strokeWidth="1.5" />
        <text x="30" y="17" textAnchor="middle" fill="currentColor" fontSize="10" fontWeight="700">Rs. 180</text>
      </g>
      {/* Savings bubble */}
      <g transform="translate(325, 185)">
        <rect x="0" y="0" width="75" height="34" rx="8" fill="oklch(0.92 0.08 150)" stroke="currentColor" strokeWidth="1.75" />
        <text x="37" y="16" textAnchor="middle" fill="oklch(0.38 0.1 185)" fontSize="9" fontWeight="800" fontFamily="var(--font-heading)">Rs. 45</text>
        <text x="37" y="27" textAnchor="middle" fill="oklch(0.6 0.18 140)" fontSize="8" fontWeight="900" fontFamily="var(--font-heading)">SAVE 75%</text>
      </g>
    </svg>
  );
}
