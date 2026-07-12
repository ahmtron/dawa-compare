// Capsule character ON the bench, balloon string pulls them upward
export function FooterIllustration({ className = "" }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 240 240"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`w-full h-full select-none pointer-events-none ${className}`}
    >
      {/* Dashed circular frame */}
      <circle cx="120" cy="120" r="95"
        stroke="currentColor" strokeWidth="1.5" strokeDasharray="4 6"
        className="text-primary/20 dark:text-primary/10" />

      {/* Stars scattered in sky area */}
      <g stroke="currentColor" strokeWidth="1.25" strokeLinecap="round" className="text-yellow-400/70">
        <path d="M50 55 L50 63 M46 59 L54 59" />
        <path d="M190 75 L190 83 M186 79 L194 79" />
      </g>
      {/* 4-pt sparkle star */}
      <path d="M170 50 L173 59 L182 62 L173 65 L170 74 L167 65 L158 62 L167 59 Z"
        fill="oklch(0.72 0.14 85 / 0.55)" stroke="currentColor" strokeWidth="1"
        className="text-yellow-500/50" />

      {/* ── BALLOON at top ── */}
      {/* Balloon body (cy=58 so knot bottom ≈ y=79) */}
      <ellipse cx="120" cy="55" rx="18" ry="22"
        fill="oklch(0.72 0.14 85)" stroke="currentColor" strokeWidth="2" />
      {/* Shine */}
      <path d="M111 44 Q 115 40 121 43"
        stroke="white" strokeWidth="1.5" strokeLinecap="round" opacity="0.55" />
      {/* Knot at bottom of balloon */}
      <path d="M120 77 L116 83 L124 83 Z"
        fill="currentColor" className="text-yellow-500" stroke="currentColor" strokeWidth="1" />

      {/* ── STRING from balloon knot (120,83) → character's raised hand (≈122,126) ── */}
      <path d="M120 83 Q 116 104 122 126"
        stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none"
        className="text-muted-foreground/70" />

      {/* ── BENCH (seat y=187, backrest y=162) ── */}
      {/* Seat */}
      <path d="M60 187 L180 187"
        stroke="currentColor" strokeWidth="3" strokeLinecap="round"
        className="text-muted-foreground/60" />
      {/* Seat legs */}
      <path d="M75 187 L75 210 M165 187 L165 210 M100 187 L100 210 M140 187 L140 210"
        stroke="currentColor" strokeWidth="2.5" strokeLinecap="round"
        className="text-muted-foreground/55" />
      {/* Backrest slats */}
      <path d="M65 162 L175 162 M65 172 L175 172"
        stroke="currentColor" strokeWidth="2" strokeLinecap="round"
        className="text-muted-foreground/40" />
      {/* Backrest supports */}
      <path d="M75 162 L75 187 M165 162 L165 187"
        stroke="currentColor" strokeWidth="2" strokeLinecap="round"
        className="text-muted-foreground/45" />

      {/* ── CAPSULE CHARACTER ──
          Capsule body: local coords y=0 (top) to y=65 (bottom)
          Placed via translate so bottom (y+65=183) sits ON the bench seat (y=187)
          → translate(103, 122) so body spans y=122 → y=187
          Raised left hand at local (20, 4) → global ≈ (123, 126)  ✓ matches string end
      ── */}
      <g transform="translate(103, 122)">
        {/* Capsule body top half */}
        <path d="M5 8 C5 -8, 33 -8, 33 8 L33 32 L5 32 Z"
          fill="var(--color-card)" stroke="currentColor" strokeWidth="2"
          strokeLinejoin="round" />
        {/* Capsule body bottom half – warm coral */}
        <path d="M5 32 L33 32 L33 55 C33 66, 5 66, 5 55 Z"
          fill="oklch(0.82 0.08 30)" stroke="currentColor" strokeWidth="2"
          strokeLinejoin="round" />

        {/* Eyes (happy, squinting) */}
        <path d="M13 14 Q 16 11 19 14" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" />
        <path d="M21 14 Q 24 11 27 14" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" />
        {/* Smile */}
        <path d="M15 20 Q 19 24 23 20" stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" />
        {/* Blush cheeks */}
        <ellipse cx="11" cy="20" rx="4" ry="3" fill="oklch(0.7 0.15 20 / 0.45)" />
        <ellipse cx="27" cy="20" rx="4" ry="3" fill="oklch(0.7 0.15 20 / 0.45)" />

        {/* LEFT ARM — raised up holding balloon string */}
        {/* Hand endpoint local≈(20,4) → global≈(123,126) — matches string path end */}
        <path d="M8 28 Q 8 12 20 4"
          stroke="currentColor" strokeWidth="2.25" strokeLinecap="round" fill="none" />

        {/* RIGHT ARM — waving outward */}
        <path d="M33 28 Q 44 20 42 12"
          stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" fill="none" />

        {/* LEGS — dangling/angled as if feet just leaving bench */}
        <path d="M12 62 C10 72, 8 76, 10 82"
          stroke="currentColor" strokeWidth="2.25" strokeLinecap="round" fill="none" />
        <path d="M26 62 C28 72, 30 76, 28 82"
          stroke="currentColor" strokeWidth="2.25" strokeLinecap="round" fill="none" />
      </g>

      {/* Small dots floating up like he is rising */}
      <g fill="currentColor" className="text-primary/30">
        <circle cx="145" cy="140" r="2.5" />
        <circle cx="152" cy="125" r="1.75" />
        <circle cx="148" cy="112" r="1.25" />
      </g>

      {/* Sketched plant beside bench */}
      <g stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" fill="none" className="text-primary/40">
        <path d="M50 205 Q 54 165 44 148" />
        <path d="M51 183 Q 63 178 58 168 Q 51 176 51 183" />
        <path d="M48 165 Q 35 160 38 150 Q 45 157 48 165" />
        <circle cx="44" cy="145" r="4" fill="currentColor" className="text-accent" />
      </g>
    </svg>
  );
}
