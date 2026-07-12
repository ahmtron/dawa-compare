/**
 * Utility functions for smart medicine matching and data extraction
 */

export type Composition = {
  generic_id: string;
  generic_name: string;
  strength_value: number | null;
  strength_unit: string | null;
};

export type MedicineData = {
  id: string;
  brand_name: string;
  prices: Array<{ price: string | number; currency: string; recorded_at: string }>;
  compositions: Composition[];
};

/**
 * Create a unique signature for a medicine's composition
 * Used to identify if two medicines have identical active ingredients + strengths
 *
 * Example:
 * - Augmentin 625: [Amoxycillin 500mg, Clavulanic Acid 125mg]
 * - Signature: "clav-acid:125:mg|amoxycillin:500:mg" (sorted, normalized)
 */
export function getCompositionSignature(compositions: Composition[]): string {
  return compositions
    .map((c) => {
      const genericName = c.generic_name.toLowerCase().replace(/\s+/g, '-');
      const strength = c.strength_value ?? 'variable';
      const unit = c.strength_unit ?? 'custom';
      return `${genericName}:${strength}:${unit}`;
    })
    .sort()
    .join('|');
}

/**
 * Get the LATEST price from a medicine's price history
 * Handles cases where recorded_at may be out of order
 *
 * Returns null if no prices exist
 */
export function getLatestPrice(
  prices: Array<{ price: string | number; currency: string; recorded_at: string }> | null
): { price: number; currency: string } | null {
  if (!prices || prices.length === 0) return null;

  const sorted = [...prices].sort(
    (a, b) => new Date(b.recorded_at).getTime() - new Date(a.recorded_at).getTime()
  );

  const latest = sorted[0];
  return {
    price: Number(latest.price),
    currency: latest.currency || 'PKR',
  };
}

/**
 * Determine if a medicine is single-salt or multi-salt combination
 */
export function isSingleSalt(compositions: Composition[] | null): boolean {
  return !compositions || compositions.length === 1;
}

/**
 * Check if two medicines have identical compositions
 * For single-salt: checks if same generic + strength
 * For multi-salt: checks if ALL salts + strengths match
 */
export function haveSameComposition(
  comp1: Composition[],
  comp2: Composition[]
): boolean {
  if (comp1.length !== comp2.length) return false;
  return getCompositionSignature(comp1) === getCompositionSignature(comp2);
}

/**
 * Filter alternatives to show only clinically equivalent medicines
 * - For single-salt: same generic + same strength
 * - For multi-salt: exact composition match (all salts + strengths must match)
 */
export function filterClinicallyEquivalent(
  currentMedicine: MedicineData,
  candidates: MedicineData[]
): MedicineData[] {
  const currentSignature = getCompositionSignature(currentMedicine.compositions);

  return candidates.filter((candidate) => {
    if (candidate.id === currentMedicine.id) return false;

    const candidateSignature = getCompositionSignature(candidate.compositions);
    return candidateSignature === currentSignature;
  });
}

/**
 * Format price for display
 */
export function formatPrice(price: number | null, currency: string = 'PKR'): string {
  if (price === null) return 'Price not available';
  return `${currency} ${price.toLocaleString()}`;
}

/**
 * Calculate savings percentage between two prices
 */
export function calculateSavings(originalPrice: number, alternativePrice: number): number {
  if (originalPrice <= 0 || alternativePrice >= originalPrice) return 0;
  return Math.round(((originalPrice - alternativePrice) / originalPrice) * 100);
}
