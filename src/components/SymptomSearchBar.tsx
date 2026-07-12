"use client";

import { useState, useEffect } from "react";
import { Search, Loader2, AlertCircle, Sparkles } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { MedicineCard } from "@/components/MedicineCard";

export function SymptomSearchBar() {
  const [query, setQuery] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [results, setResults] = useState<any[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [escalateMessage, setEscalateMessage] = useState<string | null>(null);
  const [isMounted, setIsMounted] = useState(false);

  useEffect(() => {
    setIsMounted(true);
  }, []);

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!query.trim()) return;
    
    setIsSearching(true);
    setError(null);
    setEscalateMessage(null);
    setResults(null);
    
    try {
      const res = await fetch("/api/ai/symptom-search", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ query: query.trim() }),
      });
      
      const data = await res.json();
      
      if (!res.ok) throw new Error(data.error || "Failed to search symptoms");
      
      if (data.escalate) {
        setEscalateMessage(data.message);
      } else {
        setResults(data.medicines || []);
      }
    } catch (err: any) {
      setError(err.message);
    } finally {
      setIsSearching(false);
    }
  };

  return (
    <div className="w-full max-w-4xl mx-auto">
      <div className="bg-purple-500/5 dark:bg-purple-500/10 border border-purple-500/15 rounded-2xl p-6 md:p-8 shadow-xs transition-colors duration-300">
        <div className="flex items-center gap-2 mb-2">
          <Sparkles className="w-5 h-5 text-purple-600 dark:text-purple-400" />
          <h2 className="text-lg font-bold text-purple-800 dark:text-purple-200">Not sure what you need?</h2>
        </div>
        <p className="text-purple-700/80 dark:text-purple-300/80 text-sm mb-6 leading-relaxed font-medium">
          Describe your symptoms in plain English, and our AI will suggest relevant medicine categories. <span className="italic">(Not medical advice)</span>
        </p>
        
        <form onSubmit={handleSearch} className="relative flex items-center shadow-sm rounded-xl overflow-hidden bg-card border border-border transition-colors duration-300">
          <Input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="e.g., I have a bad headache and fever..."
            className="w-full border-none shadow-none pl-4 pr-24 h-12 text-base focus-visible:ring-0 bg-transparent text-foreground placeholder:text-muted-foreground"
          />
          <div className="absolute right-1">
            <Button 
              type="submit" 
              disabled={isSearching || !query.trim()}
              className="bg-purple-600 hover:bg-purple-700 dark:bg-purple-500 dark:hover:bg-purple-400 text-white h-10 px-4 font-semibold text-sm rounded-lg active:scale-95 transition-all duration-200"
            >
              {isSearching ? <Loader2 className="w-4 h-4 animate-spin mr-2" /> : <Search className="w-4 h-4 mr-2" />}
              Ask AI
            </Button>
          </div>
        </form>

        {escalateMessage && (
          <div className="mt-6 bg-destructive/10 border border-destructive/20 rounded-xl p-4 flex gap-3 text-destructive transition-colors duration-300 animate-fade-in">
            <AlertCircle className="w-6 h-6 shrink-0 animate-pulse" />
            <div>
              <p className="font-bold text-sm">Medical Alert</p>
              <p className="text-sm mt-1 opacity-90">{escalateMessage}</p>
            </div>
          </div>
        )}

        {error && (
          <div className="mt-6 text-destructive text-sm text-center font-semibold">{error}</div>
        )}
      </div>

      {isMounted && results !== null && !escalateMessage && (
        <div className="mt-8 animate-fade-in">
          <h3 className="text-lg font-extrabold text-foreground mb-4">AI Suggested Medicines</h3>
          {results.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {results.map((med) => (
                <MedicineCard
                  key={med.id}
                  id={med.id}
                  brandName={med.brandName}
                  category={med.category}
                  price={med.price}
                  currency={med.currency}
                  isAiAssisted={med.isAiAssisted}
                />
              ))}
            </div>
          ) : (
            <div className="text-center py-8 bg-card rounded-xl border border-border transition-colors duration-300">
              <p className="text-muted-foreground font-semibold text-sm">No specific medicines found for these symptoms in our database.</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
