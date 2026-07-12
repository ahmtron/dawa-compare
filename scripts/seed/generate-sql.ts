import fs from 'fs';
import path from 'path';
import { parse } from 'csv-parse/sync';

async function generateSqlSeed() {
  console.log('Generating seed.sql from Kaggle dataset...');

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

    console.log(`Found ${records.length} records. Taking the first 50 for MVP demo SQL seed...`);
    const subset = records.slice(0, 50);

    let sql = `
-- Generated Seed Data
DO $$
DECLARE
  v_cat_id uuid;
  v_mfr_id uuid;
  v_med_id uuid;
  v_gen_id uuid;
BEGIN
`;

    // We use PL/pgSQL to handle existence checks and ID retrieval
    for (let i = 0; i < subset.length; i++) {
      const record = subset[i] as any;
      const brandName = record['Medicine Name'].replace(/'/g, "''");
      const rawComposition = record['Composition']; 
      let categoryName = record['Uses'] ? record['Uses'].split(',')[0].trim().replace(/'/g, "''") : 'General';
      if (categoryName.startsWith('Treatment of ')) {
        categoryName = categoryName.replace('Treatment of ', '');
      }
      if (!categoryName) categoryName = 'General';
      const manufacturerName = (record['Manufacturer'] || 'Unknown').replace(/'/g, "''");
      const sideEffectsStr = (record['Side_effects'] || '').replace(/'/g, "''");
      const imageUrl = (record['Image URL'] || '').replace(/'/g, "''");

      if (!brandName || !rawComposition) continue;

      sql += `
  -- Record ${i+1}: ${brandName}
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = '${categoryName}';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('${categoryName}') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = '${manufacturerName}';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('${manufacturerName}', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = '${brandName}';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('${brandName}', v_cat_id, v_mfr_id, '${imageUrl}', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, ${Math.floor(Math.random() * (1500 - 50 + 1)) + 50}, 'PKR', 'Seed/Demo Data');
  END IF;
`;

      const components = rawComposition.split('+').map((c: string) => c.trim());
      for (const comp of components) {
        const match = comp.match(/^(.*?)(?:\s*\((.*?)\))?$/);
        if (match) {
          const genName = match[1].trim().replace(/'/g, "''");
          const strength = match[2] ? match[2].trim().replace(/'/g, "''") : null;
          
          let strengthValue = 'NULL';
          let strengthUnit = 'NULL';
          if (strength) {
            const strMatch = strength.match(/^([\d.]+)\s*([a-zA-Z%]+)$/);
            if (strMatch) {
              strengthValue = strMatch[1];
              strengthUnit = `'${strMatch[2]}'`;
            } else {
              strengthUnit = `'${strength}'`;
            }
          }

          sql += `
  -- Generic: ${genName}
  SELECT id INTO v_gen_id FROM generics WHERE name = '${genName}';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('${genName}', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, ${strengthValue}, ${strengthUnit})
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;
`;

          if (sideEffectsStr) {
            const effects = sideEffectsStr.split(/(?=[A-Z])/).map((e: string) => e.trim()).filter((e: string) => e);
            for (const effect of effects) {
              sql += `
  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = '${effect}') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, '${effect}', 'mild', 'Kaggle Dataset');
  END IF;
`;
            }
          }
        }
      }
    }

    sql += `
END $$;
`;

    fs.writeFileSync(path.join(process.cwd(), 'scripts/seed/seed.sql'), sql);
    console.log('Successfully generated scripts/seed/seed.sql');
  } catch (error) {
    console.error('Seed error:', error);
  }
}

generateSqlSeed();
