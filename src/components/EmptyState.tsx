'use client';

import { EmptyStateIllustration } from './illustrations/EmptyStateIllustration';
import Link from 'next/link';

interface EmptyStateProps {
  type?: 'search' | 'filter' | 'not-found' | 'no-data';
  title: string;
  description: string;
  actionLabel?: string;
  actionHref?: string;
}

export function EmptyState({
  type = 'no-data',
  title,
  description,
  actionLabel,
  actionHref,
}: EmptyStateProps) {
  return (
    <div className="flex flex-col items-center justify-center py-12 px-6 bg-card text-card-foreground rounded-xl border border-border transition-colors duration-300">
      <div className="w-48 h-36 mb-4 flex items-center justify-center">
        <EmptyStateIllustration />
      </div>
      <h3 className="text-lg font-bold text-foreground mb-2 text-center leading-snug">{title}</h3>
      <p className="text-muted-foreground text-sm text-center max-w-xs mb-6 leading-relaxed">{description}</p>
      {actionLabel && actionHref && (
        <Link
          href={actionHref}
          className="px-5 py-2.5 bg-primary text-primary-foreground rounded-lg text-sm font-semibold hover:bg-primary/90 active:scale-95 shadow-sm hover:shadow transition-all duration-200"
        >
          {actionLabel}
        </Link>
      )}
    </div>
  );
}

// Specific empty state presets
export function NoSearchResults({ query }: { query: string }) {
  return (
    <EmptyState
      type="search"
      title={`No results for "${query}"`}
      description="Try searching by generic name (salt formula) or adjust your filters."
      actionLabel="Try different search"
      actionHref="/"
    />
  );
}

export function NoFilterResults() {
  return (
    <EmptyState
      type="filter"
      title="No medicines match your filters"
      description="Try adjusting your search criteria or removing some filters."
    />
  );
}

export function NoAlternatives() {
  return (
    <EmptyState
      type="not-found"
      title="No alternatives found"
      description="This medicine is already the cheapest option with this exact composition."
    />
  );
}

export function NoData({ title = 'No data available' }: { title?: string }) {
  return <EmptyState type="no-data" title={title} description="There's no data to display yet." />;
}

export function NotFound() {
  return (
    <EmptyState
      type="not-found"
      title="Not found"
      description="The page or resource you're looking for doesn't exist."
      actionLabel="Go to home"
      actionHref="/"
    />
  );
}
