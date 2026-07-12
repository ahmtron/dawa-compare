import { NextRequest, NextResponse } from "next/server";
import { unstable_cache } from "next/cache";

interface PharmacyResult {
  id: number;
  name: string;
  lat: number;
  lng: number;
  address: string;
}

const fetchFromOverpass = async (lat: number, lng: number, radius: number): Promise<PharmacyResult[]> => {
  const query = `
    [out:json][timeout:20];
    node["amenity"="pharmacy"](around:${radius},${lat},${lng});
    out body;
  `;
  const url = `https://overpass-api.de/api/interpreter?data=${encodeURIComponent(query)}`;

  const res = await fetch(url, {
    next: { revalidate: 3600 }, // cache 1 hour at edge
    signal: AbortSignal.timeout(15000), // 15s timeout
  });

  if (!res.ok) throw new Error("Overpass API returned " + res.status);

  const data = await res.json();

  return (data.elements as any[]).map((el: any) => {
    const tags = el.tags ?? {};
    const parts = [
      tags["addr:housenumber"],
      tags["addr:street"],
      tags["addr:suburb"],
      tags["addr:city"],
    ].filter(Boolean);

    return {
      id: el.id,
      name: tags.name ?? tags["name:en"] ?? "Unnamed Pharmacy",
      lat: el.lat,
      lng: el.lon,
      address: parts.length > 0 ? parts.join(", ") : tags["addr:full"] ?? "Address unavailable",
    };
  });
};

export async function GET(req: NextRequest) {
  const { searchParams } = req.nextUrl;
  const lat = parseFloat(searchParams.get("lat") ?? "");
  const lng = parseFloat(searchParams.get("lng") ?? "");
  const radius = Math.min(parseInt(searchParams.get("radius") ?? "2000"), 5000);

  if (isNaN(lat) || isNaN(lng)) {
    return NextResponse.json(
      { error: "lat and lng query params are required and must be valid numbers." },
      { status: 400 }
    );
  }

  // Clamp to rough Pakistan bounding box as a sanity check
  if (lat < 23 || lat > 37 || lng < 60 || lng > 78) {
    return NextResponse.json(
      { error: "Coordinates appear to be outside Pakistan." },
      { status: 400 }
    );
  }

  try {
    // Cache keyed by ~500m grid cell to maximise cache hits
    const gridLat = Math.round(lat * 200) / 200;
    const gridLng = Math.round(lng * 200) / 200;
    const cacheKey = `pharmacies-${gridLat}-${gridLng}-${radius}`;

    const getCached = unstable_cache(
      () => fetchFromOverpass(lat, lng, radius),
      [cacheKey],
      { revalidate: 3600, tags: ["pharmacies"] }
    );

    const pharmacies = await getCached();
    return NextResponse.json({ pharmacies }, { status: 200 });
  } catch (err: any) {
    console.error("[pharmacies/nearby]", err?.message);
    return NextResponse.json(
      { error: "Failed to fetch pharmacies. The map service may be temporarily unavailable." },
      { status: 503 }
    );
  }
}
