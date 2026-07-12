"use client";

import dynamic from "next/dynamic";

const NearbyPharmacies = dynamic(
  () => import("@/components/NearbyPharmacies").then((m) => ({ default: m.NearbyPharmacies })),
  {
    ssr: false,
    loading: () => (
      <div className="h-40 flex items-center justify-center text-sm text-muted-foreground">
        Loading map…
      </div>
    ),
  }
);

export function PharmaciesMapClient() {
  return <NearbyPharmacies />;
}
