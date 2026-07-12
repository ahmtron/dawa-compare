import { createClient } from '@supabase/supabase-js'

// This should ONLY be used in server environments (API routes, server actions)
// and NEVER exposed to the browser.
export const adminAuthClient = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  }
)
