"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import { Search, Loader2, Pill, Activity } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export function SearchBar() {
  const [query, setQuery] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [suggestions, setSuggestions] = useState<any[]>([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [isLoadingSuggestions, setIsLoadingSuggestions] = useState(false);
  const [isMounted, setIsMounted] = useState(false);
  const router = useRouter();
  const wrapperRef = useRef<HTMLFormElement>(null);

  // Prevent hydration mismatch
  useEffect(() => {
    setIsMounted(true);
  }, []);

  // Close suggestions when clicking outside
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (wrapperRef.current && !wrapperRef.current.contains(event.target as Node)) {
        setShowSuggestions(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  // Fetch suggestions
  useEffect(() => {
    const fetchSuggestions = async () => {
      if (query.trim().length < 2) {
        setSuggestions([]);
        return;
      }
      setIsLoadingSuggestions(true);
      try {
        const res = await fetch(`/api/search/suggestions?q=${encodeURIComponent(query)}`);
        if (res.ok) {
          const data = await res.json();
          setSuggestions(data.suggestions || []);
        }
      } catch (err) {
        console.error(err);
      } finally {
        setIsLoadingSuggestions(false);
      }
    };

    const timer = setTimeout(() => {
      fetchSuggestions();
    }, 300); // debounce

    return () => clearTimeout(timer);
  }, [query]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (!query.trim()) return;
    setIsSearching(true);
    setShowSuggestions(false);
    router.push(`/search?q=${encodeURIComponent(query.trim())}`);
  };

  const handleSuggestionClick = (suggestion: any) => {
    setIsSearching(true);
    setShowSuggestions(false);
    // Always go to search results - users want to see all matching medicines
    // NOT jump to detail page - that breaks context
    router.push(`/search?q=${encodeURIComponent(suggestion.text)}`);
  };

  return (
    <form ref={wrapperRef} onSubmit={handleSearch} className="relative w-full max-w-2xl mx-auto flex flex-col">
      <div className="relative flex items-center shadow-lg rounded-full overflow-hidden bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 transition-colors duration-300">
        <div className="absolute left-4 text-slate-400 dark:text-slate-500">
          <Search className="w-5 h-5" />
        </div>
        <Input
          value={query}
          onChange={(e) => {
            setQuery(e.target.value);
            setShowSuggestions(true);
          }}
          onFocus={() => setShowSuggestions(true)}
          placeholder="Search for a medicine (e.g. Panadol) or salt (e.g. Paracetamol)..."
          className="w-full border-none shadow-none pl-12 pr-24 h-14 text-lg focus-visible:ring-0 rounded-full bg-transparent dark:text-slate-50 placeholder:text-slate-400 dark:placeholder:text-slate-500"
        />
        <div className="absolute right-1">
          <Button
            type="submit"
            disabled={isSearching || !query.trim()}
            className="rounded-full bg-[#0D7377] hover:bg-[#14A3A8] text-white h-12 px-6 font-semibold dark:bg-teal-600 dark:hover:bg-teal-500 transition-colors duration-200"
          >
            {isSearching ? <Loader2 className="w-5 h-5 animate-spin" /> : "Search"}
          </Button>
        </div>
      </div>

      {/* Suggestions Dropdown - Only render after mount */}
      {isMounted && showSuggestions && query.trim().length >= 2 && (
        <div className="mt-2 w-full bg-white dark:bg-slate-800 rounded-xl shadow-xl border border-slate-200 dark:border-slate-700 overflow-hidden transition-colors duration-300">
          {isLoadingSuggestions && suggestions.length === 0 ? (
            <div className="p-4 text-center text-slate-500 dark:text-slate-400 text-sm flex items-center justify-center gap-2">
              <Loader2 className="w-4 h-4 animate-spin" /> Loading suggestions...
            </div>
          ) : suggestions.length > 0 ? (
            <ul className="py-2">
              {suggestions.map((s, idx) => (
                <li key={`${s.type}-${s.id}-${idx}`}>
                  <button
                    type="button"
                    onClick={() => handleSuggestionClick(s)}
                    className="w-full text-left px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-700 flex items-center gap-3 transition-colors border-b border-slate-50 dark:border-slate-700 last:border-0"
                  >
                    <div className={`w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${s.type === 'generic' ? 'bg-emerald-100 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400' : 'bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400'}`}>
                      {s.type === 'generic' ? <Activity className="w-4 h-4" /> : <Pill className="w-4 h-4" />}
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-semibold text-slate-900 dark:text-slate-50 truncate">{s.text}</p>
                      <p className="text-xs text-slate-500 dark:text-slate-400 truncate">{s.subtext}</p>
                    </div>
                  </button>
                </li>
              ))}
            </ul>
          ) : !isLoadingSuggestions ? (
            <div className="p-4 text-center text-slate-500 dark:text-slate-400 text-sm">
              No exact matches found. Press Search to look for related medicines.
            </div>
          ) : null}
        </div>
      )}
    </form>
  );
}
