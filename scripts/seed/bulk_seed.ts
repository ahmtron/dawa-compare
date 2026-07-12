import * as fs from 'fs';
import * as path from 'path';

function escapeSql(str: string) {
  if (!str) return "''";
  return "'" + str.replace(/'/g, "''") + "'";
}

async function runBulkSeed() {
  console.log('Generating bulk seed.sql...');
  
  const rawData = fs.readFileSync(path.resolve(process.cwd(), 'dataset/A_Z_medicines_dataset_of_India.csv'), 'utf8');
  const rows = rawData.split('\n').filter(r => r.trim() !== '');
  const dataRows = rows.slice(1);
  
  // We'll collect unique categories, generics, manufacturers
  const categories = new Set<string>();
  const manufacturers = new Set<string>();
  const generics = new Set<string>();
  
  const medicines = [];
  
  for (const row of dataRows) {
    const cols = [];
    let curr = '';
    let inQuotes = false;
    for (let i = 0; i < row.length; i++) {
      if (row[i] === '"') inQuotes = !inQuotes;
      else if (row[i] === ',' && !inQuotes) { cols.push(curr); curr = ''; }
      else curr += row[i];
    }
    cols.push(curr);
    
    if (cols.length < 6) continue;

    const brandName = cols[1]?.trim() || '';
    if (!brandName) continue;
    
    const manufacturer = cols[2]?.trim() || 'Unknown';
    const rawComposition = cols[3]?.trim() || 'Unknown';
    const category = cols[4]?.trim() || 'General';
    const priceStr = cols[5] || '0';
    const price = parseFloat(priceStr.replace(/[^0-9.]/g, '')) || 0;
    
    categories.add(category);
    manufacturers.add(manufacturer);
    
    const compParts = rawComposition.split('+').map(c => c.trim().split('(')[0].trim()).filter(Boolean);
    compParts.forEach(c => generics.add(c));
    
    medicines.push({ brandName, manufacturer, rawComposition, category, price });
  }

  let sql = `-- Bulk Seed for DawaCompare MVP (approx 11,000 records)\n\n`;
  
  // Categories
  sql += `-- 1. Insert Categories\n`;
  sql += `INSERT INTO categories (name) VALUES \n`;
  const catArray = Array.from(categories);
  sql += catArray.map(c => `(${escapeSql(c)})`).join(',\n');
  sql += `\nON CONFLICT (name) DO NOTHING;\n\n`;

  // Manufacturers
  sql += `-- 2. Insert Manufacturers\n`;
  sql += `INSERT INTO manufacturers (name, country) VALUES \n`;
  const mfrArray = Array.from(manufacturers);
  sql += mfrArray.map(m => `(${escapeSql(m)}, 'India')`).join(',\n');
  sql += `\nON CONFLICT (name) DO NOTHING;\n\n`;

  // Generics
  sql += `-- 3. Insert Generics\n`;
  sql += `INSERT INTO generics (name) VALUES \n`;
  const genArray = Array.from(generics);
  // Batch these if needed, but PostgreSQL can easily handle a 10,000 row insert.
  sql += genArray.map(g => `(${escapeSql(g)})`).join(',\n');
  sql += `\nON CONFLICT (name) DO NOTHING;\n\n`;

  // Medicines
  sql += `-- 4. Insert Medicines (Using CTEs to resolve IDs)\n`;
  // We can't insert 11,000 using nested selects in a single statement without hitting stack limits or slow parsing.
  // Instead, let's write thousands of individual insert statements for medicines.
  // Or better, we can use a temporary table and copy, but SQL script is easier.
  // Let's batch medicines into inserts of 1000.
  
  let tempSql = `
    CREATE TEMP TABLE temp_meds (
      brand_name text,
      category text,
      manufacturer text,
      price numeric,
      composition text
    );\n\n
    INSERT INTO temp_meds (brand_name, category, manufacturer, price, composition) VALUES \n
  `;
  
  const valRows = medicines.map(m => `(${escapeSql(m.brandName)}, ${escapeSql(m.category)}, ${escapeSql(m.manufacturer)}, ${m.price}, ${escapeSql(m.rawComposition)})`);
  
  // Batch the temp_meds inserts
  for (let i = 0; i < valRows.length; i += 1000) {
    if (i > 0) tempSql += `\nINSERT INTO temp_meds (brand_name, category, manufacturer, price, composition) VALUES \n`;
    tempSql += valRows.slice(i, i + 1000).join(',\n') + ';\n';
  }
  
  sql += tempSql + '\n';
  
  sql += `-- Now insert from temp_meds resolving IDs\n`;
  sql += `
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, is_active)
    SELECT DISTINCT ON (tm.brand_name)
      tm.brand_name, 
      c.id, 
      m.id, 
      true
    FROM temp_meds tm
    LEFT JOIN categories c ON c.name = tm.category
    LEFT JOIN manufacturers m ON m.name = tm.manufacturer;
  \n`;

  sql += `
    INSERT INTO price_records (medicine_id, price, currency, source)
    SELECT 
      m.id, 
      tm.price, 
      'INR', 
      'Kaggle Dataset'
    FROM temp_meds tm
    JOIN medicines m ON m.brand_name = tm.brand_name;
  \n`;
  
  fs.writeFileSync(path.resolve(process.cwd(), 'scripts/seed/bulk_seed.sql'), sql);
  console.log('Successfully generated scripts/seed/bulk_seed.sql (', Math.round(sql.length / 1024 / 1024 * 100) / 100, 'MB)');
}

runBulkSeed().catch(console.error);
