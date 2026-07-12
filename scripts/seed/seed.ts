import fs from 'fs';
import path from 'path';
import { parse } from 'csv-parse/sync';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Load env
dotenv.config({ path: path.resolve(process.cwd(), '.env.local') });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Missing Supabase environment variables');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function seedData() {
  console.log('Starting Kaggle seed process...');

  try {
    const filePath = path.join(process.cwd(), 'data/kaggal/Medicine_Details.csv');
    if (!fs.existsSync(filePath)) {
      console.log('File not found:', filePath);
      return;
    }

    const fileContent = fs.readFileSync(filePath, 'utf-8');
    const records = parse(fileContent, {
      columns: true,
      skip_empty_lines: true,
      trim: true,
    });

    console.log(`Found ${records.length} records. Taking the first 250 for MVP demo...`);
    const subset = records.slice(0, 250);

    for (const record of subset as any[]) {
      const brandName = record['Medicine Name'];
      const rawComposition = record['Composition']; // e.g., "Amoxycillin (500mg) + Clavulanic Acid (125mg)"
      let categoryName = record['Uses'] ? record['Uses'].split(',')[0].trim() : 'General';
      if (categoryName.startsWith('Treatment of ')) {
        categoryName = categoryName.replace('Treatment of ', '');
      }
      if (!categoryName) categoryName = 'General';
      const manufacturerName = record['Manufacturer'] || 'Unknown';
      const sideEffectsStr = record['Side_effects'] || '';
      const imageUrl = record['Image URL'];

      if (!brandName || !rawComposition) continue;

      // 1. Category
      let categoryId;
      let { data: catData } = await supabase.from('categories').select('id').eq('name', categoryName).single();
      if (catData) {
        categoryId = catData.id;
      } else {
        const { data: newCat } = await supabase.from('categories').insert({ name: categoryName }).select('id').single();
        categoryId = newCat?.id;
      }

      // 2. Manufacturer
      let manufacturerId;
      let { data: mfrData } = await supabase.from('manufacturers').select('id').eq('name', manufacturerName).single();
      if (mfrData) {
        manufacturerId = mfrData.id;
      } else {
        const { data: newMfr } = await supabase.from('manufacturers').insert({ name: manufacturerName, country: 'India' }).select('id').single();
        manufacturerId = newMfr?.id;
      }

      // 3. Medicine
      let medicineId;
      let { data: medData } = await supabase.from('medicines').select('id').eq('brand_name', brandName).single();
      if (!medData) {
        const { data: newMed } = await supabase.from('medicines').insert({
          brand_name: brandName,
          category_id: categoryId,
          manufacturer_id: manufacturerId,
          image_url: imageUrl,
          country: 'India (Kaggle dataset)',
          is_active: true
        }).select('id').single();
        medicineId = newMed?.id;
      } else {
        medicineId = medData.id;
      }

      // 4. Generics and Composition
      // Parsing "Amoxycillin (500mg) + Clavulanic Acid (125mg)"
      const components = rawComposition.split('+').map((c: string) => c.trim());
      for (const comp of components) {
        const match = comp.match(/^(.*?)(?:\s*\((.*?)\))?$/);
        if (match) {
          const genName = match[1].trim();
          const strength = match[2] ? match[2].trim() : null; // "500mg"
          
          let strengthValue = null;
          let strengthUnit = null;
          if (strength) {
            const strMatch = strength.match(/^([\d.]+)\s*([a-zA-Z%]+)$/);
            if (strMatch) {
              strengthValue = parseFloat(strMatch[1]);
              strengthUnit = strMatch[2];
            } else {
              strengthUnit = strength;
            }
          }

          let genericId;
          let { data: genData } = await supabase.from('generics').select('id').eq('name', genName).single();
          if (genData) {
            genericId = genData.id;
          } else {
            const { data: newGen } = await supabase.from('generics').insert({ name: genName, category_id: categoryId }).select('id').single();
            genericId = newGen?.id;
          }

          if (medicineId && genericId) {
            await supabase.from('medicine_compositions').upsert({
              medicine_id: medicineId,
              generic_id: genericId,
              strength_value: strengthValue,
              strength_unit: strengthUnit
            }, { onConflict: 'medicine_id,generic_id' }).select();
            
            // 5. Side Effects (associated with the generic)
            if (sideEffectsStr) {
              // The CSV has space separated side effects starting with capital letters
              const effects = sideEffectsStr.split(/(?=[A-Z])/).map((e: string) => e.trim()).filter((e: string) => e);
              for (const effect of effects) {
                // Check if already exists for this generic
                const { data: existingEffect } = await supabase.from('side_effects').select('id')
                  .eq('generic_id', genericId)
                  .eq('description', effect)
                  .single();
                  
                if (!existingEffect) {
                  await supabase.from('side_effects').insert({
                    generic_id: genericId,
                    description: effect,
                    severity: 'mild',
                    source: 'Kaggle Dataset'
                  });
                }
              }
            }
          }
        }
      }
      
      // 6. Dummy Price Record (since Kaggle data doesn't have prices for these, we'll assign a random PKR value for testing the UI)
      if (medicineId) {
         const { data: existingPrice } = await supabase.from('price_records').select('id').eq('medicine_id', medicineId).limit(1);
         if (!existingPrice || existingPrice.length === 0) {
            const randomPrice = Math.floor(Math.random() * (1500 - 50 + 1)) + 50;
            await supabase.from('price_records').insert({
              medicine_id: medicineId,
              price: randomPrice,
              currency: 'PKR',
              source: 'Seed/Demo Data'
            });
         }
      }
    }

    console.log('Seed process complete.');
  } catch (error) {
    console.error('Seed error:', error);
  }
}

seedData();
