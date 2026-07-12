'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Pill, Search, BarChart3, Menu, X } from 'lucide-react';
import { ThemeToggle } from './ThemeToggle';

export function Navbar() {
  const [isMounted, setIsMounted] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  const pathname = usePathname();

  // Prevent hydration mismatch
  useEffect(() => {
    setIsMounted(true);
  }, []);

  const isActive = (path: string) => {
    if (path === '/' && pathname === '/') return true;
    if (path !== '/' && pathname?.startsWith(path)) return true;
    return false;
  };

  const navItems = [
    { href: '/', label: 'Home', icon: Pill },
    { href: '/search', label: 'Search', icon: Search },
    { href: '/compare', label: 'Compare', icon: BarChart3 },
  ];

  if (!isMounted) {
    return (
      <nav className="sticky top-0 z-40 bg-card/80 backdrop-blur-md border-b border-border shadow-xs transition-colors duration-300">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            {/* Logo skeleton */}
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 bg-muted rounded-lg animate-pulse" />
              <div className="w-24 h-5 bg-muted rounded-md hidden sm:block animate-pulse" />
            </div>
          </div>
        </div>
      </nav>
    );
  }

  return (
    <nav className="sticky top-0 z-40 bg-card/80 backdrop-blur-md border-b border-border shadow-xs transition-colors duration-300">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo and Brand */}
          <Link href="/" className="flex items-center gap-2.5 group">
            <div className="w-8 h-8 bg-gradient-to-br from-primary to-[#14A3A8] rounded-lg flex items-center justify-center shadow-sm group-hover:shadow-md transition-all duration-300 group-hover:scale-105 active:scale-95">
              <Pill className="w-4 h-4 text-primary-foreground transform group-hover:rotate-12 transition-transform duration-300" />
            </div>
            <div className="hidden sm:flex flex-col leading-tight">
              <span className="text-md font-extrabold text-foreground tracking-tight group-hover:text-primary transition-colors duration-300">Dawa</span>
              <span className="text-[10px] text-muted-foreground uppercase tracking-widest font-bold">Compare</span>
            </div>
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center gap-1">
            {navItems.map((item) => {
              const Icon = item.icon;
              const active = isActive(item.href);
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={`flex items-center gap-2 px-4 py-2 rounded-lg font-semibold text-sm transition-all duration-200 ${
                    active
                      ? 'text-primary bg-secondary shadow-xs border border-primary/5'
                      : 'text-muted-foreground hover:text-foreground hover:bg-muted/40'
                  }`}
                >
                  <Icon className="w-4 h-4" />
                  {item.label}
                </Link>
              );
            })}
          </div>

          {/* Right Section - Theme Toggle & Mobile Menu */}
          <div className="flex items-center gap-1.5">
            <ThemeToggle />

            {/* Mobile Menu Button */}
            <button
              onClick={() => setIsOpen(!isOpen)}
              className="md:hidden p-2 hover:bg-muted/50 rounded-lg transition-colors text-muted-foreground hover:text-foreground"
              aria-label="Toggle navigation"
            >
              {isOpen ? (
                <X className="w-5 h-5" />
              ) : (
                <Menu className="w-5 h-5" />
              )}
            </button>
          </div>
        </div>

        {/* Mobile Navigation */}
        {isOpen && (
          <div className="md:hidden border-t border-border bg-card/95 py-2 transition-colors duration-300">
            <div className="space-y-1 px-2 pb-2">
              {navItems.map((item) => {
                const Icon = item.icon;
                const active = isActive(item.href);
                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    onClick={() => setIsOpen(false)}
                    className={`flex items-center gap-3 px-4 py-3 rounded-lg font-semibold text-sm transition-all duration-200 ${
                      active
                        ? 'text-primary bg-secondary shadow-xs border border-primary/5'
                        : 'text-muted-foreground hover:text-foreground hover:bg-muted/40'
                    }`}
                  >
                    <Icon className="w-4 h-4" />
                    {item.label}
                  </Link>
                );
              })}
            </div>
          </div>
        )}
      </div>
    </nav>
  );
}
