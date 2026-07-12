// Pharmacist character with magnifying glass, floating pill icons and doodle marks
export function SearchIllustration({ className = "" }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 420 320"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`w-full h-full select-none pointer-events-none ${className}`}
    >
      {/* Background doodle dots */}
      <g fill="currentColor" className="text-muted-foreground/20">
        <circle cx="20" cy="40" r="3" /><circle cx="36" cy="40" r="3" /><circle cx="20" cy="56" r="3" /><circle cx="36" cy="56" r="3" />
        <circle cx="380" cy="260" r="3" /><circle cx="396" cy="260" r="3" /><circle cx="380" cy="276" r="3" /><circle cx="396" cy="276" r="3" />
      </g>

      {/* Star sparkles */}
      <g stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" className="text-yellow-400/60 dark:text-yellow-300/40">
        <path d="M340 30 L340 42 M334 36 L346 36" />{/* big cross */}
        <path d="M60 200 L60 208 M56 204 L64 204" />{/* small cross */}
        <path d="M390 80 L390 88 M386 84 L394 84" />
      </g>
      {/* Decorative 4-point star */}
      <path d="M30 130 L34 142 L46 146 L34 150 L30 162 L26 150 L14 146 L26 142 Z"
        fill="oklch(0.72 0.14 85 / 0.55)" stroke="currentColor" strokeWidth="1.25" strokeLinecap="round" className="text-yellow-500/60 dark:text-yellow-300/40" />

      {/* Floating pill icons (background, scattered) */}
      {/* Pill 1 - top right */}
      <g className="animate-float-slow" style={{ transformOrigin: '360px 60px' }}>
        <path d="M340 50 C340 42 354 42 354 50 L354 70 C354 78 340 78 340 70 Z" fill="oklch(0.82 0.08 30 / 0.5)" stroke="currentColor" strokeWidth="1.5" className="text-foreground/40" />
        <line x1="340" y1="60" x2="354" y2="60" stroke="currentColor" strokeWidth="1.5" className="text-foreground/40" />
      </g>
      {/* Pill 2 - left mid (rotated) */}
      <g className="animate-float-slower" style={{ transformOrigin: '50px 160px', transform: 'rotate(-35deg)' }}>
        <path d="M38 148 C38 140 52 140 52 148 L52 168 C52 176 38 176 38 168 Z" fill="oklch(0.92 0.08 150 / 0.5)" stroke="currentColor" strokeWidth="1.5" className="text-foreground/40" />
        <line x1="38" y1="158" x2="52" y2="158" stroke="currentColor" strokeWidth="1.5" className="text-foreground/40" />
      </g>
      {/* Pill 3 - bottom centre */}
      <g className="animate-float-slow" style={{ transformOrigin: '260px 280px', transform: 'rotate(20deg)' }}>
        <path d="M248 270 C248 262 262 262 262 270 L262 290 C262 298 248 298 248 290 Z" fill="oklch(0.85 0.1 270 / 0.4)" stroke="currentColor" strokeWidth="1.5" className="text-foreground/40" />
        <line x1="248" y1="280" x2="262" y2="280" stroke="currentColor" strokeWidth="1.5" className="text-foreground/40" />
      </g>

      {/* Foliage bottom left */}
      <g stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" className="text-primary/35">
        <path d="M0 300 Q 25 240 20 210 M20 210 Q 10 195 0 200" />
        <path d="M20 230 Q 38 218 42 232" />
        <path d="M15 255 Q -5 240 -8 252" />
      </g>
      {/* Foliage bottom right */}
      <g stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" className="text-primary/35">
        <path d="M420 305 Q 400 248 405 220 M405 220 Q 415 205 422 212" />
        <path d="M405 242 Q 388 230 385 244" />
      </g>

      {/* Main Pharmacist Character Body */}
      {/* White coat body */}
      <path d="M155 175 C150 160 140 140 145 115 Q 155 90 185 88 Q 215 90 225 115 C230 140 220 160 215 175 L230 290 L140 290 Z"
        fill="var(--color-card)" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
      {/* Coat colour accent - teal lapels */}
      <path d="M175 88 L185 110 L195 88" fill="oklch(0.48 0.12 185 / 0.25)" stroke="currentColor" strokeWidth="1.5" strokeLinejoin="round" />

      {/* Head */}
      <ellipse cx="185" cy="70" rx="30" ry="32" fill="oklch(0.88 0.04 50)" stroke="currentColor" strokeWidth="2" />
      {/* Hair */}
      <path d="M158 62 Q 162 38 185 36 Q 208 38 212 62 Q 200 55 185 56 Q 170 55 158 62 Z" fill="oklch(0.45 0.06 50)" stroke="currentColor" strokeWidth="1.5" />
      {/* Eyes - happy squint */}
      <path d="M172 65 Q 176 61 180 65" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
      <path d="M190 65 Q 194 61 198 65" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
      {/* Blush cheeks */}
      <ellipse cx="167" cy="73" rx="6" ry="4" fill="oklch(0.7 0.15 20 / 0.45)" />
      <ellipse cx="203" cy="73" rx="6" ry="4" fill="oklch(0.7 0.15 20 / 0.45)" />
      {/* Smile */}
      <path d="M178 76 Q 185 83 192 76" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />

      {/* Left arm extended holding magnifying glass */}
      <path d="M152 145 C 128 135 108 130 100 140" stroke="currentColor" strokeWidth="8" strokeLinecap="round" fill="none" />
      {/* Right arm down */}
      <path d="M218 145 C 232 155 238 170 235 185" stroke="currentColor" strokeWidth="8" strokeLinecap="round" fill="none" />

      {/* Magnifying Glass */}
      <g transform="translate(68, 108)">
        <circle cx="22" cy="22" r="20" fill="oklch(0.96 0.015 185 / 0.6)" stroke="currentColor" strokeWidth="2.5" />
        <path d="M36 36 L50 52" stroke="currentColor" strokeWidth="3.5" strokeLinecap="round" />
        {/* Shine on lens */}
        <path d="M12 12 Q 16 8 22 10" stroke="white" strokeWidth="1.5" strokeLinecap="round" opacity="0.7" />
      </g>

      {/* Speech bubble with search icon */}
      <g transform="translate(248, 60)">
        <path d="M0 0 Q 0 -8 8 -8 L82 -8 Q 90 -8 90 0 L90 44 Q 90 52 82 52 L40 52 L28 66 L26 52 L8 52 Q 0 52 0 44 Z"
          fill="var(--color-card)" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
        {/* Search text */}
        <text x="45" y="28" textAnchor="middle" fill="currentColor" fontSize="10.5" fontWeight="700" fontFamily="var(--font-heading)">Finding</text>
        <text x="45" y="42" textAnchor="middle" fill="oklch(0.48 0.12 185)" fontSize="10.5" fontWeight="800" fontFamily="var(--font-heading)">matches...</text>
      </g>
    </svg>
  );
}
