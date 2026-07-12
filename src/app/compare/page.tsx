import { createClient } from "@/lib/supabase/server";
import { ComparePageWrapper } from "@/components/ComparePageWrapper";
import { getLatestPrice } from "@/lib/medicine-utils";

export default async function ComparePage({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>
}) {
  const ids = (await searchParams).ids;
  let medicines: any[] = [];

  if (ids) {
    const idsArray = (typeof ids === 'string' ? ids.split(',') : ids).filter(Boolean);

    if (idsArray.length > 0) {
      const supabase = await createClient();
      const { data } = await supabase
        .from('medicines')
        .select(`
          id,
          brand_name,
          dosage_form,
          pack_size,
          prescription_required,
          category:categories(name),
          manufacturer:manufacturers(name, country),
          compositions:medicine_compositions(
            strength_value,
            strength_unit,
            generic:generics(name)
          ),
          prices:price_records(price, currency, recorded_at)
        `)
        .in('id', idsArray);

      if (data) {
        medicines = (data as any[]).map((med: any) => {
          const latestPriceObj = getLatestPrice(med.prices || []);
          return {
            id: med.id,
            brandName: med.brand_name,
            dosageForm: med.dosage_form,
            packSize: med.pack_size,
            rxRequired: med.prescription_required,
            category: med.category?.name,
            manufacturer: med.manufacturer?.name,
            compositions: med.compositions,
            price: latestPriceObj?.price,
            currency: latestPriceObj?.currency || 'PKR'
          };
        });
      }
    }
  }

  return (
    <div className="max-w-6xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
      <ComparePageWrapper medicines={medicines} />
    </div>
  );
}
