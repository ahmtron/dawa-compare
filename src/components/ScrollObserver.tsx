'use client';

import { useEffect } from 'react';
import { usePathname } from 'next/navigation';

export function ScrollObserver() {
  const pathname = usePathname();

  useEffect(() => {
    // We run the observer logic on initial mount and whenever pathname changes (page transitions)
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('active');
            observer.unobserve(entry.target); // Unobserve to make it a one-time scroll reveal
          }
        });
      },
      {
        threshold: 0.05,
        rootMargin: '0px 0px -40px 0px',
      }
    );

    // Query elements
    const elements = document.querySelectorAll('.reveal');
    elements.forEach((el) => observer.observe(el));

    return () => {
      elements.forEach((el) => observer.unobserve(el));
    };
  }, [pathname]); // Re-observe when page route shifts

  return null;
}
