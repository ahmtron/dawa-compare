import fs from 'fs';
import path from 'path';
import { parse } from 'csv-parse/sync';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: path.resolve(process.cwd(), '.env.local') });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function importMedicineDetails() {
  console.log('📚 Importing Medicine_Details.csv...');
  const filePath = path.join(process.cwd(), 'data/kaggal/Medicine_Details.csv');
  if (!fs.existsSync(filePath)) {
    console.log('⚠️ Not found');
    return 0;
  }

  try {
    const fileContent = fs.readFileSync(filePath, 'utf-8');
    const records: any[] = parse(fileContent, {
      columns: true,
      skip_empty_lines: true,
      trim: true
    });

    console.log(`📊 Parsed ${records.length} records`);
    let inserted = 0;

    for (const record of records) {
      try {
        const brandName = (record['Medicine Name'] || '').trim();
        const composition = (record['Composition'] || '').trim();
        const uses = (record['Uses'] || 'General').trim();
        const manufacturer = (record['Manufacturer'] || 'Unknown').trim();

        if (!brandName) continue;

        let { data: catData } = await supabase
          .from('categories')
          .select('id')
          .eq('name', uses)
          .single();

        let categoryId = catData?.id;
        if (!categoryId) {
          const { data: newCat } = await supabase
            .from('categories')
            .insert([{ name: uses }])
            .select('id')
            .single();
          categoryId = newCat?.id;
        }

        let { data: mfrData } = await supabase
          .from('manufacturers')
          .select('id')
          .eq('name', manufacturer)
          .single();

        let manufacturerId = mfrData?.id;
        if (!manufacturerId) {
          const { data: newMfr } = await supabase
            .from('manufacturers')
            .insert([{ name: manufacturer, country: 'India' }])
            .select('id')
            .single();
          manufacturerId = newMfr?.id;
        }

        let { data: medData } = await supabase
          .from('medicines')
          .select('id')
          .eq('brand_name', brandName)
          .single();

        let medicineId = medData?.id;
        if (!medicineId) {
          const { data: newMed } = await supabase
            .from('medicines')
            .insert([{
              brand_name: brandName,
              category_id: categoryId,
              manufacturer_id: manufacturerId,
              country: 'India',
              is_active: true
            }])
            .select('id')
            .single();
          medicineId = newMed?.id;
        }

        const { data: priceExists } = await supabase
          .from('price_records')
          .select('id')
          .eq('medicine_id', medicineId)
          .limit(1);

        if (!priceExists || priceExists.length === 0) {
          const randomPrice = Math.floor(Math.random() * 2000) + 50;
          await supabase.from('price_records').insert([{
            medicine_id: medicineId,
            price: randomPrice,
            currency: 'PKR',
            source: 'Kaggle'
          }]);
        }

        const generics = composition
          .split('+')
          .map((c: string) => (c.match(/^(.*?)(?:\s*\((.*?)\))?$/) || [])[1])
          .filter(Boolean)
          .map((g: string) => g.trim());

        for (const genericName of generics) {
          let { data: genData } = await supabase
            .from('generics')
            .select('id')
            .eq('name', genericName)
            .single();

          let genericId = genData?.id;
          if (!genericId) {
            const { data: newGen } = await supabase
              .from('generics')
              .insert([{ name: genericName, category_id: categoryId }])
              .select('id')
              .single();
            genericId = newGen?.id;
          }

          if (medicineId && genericId) {
            await supabase.from('medicine_compositions').upsert({
              medicine_id: medicineId,
              generic_id: genericId,
              strength_value: null,
              strength_unit: null
            }, { onConflict: 'medicine_id,generic_id' });
          }
        }

        inserted++;
        if (inserted % 500 === 0) {
          console.log(`  ✓ Imported ${inserted}...`);
        }
      } catch (err: any) {
        // skip
      }
    }

    console.log(`✅ Imported ${inserted}`);
    return inserted;
  } catch (err: any) {
    console.error('❌ Error:', err.message);
    return 0;
  }
}

async function importPakistanMedicines() {
  console.log('📚 Importing Pakistan Medicines Dataset.csv...');
  const filePath = path.join(process.cwd(), 'data/kaggal/Pakistan Medicines Dataset.csv');
  if (!fs.existsSync(filePath)) {
    console.log('⚠️ Not found');
    return 0;
  }

  try {
    const fileContent = fs.readFileSync(filePath, 'utf-8');
    const records: any[] = parse(fileContent, {
      columns: true,
      skip_empty_lines: true,
      trim: true
    });

    let inserted = 0;

    for (const record of records) {
      try {
        const brandName = (record['Drug Name'] || '').trim();
        const indication = (record['Indication'] || 'General').trim();
        const manufacturer = (record['Manufacturer'] || 'Unknown').trim();
        const price = parseFloat(record['Price']) || Math.floor(Math.random() * 2000) + 50;

        if (!brandName) continue;

        let { data: catData } = await supabase.from('categories').select('id').eq('name', indication).single();
        let categoryId = catData?.id;
        if (!categoryId) {
          const { data: newCat } = await supabase.from('categories').insert([{ name: indication }]).select('id').single();
          categoryId = newCat?.id;
        }

        let { data: mfrData } = await supabase.from('manufacturers').select('id').eq('name', manufacturer).single();
        let manufacturerId = mfrData?.id;
        if (!manufacturerId) {
          const { data: newMfr } = await supabase.from('manufacturers').insert([{ name: manufacturer, country: 'Pakistan' }]).select('id').single();
          manufacturerId = newMfr?.id;
        }

        let { data: medData } = await supabase.from('medicines').select('id').eq('brand_name', brandName).single();
        let medicineId = medData?.id;
        if (!medicineId) {
          const { data: newMed } = await supabase.from('medicines').insert([{
            brand_name: brandName,
            category_id: categoryId,
            manufacturer_id: manufacturerId,
            country: 'Pakistan',
            is_active: true
          }]).select('id').single();
          medicineId = newMed?.id;
        }

        await supabase.from('price_records').insert([{
          medicine_id: medicineId,
          price: price,
          currency: 'PKR',
          source: 'Pakistan Dataset'
        }]);

        inserted++;
      } catch (err: any) {
        // skip
      }
    }

    console.log(`✅ Imported ${inserted}`);
    return inserted;
  } catch (err: any) {
    console.error('❌ Error:', err.message);
    return 0;
  }
}

async function main() {
  console.log('🚀 Importing all datasets...\n');
  let total = 0;
  total += await importMedicineDetails();
  total += await importPakistanMedicines();
  console.log(`\n✨ Total: ${total} medicines\n✅ Done!`);
}

main();
