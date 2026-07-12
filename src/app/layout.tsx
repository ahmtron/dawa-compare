import type { Metadata } from "next";
import { Manrope, Instrument_Sans } from "next/font/google";
import "./globals.css";
import { cn } from "@/lib/utils";
import { Navbar } from "@/components/Navbar";
import { ThemeProvider } from "@/components/ThemeProvider";
import { ScrollObserver } from "@/components/ScrollObserver";

const manrope = Manrope({
  subsets: ["latin"],
  variable: "--font-manrope",
  fallback: ["system-ui", "-apple-system", "sans-serif"],
});

const instrumentSans = Instrument_Sans({
  subsets: ["latin"],
  variable: "--font-instrument",
  fallback: ["system-ui", "-apple-system", "sans-serif"],
});

export const metadata: Metadata = {
  title: "DawaCompare | Medicine Price & Generic Alternative Comparator",
  description: "Find your medicine's cheaper twin in Pakistan. Compare prices, view generic alternatives, and understand side effects.",
};

import { FooterIllustration } from "@/components/illustrations/FooterIllustration";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={cn("h-full", "antialiased", manrope.variable, instrumentSans.variable, "font-sans")} suppressHydrationWarning>
      <body className="min-h-full flex flex-col bg-background text-foreground font-sans transition-colors duration-300">
        <ThemeProvider>
          <ScrollObserver />
          <Navbar />
          <main className="flex-1">{children}</main>

          {/* Premium Redesigned Illustrated Footer */}
          <footer className="relative mt-auto border-t border-border bg-muted/15 text-muted-foreground transition-colors duration-300 overflow-hidden">
            <div className="container mx-auto px-4 py-12 max-w-6xl">
              <div className="grid grid-cols-1 md:grid-cols-12 gap-8 mb-12 items-center">
                {/* Column 1: Brand details */}
                <div className="md:col-span-3 space-y-3">
                  <h3 className="font-heading font-extrabold text-foreground text-lg tracking-tight">DawaCompare</h3>
                  <p className="text-xs leading-relaxed font-medium">
                    Find and compare generic twin alternative medicines in Pakistan. Empowering you to make smart, cost-effective decisions about your health.
                  </p>
                </div>

                {/* Column 2: Quick Links */}
                <div className="md:col-span-2 space-y-3">
                  <h4 className="font-heading font-bold text-foreground text-sm uppercase tracking-wider">Links</h4>
                  <ul className="space-y-2 text-xs font-semibold">
                    <li><a href="/" className="hover:text-primary transition-colors">Home Portal</a></li>
                    <li><a href="/search" className="hover:text-primary transition-colors">Finder</a></li>
                    <li><a href="/compare" className="hover:text-primary transition-colors">Compare</a></li>
                    <li><a href="/pharmacies" className="hover:text-primary transition-colors">Nearby Pharmacies</a></li>
                    <li><a href="/admin" className="hover:text-primary transition-colors">Admin</a></li>
                  </ul>
                </div>

                {/* Column 3: Medical Disclaimer */}
                <div className="md:col-span-4 space-y-3">
                  <h4 className="font-heading font-bold text-foreground text-sm uppercase tracking-wider">Disclaimer</h4>
                  <p className="text-xs leading-relaxed font-medium text-muted-foreground">
                    DawaCompare provides pricing and composition details for reference only. 
                    <strong className="text-foreground"> It is NOT medical advice.</strong> Swapping or starting medications should always be done under professional doctor consultation.
                  </p>
                </div>

                {/* Column 4: Dedicated Illustration Scene */}
                <div className="md:col-span-3 flex justify-center items-center">
                  <div className="w-36 h-36 shrink-0">
                    <FooterIllustration />
                  </div>
                </div>
              </div>

              {/* Bottom Copyright bar */}
              <div className="pt-8 border-t border-border/60 flex flex-col sm:flex-row items-center justify-between text-[11px] font-semibold text-muted-foreground/80">
                <p>© {new Date().getFullYear()} DawaCompare Pakistan. All rights reserved.</p>
                <p>Data sourced from DRAP records & public pharmacy pricing index.</p>
              </div>
            </div>
          </footer>
        </ThemeProvider>
      </body>
    </html>
  );
}
