'use client';

import React, { useEffect } from 'react';
import { AlertTriangle, RefreshCw } from 'lucide-react';

interface ErrorBoundaryProps {
  children: React.ReactNode;
}

interface ErrorBoundaryState {
  hasError: boolean;
  error?: Error;
}

/**
 * Error Boundary Component
 * Catches errors in React components and displays a fallback UI
 * Usage: Wrap components that might throw errors
 *
 * Example:
 * <ErrorBoundary>
 *   <YourComponent />
 * </ErrorBoundary>
 */
export class ErrorBoundary extends React.Component<ErrorBoundaryProps, ErrorBoundaryState> {
  constructor(props: ErrorBoundaryProps) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): ErrorBoundaryState {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  resetError = () => {
    this.setState({ hasError: false, error: undefined });
  };

  render() {
    if (this.state.hasError) {
      return (
        <ErrorState
          error={this.state.error}
          onRetry={this.resetError}
        />
      );
    }

    return this.props.children;
  }
}

interface ErrorStateProps {
  error?: Error;
  onRetry?: () => void;
  title?: string;
  description?: string;
}

/**
 * Error State Component
 * Displays error message with retry option
 * Used by ErrorBoundary and for network/async errors
 */
export function ErrorState({
  error,
  onRetry,
  title = 'Something went wrong',
  description = 'An unexpected error occurred. Please try again or contact support if the problem persists.',
}: ErrorStateProps) {
  return (
    <div className="flex flex-col items-center justify-center py-12 px-6 bg-card text-card-foreground rounded-xl border border-rose-500/20 transition-all duration-300">
      <div className="mb-4 p-3 bg-rose-500/10 rounded-full">
        <AlertTriangle className="w-6 h-6 text-rose-500 animate-pulse" />
      </div>

      <h3 className="text-lg font-bold text-foreground mb-2 text-center leading-snug">{title}</h3>
      <p className="text-muted-foreground text-sm text-center max-w-md mb-6 leading-relaxed">{description}</p>

      {error && (
        <details className="mb-6 w-full max-w-md">
          <summary className="cursor-pointer text-xs font-semibold text-muted-foreground hover:text-foreground transition-colors">
            Error details (for debugging)
          </summary>
          <pre className="mt-2 p-4 bg-muted/40 rounded-lg border border-border text-xs overflow-auto max-h-48 text-muted-foreground font-mono">
            {error.message}
            {error.stack && `\n\n${error.stack}`}
          </pre>
        </details>
      )}

      {onRetry && (
        <button
          onClick={onRetry}
          className="inline-flex items-center gap-2 px-5 py-2.5 bg-primary text-primary-foreground rounded-lg text-sm font-semibold hover:bg-primary/90 active:scale-95 shadow-sm transition-all duration-200"
        >
          <RefreshCw className="w-4 h-4" />
          Try Again
        </button>
      )}
    </div>
  );
}

/**
 * Network Error State
 * Specific error UI for network/connectivity issues
 */
export function NetworkErrorState({ onRetry }: { onRetry?: () => void }) {
  return (
    <ErrorState
      title="Connection error"
      description="Unable to connect to the server. Please check your internet connection and try again."
      onRetry={onRetry}
    />
  );
}

/**
 * Not Found Error State
 * 404 error UI
 */
export function NotFoundErrorState() {
  return (
    <ErrorState
      title="Not found"
      description="The resource you're looking for doesn't exist or has been removed."
    />
  );
}

/**
 * Server Error State
 * 5xx error UI
 */
export function ServerErrorState({ onRetry }: { onRetry?: () => void }) {
  return (
    <ErrorState
      title="Server error"
      description="Something went wrong on the server. Our team has been notified. Please try again later."
      onRetry={onRetry}
    />
  );
}
