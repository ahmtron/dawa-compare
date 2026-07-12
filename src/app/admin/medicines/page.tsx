import { createClient } from "@/lib/supabase/server";
import Link from "next/link";
import { Plus, Edit, Trash2 } from "lucide-react";

export default async function AdminMedicinesPage({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>
}) {
  const supabase = await createClient();
  const page = Number((await searchParams).page) || 1;
  const limit = 20;
  const offset = (page - 1) * limit;

  const { data: medicines, count } = await supabase
    .from("medicines")
    .select(`
      id,
      brand_name,
      is_active,
      category:categories(name),
      manufacturer:manufacturers(name)
    `, { count: "exact" })
    .order("created_at", { ascending: false })
    .range(offset, offset + limit - 1) as any;

  return (
    <div className="space-y-6 transition-colors duration-300">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-extrabold text-foreground">Medicines Directory</h1>
        <Link 
          href="/admin/medicines/new"
          className="bg-primary text-primary-foreground px-4 py-2 rounded-lg font-semibold text-sm flex items-center gap-2 hover:bg-primary/90 active:scale-95 transition-all duration-200 shadow-xs"
        >
          <Plus className="w-4 h-4" /> Add Medicine
        </Link>
      </div>

      <div className="bg-card rounded-xl border border-border shadow-xs overflow-hidden transition-colors duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm whitespace-nowrap">
            <thead className="uppercase tracking-wider border-b border-border bg-muted/30 text-muted-foreground text-[10px] font-bold">
              <tr>
                <th className="px-6 py-4 font-semibold">Brand Name</th>
                <th className="px-6 py-4 font-semibold">Category</th>
                <th className="px-6 py-4 font-semibold">Manufacturer</th>
                <th className="px-6 py-4 font-semibold">Status</th>
                <th className="px-6 py-4 font-semibold text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border/60">
              {medicines?.map((med: any) => (
                <tr key={med.id} className="hover:bg-muted/40 transition-colors">
                  <td className="px-6 py-4 font-bold text-foreground">{med.brand_name}</td>
                  <td className="px-6 py-4 text-muted-foreground font-medium">{med.category?.name || '-'}</td>
                  <td className="px-6 py-4 text-muted-foreground font-medium">{med.manufacturer?.name || '-'}</td>
                  <td className="px-6 py-4">
                    <span className={`px-2.5 py-1 rounded-full text-xs font-bold border ${
                      med.is_active 
                        ? 'bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/20' 
                        : 'bg-muted text-muted-foreground border-border'
                    }`}>
                      {med.is_active ? 'Active' : 'Inactive'}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-right flex justify-end gap-2">
                    <Link href={`/admin/medicines/${med.id}/edit`} className="text-blue-500 hover:text-blue-600 dark:text-blue-400 dark:hover:text-blue-300 p-1 rounded-md hover:bg-muted/50 transition-colors">
                      <Edit className="w-4 h-4" />
                    </Link>
                    <button className="text-rose-500 hover:text-rose-600 dark:text-rose-400 dark:hover:text-rose-300 p-1 rounded-md hover:bg-muted/50 transition-colors">
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        
        {/* Pagination placeholder */}
        <div className="px-6 py-4 border-t border-border flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-muted-foreground font-medium">
            Showing <span className="font-semibold text-foreground">{offset + 1}</span> to <span className="font-semibold text-foreground">{Math.min(offset + limit, count || 0)}</span> of <span className="font-semibold text-foreground">{count}</span> results
          </p>
          <div className="flex gap-2">
            <Link 
              href={`/admin/medicines?page=${Math.max(1, page - 1)}`}
              className={`px-3 py-1.5 border border-border rounded-lg text-xs font-semibold text-foreground hover:bg-muted/40 transition-colors ${page <= 1 ? 'pointer-events-none opacity-50' : ''}`}
            >
              Previous
            </Link>
            <Link 
              href={`/admin/medicines?page=${page + 1}`}
              className={`px-3 py-1.5 border border-border rounded-lg text-xs font-semibold text-foreground hover:bg-muted/40 transition-colors ${(offset + limit) >= (count || 0) ? 'pointer-events-none opacity-50' : ''}`}
            >
              Next
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
