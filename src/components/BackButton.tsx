'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { ArrowLeft } from 'lucide-react';

export function BackButton() {
  const [isMounted, setIsMounted] = useState(false);
  const router = useRouter();

  // Prevent hydration mismatch
  useEffect(() => {
    setIsMounted(true);
  }, []);

  if (!isMounted) {
    return (
      <div className="flex items-center gap-2 px-4 py-2 text-muted-foreground rounded-lg text-sm font-semibold border border-transparent">
        <ArrowLeft className="w-4 h-4" />
        <span>Back</span>
      </div>
    );
  }

  return (
    <button
      onClick={() => router.back()}
      className="flex items-center gap-2 px-4 py-2 text-muted-foreground hover:text-foreground hover:bg-muted/40 border border-transparent hover:border-border active:scale-95 rounded-lg transition-all duration-200 font-semibold text-sm"
      aria-label="Go back"
    >
      <ArrowLeft className="w-4 h-4" />
      Back
    </button>
  );
}
