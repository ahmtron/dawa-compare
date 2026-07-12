import { NextResponse } from "next/server";
import { geminiModel } from "@/lib/gemini";
import { createClient } from "@/lib/supabase/server";
import { getLatestPrice } from "@/lib/medicine-utils";

export async function POST(req: Request) {
  try {
    const { query } = await req.json();

    if (!query) {
      return NextResponse.json({ error: "Missing query" }, { status: 400 });
    }

    const prompt = `
      You are a helpful medical routing assistant for DawaCompare Pakistan.
      A user describes their symptoms: "${query}"
      
      Your task is to identify the most likely therapeutic categories and generic salt names that treat these symptoms.
      
      CRITICAL RULES:
      1. NEVER diagnose the user.
      2. NEVER suggest dosage, frequency, or duration.
      3. If the symptoms indicate a medical emergency (e.g., chest pain, severe bleeding, difficulty breathing, stroke symptoms), set "escalate" to true and return empty arrays.
      4. Only return a valid JSON object in the exact format below, with NO markdown formatting or extra text:
      {
        "categories": ["string", "string"],
        "generics": ["string", "string"],
        "escalate": boolean
      }
    `;

    const result = await geminiModel.generateContent(prompt);
    let textResult = result.response.text().trim();
    
    // Clean up potential markdown formatting from Gemini
    if (textResult.startsWith("```json")) {
      textResult = textResult.replace(/^```json\n/, "").replace(/\n```$/, "");
    }
    
    const parsedData = JSON.parse(textResult);

    if (parsedData.escalate) {
      return NextResponse.json({ 
        escalate: true, 
        message: "Your symptoms may require immediate medical attention. Please consult a doctor or go to the nearest emergency room." 
      });
    }

    // Now query Supabase for medicines matching these generics/categories
    const supabase = await createClient();
    
    let matchedMedicines: any[] = [];
    
    if (parsedData.generics && parsedData.generics.length > 0) {
      // Find generic IDs
      const { data: generics } = await supabase
        .from("generics")
        .select("id")
        .in("name", parsedData.generics);
        
      if (generics && generics.length > 0) {
        const genericIds = generics.map(g => g.id);
        
        // Find medicines with these generics
        const { data: compositions } = await supabase
          .from("medicine_compositions")
          .select(`
            medicine:medicines(
              id, brand_name, 
              category:categories(name),
              prices:price_records(price, currency)
            )
          `)
          .in("generic_id", genericIds)
          .limit(10);
          
        if (compositions) {
          matchedMedicines = compositions.map((c: any) => {
            const latestPrice = getLatestPrice(c.medicine.prices);
            return {
              id: c.medicine.id,
              brandName: c.medicine.brand_name,
              category: c.medicine.category?.name,
              price: latestPrice?.price,
              currency: latestPrice?.currency,
              isAiAssisted: true
            };
          }).filter(m => m.id !== undefined);

          // Deduplicate
          matchedMedicines = matchedMedicines.filter((v, i, a) => a.findIndex(t => (t.id === v.id)) === i);
        }
      }
    }
    
    // If no specific generics matched, try categories
    if (matchedMedicines.length === 0 && parsedData.categories && parsedData.categories.length > 0) {
      const { data: categoryMeds } = await supabase
        .from("medicines")
        .select(`
          id, brand_name, 
          category:categories(name),
          prices:price_records(price, currency)
        `)
        .in("category_id", (
           await supabase.from("categories").select("id").in("name", parsedData.categories)
        ).data?.map(c => c.id) || [])
        .limit(10);
        
      if (categoryMeds) {
        matchedMedicines = categoryMeds.map((m: any) => {
          const latestPrice = getLatestPrice(m.prices);
          return {
            id: m.id,
            brandName: m.brand_name,
            category: m.category?.name,
            price: latestPrice?.price,
            currency: latestPrice?.currency,
            isAiAssisted: true
          };
        });
      }
    }

    return NextResponse.json({ 
      escalate: false,
      medicines: matchedMedicines,
      aiGenerics: parsedData.generics
    });
  } catch (error) {
    console.error("AI symptom search error:", error);
    return NextResponse.json({ error: "Failed to process symptom search" }, { status: 500 });
  }
}
