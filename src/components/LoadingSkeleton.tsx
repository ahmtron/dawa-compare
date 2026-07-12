'use client';

export function LoadingSkeleton() {
  return (
    <div className="space-y-4 animate-pulse">
      {Array.from({ length: 4 }).map((_, i) => (
        <div
          key={i}
          className="h-32 bg-gradient-to-r from-muted to-muted/40 rounded-xl"
        />
      ))}
    </div>
  );
}

export function LoadingSkeletonGrid({ columns = 2 }: { columns?: number }) {
  return (
    <div className={`grid grid-cols-1 ${columns === 2 ? 'md:grid-cols-2' : 'md:grid-cols-3'} gap-4 animate-pulse`}>
      {Array.from({ length: 6 }).map((_, i) => (
        <div
          key={i}
          className="h-48 bg-gradient-to-r from-muted to-muted/40 rounded-xl"
        />
      ))}
    </div>
  );
}

export function LoadingSkeletonTable() {
  return (
    <div className="space-y-3 animate-pulse">
      {/* Header */}
      <div className="h-10 bg-gradient-to-r from-muted to-muted/40 rounded-lg" />
      {/* Rows */}
      {Array.from({ length: 5 }).map((_, i) => (
        <div key={i} className="h-12 bg-gradient-to-r from-muted/80 to-muted/30 rounded-lg" />
      ))}
    </div>
  );
}

export function LoadingSkeletonDetail() {
  return (
    <div className="space-y-6 animate-pulse">
      {/* Header */}
      <div className="h-12 bg-gradient-to-r from-muted to-muted/40 rounded-xl w-3/4" />

      {/* Content blocks */}
      {Array.from({ length: 3 }).map((_, i) => (
        <div key={i} className="space-y-2">
          <div className="h-4 bg-gradient-to-r from-muted to-muted/40 rounded w-1/4" />
          <div className="h-24 bg-gradient-to-r from-muted/80 to-muted/30 rounded-xl" />
        </div>
      ))}
    </div>
  );
}
