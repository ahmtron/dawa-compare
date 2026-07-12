"use client";

import { useState } from "react";
import dynamic from "next/dynamic";
import { MapPin, ChevronDown } from "lucide-react";

// Leaflet is browser-only — load dynamically with no SSR
const NearbyPharmacies = dynamic(
  () => import("./NearbyPharmacies").then((m) => ({ default: m.NearbyPharmacies })),
  { ssr: false, loading: () => <div className="h-24 flex items-center justify-center text-sm text-muted-foreground">Loading map…</div> }
);

export function NearbyPharmaciesSection({ medicineName }: { medicineName: string }) {
  const [open, setOpen] = useState(false);

  return (
    <div className="bg-card border border-border rounded-2xl overflow-hidden shadow-xs transition-colors duration-300">
      {/* Header — always visible, click to toggle */}
      <button
        onClick={() => setOpen((o) => !o)}
        className="w-full flex items-center justify-between p-5 hover:bg-muted/30 transition-colors duration-200 text-left group"
      >
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-xl bg-primary/10 flex items-center justify-center shrink-0">
            <MapPin className="w-4 h-4 text-primary" />
          </div>
          <div>
            <p className="text-sm font-extrabold text-foreground tracking-tight">Find Nearby Pharmacies</p>
            <p className="text-xs text-muted-foreground font-medium mt-0.5">
              Locate pharmacies near you that may carry this medicine
            </p>
          </div>
        </div>
        <ChevronDown
          className={"w-4 h-4 text-muted-foreground transition-transform duration-300 shrink-0 " + (open ? "rotate-180" : "")}
        />
      </button>

      {/* Collapsible body — Leaflet only loads when first opened */}
      {open && (
        <div className="px-5 pb-5 border-t border-border/60">
          <div className="pt-4">
            <NearbyPharmacies medicineName={medicineName} />
          </div>
        </div>
      )}
    </div>
  );
}
