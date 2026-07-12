import { NextResponse } from "next/server";
import { geminiModel } from "@/lib/gemini";
import { createClient } from "@/lib/supabase/server";

export async function POST(req: Request) {
  try {
    const { genericId } = await req.json();

    if (!genericId) {
      return NextResponse.json({ error: "Missing genericId" }, { status: 400 });
    }

    const supabase = await createClient();
    
    // Fetch side effects from DB
    const { data: sideEffects, error } = await supabase
      .from("side_effects")
      .select("description")
      .eq("generic_id", genericId);

    if (error || !sideEffects || sideEffects.length === 0) {
      return NextResponse.json({ summary: "No side effects information available." });
    }

    const effectsText = sideEffects.map(s => s.description).join(", ");

    const prompt = `
      You are a helpful medical assistant for DawaCompare.
      Your task is to explain the following clinical side effects in plain, easy-to-understand language for a non-medical person.
      Do not give medical advice. Do not invent side effects. Just simplify the following list.
      Keep it brief (under 100 words).
      
      Side effects: ${effectsText}
    `;

    const result = await geminiModel.generateContent(prompt);
    const summary = result.response.text();

    return NextResponse.json({ summary });
  } catch (error) {
    console.error("AI side effect error:", error);
    return NextResponse.json({ error: "Failed to generate summary" }, { status: 500 });
  }
}
