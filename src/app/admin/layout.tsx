import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { LayoutDashboard, Database, FileUp, Settings } from "lucide-react";
import { SignOutButton } from "./SignOutButton";

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/admin/login");
  }

  // Get profile to show role/name
  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();

  const navigation = [
    { name: "Dashboard", href: "/admin", icon: LayoutDashboard },
    { name: "Medicines", href: "/admin/medicines", icon: Database },
    { name: "Bulk Import", href: "/admin/import", icon: FileUp },
    { name: "Audit Log", href: "/admin/audit", icon: Settings },
  ];

  return (
    <div className="flex min-h-[calc(100vh-140px)] bg-background transition-colors duration-300">
      {/* Sidebar */}
      <div className="w-64 bg-card border-r border-border flex flex-col transition-colors duration-300">
        <div className="h-16 flex items-center px-6 border-b border-border">
          <span className="font-extrabold text-foreground tracking-tight text-sm">Admin Portal</span>
        </div>
        
        <div className="flex-1 py-4 overflow-y-auto">
          <nav className="px-3 space-y-1">
            {navigation.map((item) => (
              <Link
                key={item.name}
                href={item.href}
                className="flex items-center gap-3 px-3 py-2.5 text-sm font-semibold rounded-lg text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-all duration-200"
              >
                <item.icon className="w-4 h-4 text-muted-foreground/75" />
                {item.name}
              </Link>
            ))}
          </nav>
        </div>

        <div className="p-4 border-t border-border">
          <div className="flex items-center gap-3 mb-4">
            <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-extrabold text-xs">
              {(profile?.full_name || user.email || 'A')[0].toUpperCase()}
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-bold text-foreground truncate">
                {profile?.full_name || user.email}
              </p>
              <p className="text-[10px] text-muted-foreground truncate capitalize font-bold uppercase tracking-wider">
                {profile?.role || 'User'}
              </p>
            </div>
          </div>
          <SignOutButton />
        </div>
      </div>

      {/* Main content */}
      <div className="flex-1 flex flex-col">
        <main className="flex-1 p-6 md:p-8">
          {children}
        </main>
      </div>
    </div>
  );
}
