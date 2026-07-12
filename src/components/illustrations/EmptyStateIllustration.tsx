// Sad/curious capsule character with a question mark bubble and dotted lines
export function EmptyStateIllustration({ className = "" }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 300 240"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`w-full h-full select-none pointer-events-none ${className}`}
    >
      {/* Sparkle star */}
      <path d="M230 40 L234 52 L246 56 L234 60 L230 72 L226 60 L214 56 L226 52 Z"
        fill="oklch(0.72 0.14 85 / 0.55)" stroke="currentColor" strokeWidth="1.25" strokeLinecap="round" className="text-yellow-500/60 dark:text-yellow-300/40" />

      {/* Dotted curve representing search trace */}
      <path 
        d="M60 160 Q 150 120 180 80" 
        stroke="currentColor" 
        strokeWidth="1.5" 
        strokeDasharray="3 5" 
        strokeLinecap="round"
        className="text-muted-foreground/45"
      />

      {/* Curious Capsule Character */}
      <g transform="translate(125, 80)" className="animate-float-slow" style={{ transformOrigin: '25px 45px' }}>
        <path 
          d="M10 10 C10 -15, 40 -15, 40 10 L40 70 C40 95, 10 95, 10 70 Z" 
          fill="var(--color-card)" 
          stroke="currentColor" 
          strokeWidth="2" 
          strokeLinejoin="round" 
        />
        <path 
          d="M10 40 L40 40 C40 40, 40 70, 40 70 C40 95, 10 95, 10 70 Z" 
          fill="oklch(0.82 0.08 30 / 0.5)" 
          stroke="currentColor" 
          strokeWidth="2" 
          strokeLinejoin="round"
          className="text-muted-foreground/70"
        />

        {/* Curious Puzzled Eyes */}
        <circle cx="21" cy="24" r="2" fill="currentColor" />
        <circle cx="31" cy="24" r="2" fill="currentColor" />
        {/* Flat neutral mouth */}
        <line x1="22" y1="31" x2="30" y2="31" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" />
        
        {/* Soft blushes */}
        <circle cx="16" cy="29" r="4.5" fill="oklch(0.7 0.15 20 / 0.35)" />
        <circle cx="36" cy="29" r="4.5" fill="oklch(0.7 0.15 20 / 0.35)" />
      </g>

      {/* Question mark bubble */}
      <g transform="translate(170, 30)">
        <path d="M0 0 Q 0 -6 6 -6 L42 -6 Q 48 -6 48 0 L48 24 Q 48 30 42 30 L20 30 L10 38 L10 30 L6 30 Q 0 30 0 24 Z"
          fill="var(--color-card)" stroke="currentColor" strokeWidth="1.75" strokeLinejoin="round" />
        <text x="24" y="19" textAnchor="middle" fill="oklch(0.48 0.12 185)" fontSize="18" fontWeight="900" fontFamily="var(--font-heading)">?</text>
      </g>
    </svg>
  );
}
