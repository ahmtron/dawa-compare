'use client';

import { useState, useEffect } from 'react';
import { Sun, Moon } from 'lucide-react';

export function ThemeToggle() {
  const [isDark, setIsDark] = useState(false);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    setIsDark(document.documentElement.classList.contains('dark'));
  }, []);

  const toggleTheme = () => {
    const html = document.documentElement;
    const newDark = !html.classList.contains('dark');

    if (newDark) {
      html.classList.add('dark');
      localStorage.setItem('theme', 'dark');
    } else {
      html.classList.remove('dark');
      localStorage.setItem('theme', 'light');
    }

    setIsDark(newDark);
  };

  if (!mounted) {
    return (
      <div className="p-2 rounded-lg w-9 h-9 bg-transparent border border-transparent" aria-hidden="true" />
    );
  }

  return (
    <button
      onClick={toggleTheme}
      className="p-2 rounded-lg text-muted-foreground hover:text-foreground hover:bg-muted/50 active:scale-90 transition-all duration-200 relative overflow-hidden"
      aria-label={isDark ? 'Switch to light mode' : 'Switch to dark mode'}
    >
      <div className="w-5 h-5 relative flex items-center justify-center">
        {isDark ? (
          <Sun className="w-5 h-5 rotate-0 scale-100 transition-all duration-300 text-[#D4A843]" />
        ) : (
          <Moon className="w-5 h-5 rotate-0 scale-100 transition-all duration-300 text-slate-700" />
        )}
      </div>
    </button>
  );
}
