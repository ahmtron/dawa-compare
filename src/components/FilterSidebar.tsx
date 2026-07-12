'use client';

import { useState, useEffect } from 'react';
import { ChevronDown, X } from 'lucide-react';

interface FilterState {
  priceMin: number | '';
  priceMax: number | '';
  categories: string[];
  dosageForms: string[];
  rxRequired: boolean | null;
}

interface FilterSidebarProps {
  onFilterChange: (filters: FilterState) => void;
  categories: string[];
  dosageForms: string[];
  isMobile?: boolean;
}

export function FilterSidebar({
  onFilterChange,
  categories = [],
  dosageForms = [],
  isMobile = false,
}: FilterSidebarProps) {
  const [isMounted, setIsMounted] = useState(false);
  const [isOpen, setIsOpen] = useState(!isMobile);
  const [filters, setFilters] = useState<FilterState>({
    priceMin: '',
    priceMax: '',
    categories: [],
    dosageForms: [],
    rxRequired: null,
  });

  // Prevent hydration mismatch
  useEffect(() => {
    setIsMounted(true);
  }, []);

  // Notify parent of filter changes
  useEffect(() => {
    if (isMounted) {
      onFilterChange(filters);
    }
  }, [filters, isMounted, onFilterChange]);

  const handlePriceChange = (type: 'min' | 'max', value: string) => {
    setFilters((prev) => ({
      ...prev,
      [type === 'min' ? 'priceMin' : 'priceMax']: value === '' ? '' : Number(value),
    }));
  };

  const handleCategoryToggle = (category: string) => {
    setFilters((prev) => ({
      ...prev,
      categories: prev.categories.includes(category)
        ? prev.categories.filter((c) => c !== category)
        : [...prev.categories, category],
    }));
  };

  const handleDosageToggle = (form: string) => {
    setFilters((prev) => ({
      ...prev,
      dosageForms: prev.dosageForms.includes(form)
        ? prev.dosageForms.filter((f) => f !== form)
        : [...prev.dosageForms, form],
    }));
  };

  const handleRxToggle = (value: boolean | null) => {
    setFilters((prev) => ({
      ...prev,
      rxRequired: prev.rxRequired === value ? null : value,
    }));
  };

  const resetFilters = () => {
    setFilters({
      priceMin: '',
      priceMax: '',
      categories: [],
      dosageForms: [],
      rxRequired: null,
    });
  };

  const hasActiveFilters =
    filters.priceMin !== '' ||
    filters.priceMax !== '' ||
    filters.categories.length > 0 ||
    filters.dosageForms.length > 0 ||
    filters.rxRequired !== null;

  if (!isMounted) return null;

  if (isMobile) {
    return (
      <div className="md:hidden mb-4">
        <button
          onClick={() => setIsOpen(!isOpen)}
          className="w-full flex items-center justify-between px-4 py-2.5 bg-card border border-border rounded-lg text-foreground hover:bg-muted/40 transition-colors"
        >
          <span className="font-semibold text-sm">
            Filters {hasActiveFilters && <span className="ml-2 text-xs bg-primary text-primary-foreground px-2 py-0.5 rounded-full">{Object.values(filters).flat().filter(v => v !== null && v !== '' && v !== false).length}</span>}
          </span>
          <ChevronDown className={`w-4 h-4 text-muted-foreground transition-transform ${isOpen ? 'rotate-180' : ''}`} />
        </button>

        {isOpen && (
          <div className="mt-2 p-5 bg-card border border-border rounded-lg space-y-4 shadow-sm animate-fade-in">
            <FilterContent
              filters={filters}
              categories={categories}
              dosageForms={dosageForms}
              onPriceChange={handlePriceChange}
              onCategoryToggle={handleCategoryToggle}
              onDosageToggle={handleDosageToggle}
              onRxToggle={handleRxToggle}
              onReset={resetFilters}
              hasActiveFilters={hasActiveFilters}
            />
          </div>
        )}
      </div>
    );
  }

  return (
    <div className="hidden md:block w-full max-w-xs bg-card border border-border rounded-xl p-6 h-fit sticky top-24 shadow-xs">
      <div className="flex items-center justify-between mb-4 pb-3 border-b border-border">
        <h3 className="font-bold text-foreground text-base">Filters</h3>
        {hasActiveFilters && (
          <button
            onClick={resetFilters}
            className="text-xs text-primary hover:text-primary/80 font-semibold transition-colors"
          >
            Reset
          </button>
        )}
      </div>

      <FilterContent
        filters={filters}
        categories={categories}
        dosageForms={dosageForms}
        onPriceChange={handlePriceChange}
        onCategoryToggle={handleCategoryToggle}
        onDosageToggle={handleDosageToggle}
        onRxToggle={handleRxToggle}
        onReset={resetFilters}
        hasActiveFilters={hasActiveFilters}
      />
    </div>
  );
}

