"use client";

import { useState, useEffect, useRef } from "react";
import { MapPin, Navigation, Loader2, AlertCircle, ChevronDown } from "lucide-react";

interface Pharmacy {
  id: number;
  name: string;
  lat: number;
  lng: number;
  address: string;
}

const PRESET_CITIES: { label: string; lat: number; lng: number }[] = [
  { label: "Karachi", lat: 24.8607, lng: 67.0011 },
  { label: "Lahore", lat: 31.5204, lng: 74.3587 },
  { label: "Islamabad", lat: 33.6844, lng: 73.0479 },
  { label: "Rawalpindi", lat: 33.5651, lng: 73.0169 },
  { label: "Peshawar", lat: 34.0151, lng: 71.5249 },
  { label: "Quetta", lat: 30.1798, lng: 66.975 },
  { label: "Multan", lat: 30.1575, lng: 71.5249 },
  { label: "Faisalabad", lat: 31.4504, lng: 73.135 },
];

function haversineKm(lat1: number, lng1: number, lat2: number, lng2: number) {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLng = ((lng2 - lng1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLng / 2) ** 2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

export function NearbyPharmacies({ medicineName }: { medicineName?: string }) {
  const mapRef = useRef<HTMLDivElement>(null);
  const leafletMapRef = useRef<any>(null);
  const markersRef = useRef<any[]>([]);

  const [status, setStatus] = useState<"idle" | "locating" | "loading" | "success" | "error">("idle");
  const [pharmacies, setPharmacies] = useState<Pharmacy[]>([]);
  const [userLat, setUserLat] = useState<number | null>(null);
  const [userLng, setUserLng] = useState<number | null>(null);
  const [errorMsg, setErrorMsg] = useState("");
  const [selectedId, setSelectedId] = useState<number | null>(null);
  const [cityDropdownOpen, setCityDropdownOpen] = useState(false);

  // Initialise Leaflet once we have a position
  useEffect(() => {
    if (userLat === null || userLng === null || !mapRef.current) return;
    if (leafletMapRef.current) {
      leafletMapRef.current.setView([userLat, userLng], 14);
      return;
    }

    // Dynamically load leaflet CSS + JS
    const link = document.createElement("link");
    link.rel = "stylesheet";
    link.href = "https://unpkg.com/leaflet@1.9.4/dist/leaflet.css";
    document.head.appendChild(link);

    import("leaflet").then((L) => {
      if (!mapRef.current || leafletMapRef.current) return;

      const map = L.map(mapRef.current, { zoomControl: true }).setView([userLat, userLng], 14);
      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: '© <a href="https://openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19,
      }).addTo(map);

      // User location marker
      L.circleMarker([userLat, userLng], {
        radius: 10,
        fillColor: "oklch(0.55 0.18 200)",
        color: "white",
        weight: 3,
        fillOpacity: 0.9,
      })
        .addTo(map)
        .bindPopup("<b>You are here</b>")
        .openPopup();

      leafletMapRef.current = map;
      fetchPharmacies(userLat, userLng, map, L);
    });
  }, [userLat, userLng]);

  const fetchPharmacies = async (lat: number, lng: number, map: any, L: any) => {
    setStatus("loading");
    try {
      const res = await fetch(`/api/pharmacies/nearby?lat=${lat}&lng=${lng}&radius=2000`);
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? "Unknown error");

      const results: Pharmacy[] = data.pharmacies ?? [];

      // Clear old markers
      markersRef.current.forEach((m) => map.removeLayer(m));
      markersRef.current = [];

      // Custom pharmacy icon
      const icon = L.divIcon({
        className: "",
        html: `<div style="background:oklch(0.55 0.18 200);width:28px;height:28px;border-radius:50% 50% 50% 0;border:2px solid white;transform:rotate(-45deg);box-shadow:0 2px 6px rgba(0,0,0,0.3)"></div>`,
        iconSize: [28, 28],
        iconAnchor: [14, 28],
      });

      results.forEach((p) => {
        const marker = L.marker([p.lat, p.lng], { icon })
          .addTo(map)
          .bindPopup(
            `<div style="min-width:160px">
              <b style="font-size:13px">${p.name}</b><br/>
              <span style="font-size:11px;color:#666">${p.address}</span><br/>
              <a href="https://www.google.com/maps/dir/?api=1&destination=${p.lat},${p.lng}" target="_blank"
                style="font-size:11px;color:#0ea5e9;margin-top:4px;display:inline-block">
                Open in Google Maps ↗
              </a>
            </div>`
          );
        markersRef.current.push(marker);
      });

      setPharmacies(
        results
          .map((p) => ({ ...p, dist: haversineKm(lat, lng, p.lat, p.lng) }))
          .sort((a: any, b: any) => a.dist - b.dist) as any
      );
      setStatus("success");
    } catch (err: any) {
      setErrorMsg(err.message ?? "Failed to fetch pharmacies.");
      setStatus("error");
    }
  };

  const handleGeolocation = () => {
    setStatus("locating");
    setErrorMsg("");
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        setUserLat(pos.coords.latitude);
        setUserLng(pos.coords.longitude);
      },
      (err) => {
        setStatus("error");
        setErrorMsg(
          err.code === 1
            ? "Location access denied. Please select a city from the dropdown instead."
            : "Could not determine your location. Try selecting a city manually."
        );
      },
      { timeout: 10000, enableHighAccuracy: false }
    );
  };

  const handleCitySelect = (city: { label: string; lat: number; lng: number }) => {
    setCityDropdownOpen(false);
    setErrorMsg("");
    setUserLat(city.lat);
    setUserLng(city.lng);
  };

  const panToPharmacy = (p: Pharmacy) => {
    setSelectedId(p.id);
    if (leafletMapRef.current) {
      leafletMapRef.current.setView([p.lat, p.lng], 17, { animate: true });
      markersRef.current.find((m: any) => {
        const ll = m.getLatLng();
        return Math.abs(ll.lat - p.lat) < 0.0001 && Math.abs(ll.lng - p.lng) < 0.0001;
      })?.openPopup();
    }
  };

  return (
    <div className="space-y-4">
      {/* Controls */}
      <div className="flex flex-wrap items-center gap-3">
        <button
          onClick={handleGeolocation}
          disabled={status === "locating" || status === "loading"}
          className="inline-flex items-center gap-2 px-4 py-2 bg-primary text-primary-foreground rounded-lg text-sm font-semibold hover:bg-primary/90 active:scale-95 transition-all duration-200 disabled:opacity-60 disabled:cursor-not-allowed shadow-xs"
        >
          {status === "locating" ? (
            <Loader2 className="w-4 h-4 animate-spin" />
          ) : (
            <Navigation className="w-4 h-4" />
          )}
          Use My Location
        </button>

        {/* City dropdown */}
        <div className="relative">
          <button
            onClick={() => setCityDropdownOpen((o) => !o)}
            className="inline-flex items-center gap-2 px-4 py-2 bg-card border border-border rounded-lg text-sm font-semibold text-foreground hover:bg-muted/40 transition-all duration-200"
          >
            <MapPin className="w-4 h-4 text-primary" />
            Select City
            <ChevronDown className={"w-3.5 h-3.5 text-muted-foreground transition-transform " + (cityDropdownOpen ? "rotate-180" : "")} />
          </button>
          {cityDropdownOpen && (
            <div className="absolute top-full left-0 mt-1 z-50 bg-card border border-border rounded-xl shadow-lg py-1 min-w-[160px]">
              {PRESET_CITIES.map((city) => (
                <button
                  key={city.label}
                  onClick={() => handleCitySelect(city)}
                  className="w-full text-left px-4 py-2 text-sm font-medium text-foreground hover:bg-muted/60 transition-colors"
                >
                  {city.label}
                </button>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Error state */}
      {status === "error" && (
        <div className="flex items-start gap-3 p-4 bg-destructive/8 border border-destructive/20 rounded-xl text-sm text-destructive font-medium">
          <AlertCircle className="w-4 h-4 shrink-0 mt-0.5" />
          <span>{errorMsg}</span>
        </div>
      )}

      {/* Map */}
      {(status === "loading" || status === "success") && (
        <div className="relative rounded-xl overflow-hidden border border-border shadow-xs">
          {status === "loading" && (
            <div className="absolute inset-0 bg-muted/60 backdrop-blur-sm z-10 flex items-center justify-center gap-2 text-sm font-medium text-muted-foreground">
              <Loader2 className="w-5 h-5 animate-spin text-primary" />
              Finding nearby pharmacies…
            </div>
          )}
          <div ref={mapRef} className="w-full h-64 sm:h-80" />
        </div>
      )}

      {/* Results list */}
      {status === "success" && pharmacies.length > 0 && (
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-xs">
          <div className="px-4 py-3 border-b border-border bg-muted/30">
            <p className="text-xs font-bold text-muted-foreground uppercase tracking-wider">
              {pharmacies.length} pharmacies within 2 km
              {medicineName && <span className="text-primary"> · {medicineName}</span>}
            </p>
          </div>
          <ul className="divide-y divide-border/60 max-h-60 overflow-y-auto">
            {pharmacies.map((p: any) => (
              <li key={p.id}>
                <button
                  onClick={() => panToPharmacy(p)}
                  className={"w-full text-left px-4 py-3 flex items-start gap-3 hover:bg-muted/40 transition-colors " + (selectedId === p.id ? "bg-primary/5" : "")}
                >
                  <MapPin className={"w-4 h-4 shrink-0 mt-0.5 " + (selectedId === p.id ? "text-primary" : "text-muted-foreground")} />
                  <div className="min-w-0 flex-1">
                    <p className="text-sm font-bold text-foreground truncate">{p.name}</p>
                    <p className="text-xs text-muted-foreground truncate mt-0.5">{p.address}</p>
                  </div>
                  <span className="text-xs font-semibold text-primary shrink-0">
                    {p.dist?.toFixed(1)} km
                  </span>
                </button>
              </li>
            ))}
          </ul>
        </div>
      )}

      {status === "success" && pharmacies.length === 0 && (
        <div className="text-center py-8 text-sm text-muted-foreground font-medium">
          No pharmacies found within 2 km. Try selecting a different area.
        </div>
      )}

      {/* Disclaimer */}
      {(status === "success" || status === "loading") && (
        <p className="text-[11px] text-muted-foreground/70 flex items-start gap-1.5">
          <MapPin className="w-3 h-3 shrink-0 mt-0.5" />
          Directory data from OpenStreetMap. Stock availability is not guaranteed. Verify by calling ahead.
        </p>
      )}
    </div>
  );
}
