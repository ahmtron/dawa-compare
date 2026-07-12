import { createClient } from "@/lib/supabase/server";
import { Pill, Activity, AlertTriangle } from "lucide-react";

export default async function AdminDashboard() {
  const supabase = await createClient();

  // Fetch some stats
  const [
    { count: medicinesCount },
    { count: genericsCount },
    { count: sideEffectsCount }
  ] = await Promise.all([
    supabase.from("medicines").select("*", { count: "exact", head: true }),
    supabase.from("generics").select("*", { count: "exact", head: true }),
    supabase.from("side_effects").select("*", { count: "exact", head: true })
  ]);

  const stats = [
    { 
      name: "Total Medicines", 
      value: medicinesCount || 0, 
      icon: Pill, 
      color: "text-blue-600 dark:text-blue-400", 
      bg: "bg-blue-500/10" 
    },
    { 
      name: "Generic Salts", 
      value: genericsCount || 0, 
      icon: Activity, 
      color: "text-emerald-600 dark:text-emerald-400", 
      bg: "bg-emerald-500/10" 
    },
    { 
      name: "Side Effects", 
      value: sideEffectsCount || 0, 
      icon: AlertTriangle, 
      color: "text-amber-600 dark:text-amber-400", 
      bg: "bg-amber-500/10" 
    },
  ];

  return (
    <div className="space-y-6 transition-colors duration-300">
      <h1 className="text-2xl font-extrabold text-foreground mb-6">Overview</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        {stats.map((stat) => (
          <div key={stat.name} className="bg-card text-card-foreground p-6 rounded-xl border border-border shadow-xs flex items-center gap-4 transition-colors duration-300">
            <div className={`w-12 h-12 rounded-full flex items-center justify-center ${stat.bg}`}>
              <stat.icon className={`w-5 h-5 ${stat.color}`} />
            </div>
            <div>
              <p className="text-xs font-bold text-muted-foreground uppercase tracking-wider">{stat.name}</p>
              <p className="text-2xl font-black text-foreground mt-0.5 tracking-tight">{stat.value.toLocaleString()}</p>
            </div>
          </div>
        ))}
      </div>

      <div className="bg-card rounded-xl border border-border shadow-xs overflow-hidden transition-colors duration-300">
        <div className="px-6 py-4 border-b border-border">
          <h2 className="text-base font-bold text-foreground">Quick Actions</h2>
        </div>
        <div className="p-6">
          <p className="text-sm text-muted-foreground leading-relaxed">
            Welcome to the DawaCompare Admin Portal. Use the sidebar to manage medicines, import bulk datasets, and view audit logs.
          </p>
        </div>
      </div>
    </div>
  );
}
