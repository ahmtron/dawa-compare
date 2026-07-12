import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const q = searchParams.get('q');

  if (!q || q.length < 2) {
    return NextResponse.json({ suggestions: [] });
  }

  try {
    const supabase = await createClient();

    console.log(`🔍 Searching for: "${q}"`);

    // We want to suggest both Brand Names and Generic Salts
    const medicinesRes = await supabase
      .from('medicines')
      .select('id, brand_name, category:categories(name)')
      .ilike('brand_name', `%${q}%`)
      .eq('is_active', true)
      .limit(5);

    const genericsRes = await supabase
      .from('generics')
      .select('id, name')
      .ilike('name', `%${q}%`)
      .limit(3);

    console.log(`📊 Medicines results:`, medicinesRes);
    console.log(`📊 Generics results:`, genericsRes);

    const suggestions = [];

    if (genericsRes.error) {
      console.error("Generics error:", genericsRes.error);
    } else if (genericsRes.data) {
      for (const gen of genericsRes.data as any[]) {
        suggestions.push({
          type: 'generic',
          id: gen.id,
          text: gen.name,
          subtext: 'Salt Formula'
        });
      }
    }

    if (medicinesRes.error) {
      console.error("Medicines error:", medicinesRes.error);
    } else if (medicinesRes.data) {
      for (const med of medicinesRes.data as any[]) {
        suggestions.push({
          type: 'medicine',
          id: med.id,
          text: med.brand_name,
          subtext: med.category?.name || 'Medicine'
        });
      }
    }

    console.log(`✅ Found ${suggestions.length} suggestions`);
    return NextResponse.json({ suggestions });
  } catch (error) {
    console.error("Suggestions error:", error);
    return NextResponse.json({ suggestions: [], error: String(error) }, { status: 500 });
  }
}
