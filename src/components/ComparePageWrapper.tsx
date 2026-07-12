'use client';

import { useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { Plus, X } from 'lucide-react';
import { AddToCompareModal } from './AddToCompareModal';
import { CompareTable } from './CompareTable';

import { CompareIllustration } from './illustrations/CompareIllustration';

interface ComparePageWrapperProps {
  medicines: any[];
}

export function ComparePageWrapper({ medicines }: ComparePageWrapperProps) {
  const [showModal, setShowModal] = useState(false);
  const router = useRouter();
  const searchParams = useSearchParams();
  const currentIds = searchParams.get('ids')?.split(',').filter(Boolean) || [];

  const handleAddMedicine = (medicineId: string, medicineName: string) => {
    // Add to URL params
    const newIds = [...currentIds, medicineId];
    router.push(`/compare?ids=${newIds.join(',')}`);
    setShowModal(false);
  };

  const handleRemoveMedicine = (medicineId: string) => {
    const newIds = currentIds.filter((id) => id !== medicineId);
    if (newIds.length === 0) {
      router.push('/compare');
    } else {
      router.push(`/compare?ids=${newIds.join(',')}`);
    }
  };

  return (
    <div className="space-y-6">
      {/* Redesigned Illustrated Header Card */}
      <div className="relative overflow-hidden bg-card text-card-foreground rounded-2xl border border-border p-6 md:p-8 flex flex-col md:flex-row items-center justify-between gap-6 transition-colors duration-300">
        <div className="space-y-4 max-w-lg text-left">
          <div>
            <h1 className="text-3xl font-extrabold text-foreground tracking-tight mb-1.5">Compare Medicines</h1>
            <p className="text-muted-foreground text-sm font-medium">
              {medicines.length === 0
                ? 'Add up to 3 medicines to compare side-by-side'
                : `Comparing ${medicines.length} medicine${medicines.length !== 1 ? 's' : ''}`}
            </p>
          </div>
          {medicines.length < 3 && (
            <button
              onClick={() => setShowModal(true)}
              className="inline-flex items-center justify-center gap-2 px-5 py-2.5 bg-primary text-primary-foreground rounded-lg font-semibold text-sm hover:bg-primary/90 active:scale-95 transition-all duration-200 shadow-xs"
            >
              <Plus className="w-4 h-4" />
              Add Medicine
            </button>
          )}
        </div>
        <div className="w-full md:w-60 h-40 shrink-0 flex items-center justify-center">
          <CompareIllustration />
        </div>
      </div>

      {/* Empty State */}
      {medicines.length === 0 ? (
        <div className="bg-card text-card-foreground rounded-xl border border-border p-12 text-center shadow-xs transition-colors duration-300">
          <p className="text-lg font-bold text-foreground mb-2">No medicines selected to compare.</p>
          <p className="text-muted-foreground text-sm max-w-xs mx-auto mb-6">
            Click the "Add Medicine" button above to pick brand names from our directory.
          </p>
          <button
            onClick={() => setShowModal(true)}
            className="inline-flex items-center gap-2 px-4 py-2 bg-secondary text-primary border border-primary/10 rounded-lg text-sm font-bold hover:bg-primary/10 transition-colors"
          >
            <Plus className="w-4 h-4" /> Select Medicine
          </button>
        </div>
      ) : (
        <>
          {/* Remove Buttons Above Table */}
          <div className="flex flex-wrap gap-2 animate-fade-in">
            {medicines.map((med) => (
              <div
                key={med.id}
                className="inline-flex items-center gap-2 px-3 py-1.5 bg-muted/60 text-foreground border border-border/80 rounded-full text-xs font-semibold"
              >
                <span>{med.brandName}</span>
                <button
                  onClick={() => handleRemoveMedicine(med.id)}
                  className="p-0.5 hover:bg-muted rounded-full transition-colors text-muted-foreground hover:text-foreground"
                  title="Remove from comparison"
                >
                  <X className="w-3 h-3" />
                </button>
              </div>
            ))}
          </div>

          {/* Comparison Table */}
          <div className="animate-fade-in" style={{ animationDelay: '0.1s' }}>
            <CompareTable medicines={medicines} />
          </div>
        </>
      )}

      {/* Add to Compare Modal */}
      {showModal && (
        <AddToCompareModal
          onClose={() => setShowModal(false)}
          onAddMedicine={handleAddMedicine}
          existingMedicineIds={currentIds}
        />
      )}
    </div>
  );
}
