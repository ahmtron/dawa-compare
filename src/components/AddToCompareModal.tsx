'use client';

import { useState, useEffect, useRef } from 'react';
import { Search, X, Loader2, Plus } from 'lucide-react';
import { Input } from '@/components/ui/input';

interface AddToCompareModalProps {
  onClose: () => void;
  onAddMedicine: (medicineId: string, name: string) => void;
  existingMedicineIds?: string[];
}

export function AddToCompareModal({
  onClose,
  onAddMedicine,
  existingMedicineIds = [],
}: AddToCompareModalProps) {
  const [query, setQuery] = useState('');
  const [suggestions, setSuggestions] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isMounted, setIsMounted] = useState(false);
  const wrapperRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setIsMounted(true);
  }, []);

  // Close on Escape key
  useEffect(() => {
    const handleEscape = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    document.addEventListener('keydown', handleEscape);
    return () => document.removeEventListener('keydown', handleEscape);
  }, [onClose]);

  // Close on backdrop click
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (wrapperRef.current === e.target) {
        onClose();
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [onClose]);

  // Fetch suggestions
  useEffect(() => {
    const fetchSuggestions = async () => {
      if (query.trim().length < 2) {
        setSuggestions([]);
        return;
      }
      setIsLoading(true);
      try {
        const res = await fetch(`/api/search/suggestions?q=${encodeURIComponent(query)}`);
        if (res.ok) {
          const data = await res.json();
          setSuggestions(data.suggestions || []);
        }
      } catch (err) {
        console.error(err);
      } finally {
        setIsLoading(false);
      }
    };

    const timer = setTimeout(fetchSuggestions, 300);
    return () => clearTimeout(timer);
  }, [query]);

  const handleAddMedicine = (suggestion: any) => {
    if (suggestion.type === 'medicine') {
      onAddMedicine(suggestion.id, suggestion.text);
      setQuery('');
      setSuggestions([]);
    }
  };

  if (!isMounted) return null;

  const isAlreadyAdded = (id: string) => existingMedicineIds.includes(id);

  return (
    <div
      ref={wrapperRef}
      className="fixed inset-0 bg-black/60 backdrop-blur-xs flex items-center justify-center z-50 p-4 animate-fade-in"
    >
      <div className="bg-card text-card-foreground rounded-xl border border-border shadow-2xl max-w-md w-full overflow-hidden transition-all duration-300">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-border">
          <h2 className="font-bold text-foreground">Add Medicine to Compare</h2>
          <button
            onClick={onClose}
            className="p-1 hover:bg-muted text-muted-foreground hover:text-foreground rounded-lg transition-colors"
            aria-label="Close"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Search Input */}
        <div className="p-4 border-b border-border">
          <div className="relative flex items-center">
            <Search className="absolute left-3 w-5 h-5 text-muted-foreground" />
            <Input
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search by brand or salt..."
              className="pl-10 rounded-lg bg-background border-border text-foreground placeholder:text-muted-foreground focus-visible:ring-1 focus-visible:ring-primary focus-visible:border-primary"
              autoFocus
            />
          </div>
        </div>

        {/* Suggestions List */}
        <div className="max-h-96 overflow-y-auto">
          {isLoading && query.length >= 2 && (
            <div className="p-6 text-center text-muted-foreground text-sm flex items-center justify-center gap-2">
              <Loader2 className="w-4 h-4 animate-spin text-primary" /> Searching...
            </div>
          )}

          {query.length >= 2 && suggestions.length === 0 && !isLoading && (
            <div className="p-6 text-center text-muted-foreground text-sm">
              No medicines found for "{query}"
            </div>
          )}

          {query.length < 2 && (
            <div className="p-6 text-center text-muted-foreground text-sm">
              Type at least 2 characters to search
            </div>
          )}

          {suggestions.length > 0 && (
            <ul className="divide-y divide-border/60">
              {suggestions
                .filter((s) => s.type === 'medicine') // Only show medicines in compare modal
                .map((suggestion, idx) => {
                  const alreadyAdded = isAlreadyAdded(suggestion.id);
                  return (
                    <li key={`${suggestion.type}-${suggestion.id}-${idx}`}>
                      <button
                        onClick={() => handleAddMedicine(suggestion)}
                        disabled={alreadyAdded}
                        className={`w-full text-left px-4 py-3.5 flex items-center gap-3 transition-colors ${
                          alreadyAdded
                            ? 'bg-muted/10 text-muted-foreground cursor-not-allowed'
                            : 'hover:bg-muted/40 active:bg-muted'
                        }`}
                      >
                        <div className={`w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${
                          alreadyAdded
                            ? 'bg-muted text-muted-foreground/60'
                            : 'bg-primary/10 text-primary'
                        }`}>
                          {alreadyAdded ? '✓' : <Plus className="w-4 h-4" />}
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-bold text-foreground truncate">
                            {suggestion.text}
                          </p>
                          <p className="text-xs text-muted-foreground truncate font-medium mt-0.5">{suggestion.subtext}</p>
                        </div>
                      </button>
                    </li>
                  );
                })}
            </ul>
          )}
        </div>

        {/* Footer */}
        <div className="p-4 border-t border-border bg-muted/20 rounded-b-xl">
          <button
            onClick={onClose}
            className="w-full px-4 py-2 bg-card border border-border/45 hover:border-border text-foreground font-semibold hover:bg-muted rounded-lg transition-all active:scale-98"
          >
            Done
          </button>
        </div>
      </div>
    </div>
  );
}
