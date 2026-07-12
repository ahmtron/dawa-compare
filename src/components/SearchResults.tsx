'use client';

import { useState, useMemo } from 'react';
import { MedicineCard } from '@/components/MedicineCard';
import { FilterSidebar } from '@/components/FilterSidebar';

interface Medicine {
  id: string;
  brandName: string;
  genericName?: string;
  category?: string;
  price?: number;
  currency?: string;
  dosageForm?: string;
  packSize?: string;
  rxRequired?: boolean;
}

interface FilterState {
  priceMin: number | '';
  priceMax: number | '';
  categories: string[];
  dosageForms: string[];
  rxRequired: boolean | null;
}

interface SearchResultsProps {
  medicines: Medicine[];
  query: string;
}

export function SearchResults({ medicines, query }: SearchResultsProps) {
  const [filters, setFilters] = useState<FilterState>({
    priceMin: '',
    priceMax: '',
    categories: [],
    dosageForms: [],
    rxRequired: null,
  });

  // Extract unique categories and dosage forms for filter options
  const categories = useMemo(() => {
    const unique = new Set(medicines.map((m) => m.category).filter((c): c is string => Boolean(c)));
    return Array.from(unique).sort();
  }, [medicines]);

  const dosageForms = useMemo(() => {
    const unique = new Set(medicines.map((m) => m.dosageForm).filter((f): f is string => Boolean(f)));
    return Array.from(unique).sort();
  }, [medicines]);

  // Apply filters
  const filteredMedicines = useMemo(() => {
    return medicines.filter((med) => {
      // Price filter
      if (filters.priceMin !== '' && med.price !== undefined && med.price < filters.priceMin) {
        return false;
      }
      if (filters.priceMax !== '' && med.price !== undefined && med.price > filters.priceMax) {
        return false;
      }

      // Category filter
      if (filters.categories.length > 0 && !filters.categories.includes(med.category || '')) {
        return false;
      }

      // Dosage form filter
      if (filters.dosageForms.length > 0 && !filters.dosageForms.includes(med.dosageForm || '')) {
        return false;
      }

      // Rx filter
      if (filters.rxRequired !== null && med.rxRequired !== filters.rxRequired) {
        return false;
      }

      return true;
    });
  }, [medicines, filters]);

  return (
    <div className="space-y-4">
      {/* Mobile Filter Button / Desktop Sidebar */}
      <div className="flex gap-6">
        {/* Sidebar - visible on desktop */}
        <div className="hidden md:block">
          <FilterSidebar
            onFilterChange={setFilters}
            categories={categories}
            dosageForms={dosageForms}
            isMobile={false}
          />
        </div>

        {/* Main Results Area */}
        <div className="flex-1">
          {/* Mobile Filter Toggle */}
          <FilterSidebar
            onFilterChange={setFilters}
            categories={categories}
            dosageForms={dosageForms}
            isMobile={true}
          />

          {/* Results Count */}
          <div className="mb-4 flex items-center justify-between">
            <p className="text-sm text-muted-foreground">
              Showing <span className="font-semibold text-foreground">{filteredMedicines.length}</span> of{' '}
              <span className="font-semibold text-foreground">{medicines.length}</span> results
            </p>
          </div>

          {/* Empty State */}
          {filteredMedicines.length === 0 ? (
            <div className="text-center py-12 bg-card rounded-xl border border-border">
              <p className="text-lg font-semibold text-foreground mb-2">No medicines match your filters.</p>
              <p className="text-muted-foreground text-sm">Try adjusting your search criteria or filters.</p>
            </div>
          ) : (
            /* Results Grid */
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {filteredMedicines.map((med) => (
                <MedicineCard
                  key={med.id}
                  id={med.id}
                  brandName={med.brandName}
                  genericName={med.genericName}
                  category={med.category}
                  price={med.price}
                  currency={med.currency}
                />
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