interface FilterContentProps {
  filters: FilterState;
  categories: string[];
  dosageForms: string[];
  onPriceChange: (type: 'min' | 'max', value: string) => void;
  onCategoryToggle: (category: string) => void;
  onDosageToggle: (form: string) => void;
  onRxToggle: (value: boolean | null) => void;
  onReset: () => void;
  hasActiveFilters: boolean;
}

function FilterContent({
  filters,
  categories,
  dosageForms,
  onPriceChange,
  onCategoryToggle,
  onDosageToggle,
  onRxToggle,
  onReset,
  hasActiveFilters,
}: FilterContentProps) {
  return (
    <div className="space-y-6">
      {/* Price Range */}
      <div className="space-y-2">
        <label className="text-xs font-bold text-muted-foreground uppercase tracking-wider block">Price Range (PKR)</label>
        <div className="flex gap-2">
          <input
            type="number"
            placeholder="Min"
            value={filters.priceMin}
            onChange={(e) => onPriceChange('min', e.target.value)}
            className="w-full px-3 py-2 bg-background border border-border rounded-lg text-sm text-foreground placeholder:text-muted-foreground focus:ring-1 focus:ring-primary focus:border-primary outline-none transition-colors"
          />
          <input
            type="number"
            placeholder="Max"
            value={filters.priceMax}
            onChange={(e) => onPriceChange('max', e.target.value)}
            className="w-full px-3 py-2 bg-background border border-border rounded-lg text-sm text-foreground placeholder:text-muted-foreground focus:ring-1 focus:ring-primary focus:border-primary outline-none transition-colors"
          />
        </div>
      </div>

      {/* Categories */}
      {categories.length > 0 && (
        <div className="space-y-2">
          <label className="text-xs font-bold text-muted-foreground uppercase tracking-wider block">Category</label>
          <div className="space-y-1.5 max-h-48 overflow-y-auto pr-1 scrollbar-thin">
            {categories.map((cat) => (
              <label key={cat} className="flex items-center gap-2.5 cursor-pointer group text-sm text-foreground">
                <input
                  type="checkbox"
                  checked={filters.categories.includes(cat)}
                  onChange={() => onCategoryToggle(cat)}
                  className="w-4 h-4 rounded border-border bg-background text-primary focus:ring-primary accent-primary cursor-pointer transition-colors"
                />
                <span className="group-hover:text-primary transition-colors">{cat}</span>
              </label>
            ))}
          </div>
        </div>
      )}

      {/* Dosage Form */}
      {dosageForms.length > 0 && (
        <div className="space-y-2">
          <label className="text-xs font-bold text-muted-foreground uppercase tracking-wider block">Dosage Form</label>
          <div className="space-y-1.5 max-h-48 overflow-y-auto pr-1 scrollbar-thin">
            {dosageForms.map((form) => (
              <label key={form} className="flex items-center gap-2.5 cursor-pointer group text-sm text-foreground">
                <input
                  type="checkbox"
                  checked={filters.dosageForms.includes(form)}
                  onChange={() => onDosageToggle(form)}
                  className="w-4 h-4 rounded border-border bg-background text-primary focus:ring-primary accent-primary cursor-pointer transition-colors"
                />
                <span className="group-hover:text-primary transition-colors">{form}</span>
              </label>
            ))}
          </div>
        </div>
      )}

      {/* Prescription Required */}
      <div className="space-y-2">
        <label className="text-xs font-bold text-muted-foreground uppercase tracking-wider block">Prescription</label>
        <div className="space-y-2">
          <label className="flex items-center gap-2.5 cursor-pointer group text-sm text-foreground">
            <input
              type="radio"
              name="rx"
              checked={filters.rxRequired === null}
              onChange={() => onRxToggle(null)}
              className="w-4 h-4 border-border bg-background text-primary focus:ring-primary accent-primary cursor-pointer transition-colors"
            />
            <span className="group-hover:text-primary transition-colors">Any</span>
          </label>
          <label className="flex items-center gap-2.5 cursor-pointer group text-sm text-foreground">
            <input
              type="radio"
              name="rx"
              checked={filters.rxRequired === false}
              onChange={() => onRxToggle(false)}
              className="w-4 h-4 border-border bg-background text-primary focus:ring-primary accent-primary cursor-pointer transition-colors"
            />
            <span className="group-hover:text-primary transition-colors">Over-the-counter</span>
          </label>
          <label className="flex items-center gap-2.5 cursor-pointer group text-sm text-foreground">
            <input
              type="radio"
              name="rx"
              checked={filters.rxRequired === true}
              onChange={() => onRxToggle(true)}
              className="w-4 h-4 border-border bg-background text-primary focus:ring-primary accent-primary cursor-pointer transition-colors"
            />
            <span className="group-hover:text-primary transition-colors">Prescription required</span>
          </label>
        </div>
      </div>
    </div>
  );
}
