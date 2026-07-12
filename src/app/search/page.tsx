import { createClient } from "@/lib/supabase/server";
import { SearchBar } from "@/components/SearchBar";
import { BackButton } from "@/components/BackButton";
import { SearchResults } from "@/components/SearchResults";
import { getLatestPrice } from "@/lib/medicine-utils";
import { SearchIllustration } from "@/components/illustrations/SearchIllustration";

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>
}) {
  const query = (await searchParams).q as string;
  const supabase = await createClient();

  let medicines: any[] = [];

  if (query) {
    // 1. First search by brand name
    const { data: brandData } = await supabase
      .from('medicines')
      .select(`
        id,
        brand_name,
        dosage_form,
        pack_size,
        prescription_required,
        category:categories(name),
        compositions:medicine_compositions(
          generic:generics(name)
        ),
        prices:price_records(price, currency)
      `)
      .eq('is_active', true)
      .ilike('brand_name', `%${query}%`)
      .limit(20);

    // 2. If few results, try searching by generic name
    let genericMedData: any[] = [];
    if (!brandData || brandData.length < 5) {
      // Find matching generics
      const { data: genericMatches } = await supabase
        .from('generics')
        .select('id')
        .ilike('name', `%${query}%`);

      if (genericMatches && genericMatches.length > 0) {
        const genericIds = genericMatches.map(g => g.id);
        const { data: compMeds } = await supabase
          .from('medicine_compositions')
          .select(`
            medicine:medicines(
              id, brand_name,
              dosage_form,
              pack_size,
              prescription_required,
              category:categories(name),
              prices:price_records(price, currency)
            )
          `)
          .in('generic_id', genericIds)
          .limit(20);

        if (compMeds) {
          genericMedData = (compMeds as any[])
            .map((c: any) => c.medicine)
            .filter((m: any) => m !== null && m.id !== undefined && !(brandData as any[])?.find((b: any) => b.id === m.id));
        }
      }
    }

    const combinedData = [...(brandData || []), ...genericMedData].slice(0, 20);

    if (combinedData) {
      medicines = combinedData.map((med: any) => {
        const latestPrice = getLatestPrice(med.prices);
        return {
          id: med.id,
          brandName: med.brand_name,
          category: med.category?.name,
          genericName: med.compositions?.[0]?.generic?.name,
          price: latestPrice?.price,
          currency: latestPrice?.currency,
          dosageForm: med.dosage_form,
          packSize: med.pack_size,
          rxRequired: med.prescription_required,
        };
      });
    }
  }

  return (
    <div className="min-h-screen bg-transparent transition-colors duration-300">
      <div className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Back Button and Search Bar */}
        <div className="flex items-center gap-4 mb-8">
          <BackButton />
          <div className="flex-1">
            <SearchBar />
          </div>
        </div>

        {/* Banner with Search Illustration */}
        <div className="relative overflow-hidden bg-card text-card-foreground rounded-2xl border border-border p-6 md:p-8 mb-8 flex flex-col md:flex-row items-center justify-between gap-6 transition-colors duration-300">
          <div className="space-y-3 max-w-lg text-left">
            <h2 className="text-3xl font-extrabold text-foreground tracking-tight">
              {query ? `Search Results for "${query}"` : "Search Medicines"}
            </h2>
            <p className="text-sm text-muted-foreground font-medium leading-relaxed">
              Compare chemical compositions, verify maximum retail prices, and find alternative brands with identical generic formulas.
            </p>
          </div>
          <div className="w-full md:w-60 h-40 shrink-0 flex items-center justify-center">
            <SearchIllustration />
          </div>
        </div>

        {query && medicines.length === 0 ? (
          <div className="text-center py-12 bg-card rounded-xl border border-border transition-colors duration-300">
            <p className="text-lg font-semibold text-foreground mb-2">No results found for "{query}".</p>
            <p className="text-muted-foreground text-sm">Try searching by generic name (salt formula) instead.</p>
          </div>
        ) : (
          <SearchResults medicines={medicines} query={query} />
        )}
      </div>
    </div>
  );
}
