import { MapPin } from "lucide-react";
import { BackButton } from "@/components/BackButton";
import { PharmaciesMapClient } from "@/components/PharmaciesMapClient";

export const metadata = {
  title: "Find Nearby Pharmacies — DawaCompare",
  description: "Locate pharmacies near you in Pakistan using your GPS location or select a major city.",
};

export default function PharmaciesPage() {
  return (
    <div className="min-h-screen bg-transparent">
      <div className="max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="mb-6">
          <BackButton />
        </div>

        {/* Page header */}
        <div className="relative overflow-hidden bg-card border border-border rounded-2xl p-6 md:p-8 mb-8 transition-colors duration-300">
          <div className="flex items-start gap-4">
            <div className="w-12 h-12 rounded-2xl bg-primary/10 flex items-center justify-center shrink-0">
              <MapPin className="w-6 h-6 text-primary" />
            </div>
            <div>
              <h1 className="text-2xl md:text-3xl font-extrabold text-foreground tracking-tight mb-2">
                Find Nearby Pharmacies
              </h1>
              <p className="text-sm text-muted-foreground font-medium leading-relaxed max-w-xl">
                Use your location or select a city to find pharmacies near you. Data sourced from OpenStreetMap.{" "}
                <strong className="text-foreground">Stock availability is not guaranteed</strong> — always call ahead to confirm.
              </p>
            </div>
          </div>

          {/* Decorative background dots */}
          <div className="absolute top-4 right-4 opacity-10 pointer-events-none select-none">
            <svg width="80" height="80" viewBox="0 0 80 80" fill="none">
              {[0, 16, 32, 48, 64].map((x) =>
                [0, 16, 32, 48, 64].map((y) => (
                  <circle key={x + "-" + y} cx={x + 4} cy={y + 4} r="2.5" fill="currentColor" className="text-primary" />
                ))
              )}
            </svg>
          </div>
        </div>

        {/* Map — rendered client-side */}
        <div className="bg-card border border-border rounded-2xl p-5 shadow-xs transition-colors duration-300">
          <PharmaciesMapClient />
        </div>

        {/* Coverage disclaimer */}
        <div className="mt-6 p-4 bg-muted/30 border border-border/60 rounded-xl text-xs text-muted-foreground font-medium leading-relaxed">
          <strong className="text-foreground">Coverage note:</strong> Pharmacy data is community-contributed via OpenStreetMap and may be incomplete in smaller cities and towns.
          Major cities (Karachi, Lahore, Islamabad, Rawalpindi) have the best coverage. If your local pharmacy is missing, you can{" "}
          <a href="https://www.openstreetmap.org" target="_blank" rel="noopener noreferrer" className="text-primary hover:underline">
            add it on OpenStreetMap ↗
          </a>
          .
        </div>
      </div>
    </div>
  );
}
