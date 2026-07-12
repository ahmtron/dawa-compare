"use client";

import { ShieldAlert, Check, X, TrendingDown } from "lucide-react";
import Link from "next/link";
import { getCompositionSignature } from "@/lib/medicine-utils";

interface CompareTableProps {
  medicines: any[];
}

export function CompareTable({ medicines }: CompareTableProps) {
  // Find the minimum and maximum price for highlighting and calculations
  const prices = medicines.map(m => m.price).filter(p => p !== undefined) as number[];
  const minPrice = prices.length > 0 ? Math.min(...prices) : null;
  const maxPrice = prices.length > 0 ? Math.max(...prices) : null;

  // Check if all medicines have the same composition
  const compositionSignatures = medicines.map(m =>
    getCompositionSignature(
      m.compositions?.map((c: any) => ({
        generic_id: c.generic.id,
        generic_name: c.generic.name,
        strength_value: c.strength_value,
        strength_unit: c.strength_unit,
      })) || []
    )
  );
  const allSameComposition = new Set(compositionSignatures).size === 1;

  const calculateSavings = (price: number) => {
    if (!maxPrice || price >= maxPrice) return 0;
    return Math.round(((maxPrice - price) / maxPrice) * 100);
  };

  return (
    <div className="space-y-6 transition-colors duration-300">
      {!allSameComposition && (
        <div className="p-4 bg-amber-500/10 border border-amber-500/20 rounded-xl transition-colors duration-300 animate-pulse">
          <p className="text-sm text-amber-600 dark:text-amber-400 font-semibold flex items-center gap-2">
            <span>⚠️</span> These medicines have different active ingredients. Compare salt formulas carefully before switching.
          </p>
        </div>
      )}

      <div className="overflow-x-auto bg-card rounded-xl border border-border shadow-xs transition-colors duration-300">
        <table className="w-full text-left border-collapse">
          <thead>
            <tr>
              <th className="p-4 border-b border-r border-border bg-muted/30 font-bold text-muted-foreground text-xs uppercase tracking-wider min-w-[140px]">
                Features
              </th>
              {medicines.map(med => (
                <th
                  key={`header-${med.id}`}
                  className="p-4 border-b border-border min-w-[180px]"
                >
                  <Link
                    href={`/medicine/${med.id}`}
                    className="text-base font-extrabold text-foreground hover:text-primary transition-colors line-clamp-2"
                  >
                    {med.brandName}
                  </Link>
                  {med.manufacturer && (
                    <p className="text-xs text-muted-foreground font-semibold mt-1">{med.manufacturer}</p>
                  )}
                </th>
              ))}
              {/* Fill empty slots if < 3 medicines */}
              {Array.from({ length: Math.max(0, 3 - medicines.length) }).map((_, i) => (
                <th
                  key={`empty-header-${i}`}
                  className="p-4 border-b border-border min-w-[180px] bg-muted/20 border-dashed border-l border-border text-center text-muted-foreground/60 text-xs font-semibold uppercase tracking-wider"
                >
                  Add another to compare
                </th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-border">
            {/* Price Row */}
            <tr>
              <td className="p-4 border-r border-border bg-muted/30 font-bold text-foreground text-sm">
                Latest Price
              </td>
              {medicines.map(med => {
                const isCheapest = minPrice !== null && med.price === minPrice;
                return (
                  <td
                    key={`price-${med.id}`}
                    className={`p-4 transition-colors ${
                      isCheapest ? 'bg-emerald-500/10' : ''
                    }`}
                  >
                    {med.price ? (
                      <div className="space-y-2">
                        <div className="flex items-baseline gap-2">
                          <span className="text-2xl font-black text-accent tracking-tight">
                            {med.price.toLocaleString()}
                          </span>
                          <span className="text-[10px] font-bold text-muted-foreground uppercase">{med.currency}</span>
                          {isCheapest && (
                            <span className="ml-auto bg-emerald-500/15 text-emerald-600 dark:text-emerald-400 text-[10px] font-extrabold uppercase px-2.5 py-1 rounded-full border border-emerald-500/20 tracking-wider">
                              Cheapest
                            </span>
                          )}
                        </div>
                        {calculateSavings(med.price) > 0 && (
                          <div className="flex items-center gap-1 text-emerald-600 dark:text-emerald-400 text-xs font-semibold pt-1 border-t border-emerald-500/10">
                            <TrendingDown className="w-3.5 h-3.5" />
                            Save {calculateSavings(med.price)}%
                          </div>
                        )}
                      </div>
                    ) : (
                      <span className="text-muted-foreground italic text-sm">Not available</span>
                    )}
                  </td>
                );
              })}
              {Array.from({ length: Math.max(0, 3 - medicines.length) }).map((_, i) => (
                <td
                  key={`empty-price-${i}`}
                  className="p-4 border-dashed border-l border-border bg-muted/20"
                />
              ))}
            </tr>

            {/* Salt Formula Row */}
            <tr>
              <td className="p-4 border-r border-border bg-muted/30 font-bold text-foreground text-sm">
                Salt Formula
              </td>
              {medicines.map(med => (
                <td key={`salt-${med.id}`} className="p-4">
                  <ul className="space-y-2">
                    {med.compositions?.map((comp: any, idx: number) => (
                      <li key={idx} className="text-sm">
                        <span className="font-semibold text-foreground">{comp.generic.name}</span>
                        {comp.strength_value && (
                          <span className="text-muted-foreground ml-1.5 font-medium">
                            {comp.strength_value}
                            {comp.strength_unit}
                          </span>
                        )}
                      </li>
                    ))}
                    {(!med.compositions || med.compositions.length === 0) && (
                      <li className="text-muted-foreground italic text-sm">Unknown composition</li>
                    )}
                  </ul>
                </td>
              ))}
              {Array.from({ length: Math.max(0, 3 - medicines.length) }).map((_, i) => (
                <td
                  key={`empty-salt-${i}`}
                  className="p-4 border-dashed border-l border-border bg-muted/20"
                />
              ))}
            </tr>

            {/* Dosage Form Row */}
            <tr>
              <td className="p-4 border-r border-border bg-muted/30 font-bold text-foreground text-sm">
                Dosage & Pack
              </td>
              {medicines.map(med => (
                <td key={`form-${med.id}`} className="p-4 text-foreground text-sm">
                  <div className="space-y-1">
                    <p className="font-semibold">{med.dosageForm || '-'}</p>
                    {med.packSize && <p className="text-xs text-muted-foreground font-semibold">{med.packSize}</p>}
                  </div>
                </td>
              ))}
              {Array.from({ length: Math.max(0, 3 - medicines.length) }).map((_, i) => (
                <td
                  key={`empty-form-${i}`}
                  className="p-4 border-dashed border-l border-border bg-muted/20"
                />
              ))}
            </tr>

            {/* Prescription Row */}
            <tr>
              <td className="p-4 border-r border-border bg-muted/30 font-bold text-foreground text-sm">
                Prescription
              </td>
              {medicines.map(med => (
                <td key={`rx-${med.id}`} className="p-4">
                  {med.rxRequired ? (
                    <div className="flex items-center gap-2 text-destructive font-bold text-sm">
                      <ShieldAlert className="w-4 h-4 flex-shrink-0" />
                      <span className="text-xs uppercase tracking-wider">Required</span>
                    </div>
                  ) : (
                    <div className="flex items-center gap-2 text-emerald-600 dark:text-emerald-400 font-bold text-sm">
                      <Check className="w-4 h-4 flex-shrink-0" />
                      <span className="text-xs uppercase tracking-wider">OTC</span>
                    </div>
                  )}
                </td>
              ))}
              {Array.from({ length: Math.max(0, 3 - medicines.length) }).map((_, i) => (
                <td
                  key={`empty-rx-${i}`}
                  className="p-4 border-dashed border-l border-border bg-muted/20"
                />
              ))}
            </tr>
          </tbody>
        </table>
      </div>

      {/* Recommendation Banner */}
      {medicines.length >= 2 && minPrice && maxPrice && (
        <div className="p-4 bg-secondary border border-primary/10 rounded-xl transition-colors duration-300">
          <p className="text-sm text-secondary-foreground font-semibold flex items-center gap-1.5 leading-relaxed">
            <span>💡</span>
            <span>
              <strong>Best Value:</strong> The cheapest option (
              <span className="text-accent font-black">{minPrice}</span> PKR) saves you{' '}
              <span className="text-emerald-600 dark:text-emerald-400 font-extrabold">{calculateSavings(minPrice)}%</span>
              {allSameComposition ? ' with the same composition.' : ' — verify composition before switching.'}
            </span>
          </p>
        </div>
      )}
    </div>
  );
}
