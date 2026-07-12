import Link from "next/link";
import { Pill, Activity } from "lucide-react";

interface MedicineCardProps {
  id: string;
  brandName: string;
  genericName?: string;
  category?: string;
  price?: number;
  currency?: string;
  isAiAssisted?: boolean;
}

export function MedicineCard({ 
  id, 
  brandName, 
  genericName, 
  category, 
  price, 
  currency = "PKR",
  isAiAssisted = false
}: MedicineCardProps) {
  return (
    <Link href={`/medicine/${id}`} className="block">
      <div className="bg-card text-card-foreground rounded-xl border border-border p-5 shadow-xs hover:shadow-md hover:border-primary/30 transition-all duration-300 group relative overflow-hidden transform hover:-translate-y-0.5">
        {isAiAssisted && (
          <div className="absolute top-0 right-0 bg-primary/10 text-primary text-[10px] font-extrabold px-3 py-1 rounded-bl-xl border-b border-l border-primary/20 flex items-center gap-1 uppercase tracking-wider animate-pulse">
            <Activity className="w-3 h-3" /> AI Matched
          </div>
        )}
        
        <div className="flex justify-between items-start mb-4">
          <div className="space-y-1.5">
            <h3 className="text-lg font-bold text-foreground group-hover:text-primary transition-colors duration-300 leading-snug">
              {brandName}
            </h3>
            {genericName && (
              <p className="text-muted-foreground text-xs font-semibold flex items-center gap-1.5">
                <Pill className="w-3.5 h-3.5 text-primary/75" />
                <span>{genericName}</span>
              </p>
            )}
          </div>
          {price !== undefined && (
            <div className="text-right">
              <p className="text-xl font-black text-accent tracking-tight">
                <span className="text-[10px] font-bold text-muted-foreground mr-1 uppercase">{currency}</span>
                {price.toLocaleString()}
              </p>
            </div>
          )}
        </div>
        
        {category && (
          <div className="inline-block bg-muted/60 text-muted-foreground text-[10px] font-bold uppercase tracking-wider px-2.5 py-1 rounded-full border border-border/20">
            {category}
          </div>
        )}
      </div>
    </Link>
  );
}
