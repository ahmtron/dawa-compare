const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://vjdiploktigflvyccqqp.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqZGlwbG9rdGlnZmx2eWNjcXFwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODM2NTUzNTYsImV4cCI6MjA5OTIzMTM1Nn0.9ScsyYAwqdOVtzci6qehDxWuXJmbrnEK0zWd_T-6grA';

const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
  console.log("Starting test query...");
  
  // Test query on medicines
  const { data: medData, error: medError } = await supabase
    .from('medicines')
    .select('id, brand_name, category:categories(name)')
    .ilike('brand_name', '%Panadol%')
    .eq('is_active', true)
    .limit(5);

  if (medError) {
    console.error("❌ medicines query error:", medError);
  } else {
    console.log("✅ medicines query success:", JSON.stringify(medData, null, 2));
  }

  // Test query on generics
  const { data: genData, error: genError } = await supabase
    .from('generics')
    .select('id, name')
    .ilike('name', '%Paracetamol%')
    .limit(5);

  if (genError) {
    console.error("❌ generics query error:", genError);
  } else {
    console.log("✅ generics query success:", JSON.stringify(genData, null, 2));
  }
}

run();
