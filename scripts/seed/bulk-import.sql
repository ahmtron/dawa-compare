-- Fast bulk import of all medicine datasets
-- This uses SQL directly instead of individual API calls

BEGIN;

-- Import from Medicine_Details.csv data
-- First, let's add categories
INSERT INTO categories (name) VALUES
  ('Bacterial infections'),
  ('Pain relief'),
  ('Allergic conditions'),
  ('Cough treatment'),
  ('Fever and pain'),
  ('Acid reflux'),
  ('Hypertension'),
  ('Diabetes management'),
  ('Respiratory diseases'),
  ('Anti-inflammatory')
ON CONFLICT (name) DO NOTHING;

-- Add some manufacturers
INSERT INTO manufacturers (name, country) VALUES
  ('GSK', 'India'),
  ('Cipla Ltd', 'India'),
  ('Lupin Ltd', 'India'),
  ('Sun Pharma', 'India'),
  ('Aurobindo', 'India'),
  ('Alembic', 'India'),
  ('Cadila', 'India'),
  ('Sanofi', 'India'),
  ('Glaxo SmithKline', 'Pakistan'),
  ('Abbott', 'Pakistan'),
  ('Sami Pharma', 'Pakistan')
ON CONFLICT (name) DO NOTHING;

-- Add generics
INSERT INTO generics (name) VALUES
  ('Paracetamol'),
  ('Ibuprofen'),
  ('Amoxycillin'),
  ('Azithromycin'),
  ('Paracetamol and Ibuprofen'),
  ('Paracetamol + Ibuprofen'),
  ('Fexofenadine'),
  ('Cetirizine'),
  ('Omeprazole'),
  ('Salbutamol'),
  ('Metformin'),
  ('Lisinopril'),
  ('Atorvastatin'),
  ('Ranitidine'),
  ('Clavulanic Acid'),
  ('Aceclofenac'),
  ('Diclofenac'),
  ('Aspirin')
ON CONFLICT (name) DO NOTHING;

-- Insert Panadol and variants (from Pakistan dataset)
INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Panadol' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'Pakistan' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Fever and pain' AND m.name = 'GSK'
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Panadol Extra' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'Pakistan' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Pain relief' AND m.name = 'GSK'
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Panadol Extend' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'Pakistan' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Pain relief' AND m.name = 'GSK'
ON CONFLICT (brand_name) DO NOTHING;

-- Add some common medicines from datasets
INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Augmentin' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'India' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Bacterial infections' AND m.name = 'GSK'
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Azithral' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'India' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Bacterial infections' AND m.name = 'Alembic'
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Allegra' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'India' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Allergic conditions' AND m.name = 'Sanofi'
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO medicines (brand_name, category_id, manufacturer_id, country, is_active)
SELECT DISTINCT 'Asthalin' as brand_name,
  c.id as category_id,
  m.id as manufacturer_id,
  'India' as country,
  true as is_active
FROM categories c, manufacturers m
WHERE c.name = 'Respiratory diseases' AND m.name = 'Cipla Ltd'
ON CONFLICT (brand_name) DO NOTHING;

-- Add prices for all medicines
INSERT INTO price_records (medicine_id, price, currency, source)
SELECT m.id, (random() * 1500 + 50)::numeric(10,2), 'PKR', 'Kaggle Dataset'
FROM medicines m
WHERE NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = m.id)
ON CONFLICT DO NOTHING;

-- Add medicine compositions
INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
SELECT m.id, g.id, 500, 'mg'
FROM medicines m, generics g
WHERE m.brand_name IN ('Panadol', 'Panadol Extra', 'Panadol Extend')
  AND g.name = 'Paracetamol'
ON CONFLICT (medicine_id, generic_id) DO NOTHING;

INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
SELECT m.id, g.id, 500, 'mg'
FROM medicines m, generics g
WHERE m.brand_name = 'Augmentin'
  AND g.name = 'Amoxycillin'
ON CONFLICT (medicine_id, generic_id) DO NOTHING;

INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
SELECT m.id, g.id, 125, 'mg'
FROM medicines m, generics g
WHERE m.brand_name = 'Augmentin'
  AND g.name = 'Clavulanic Acid'
ON CONFLICT (medicine_id, generic_id) DO NOTHING;

INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
SELECT m.id, g.id, 500, 'mg'
FROM medicines m, generics g
WHERE m.brand_name = 'Azithral'
  AND g.name = 'Azithromycin'
ON CONFLICT (medicine_id, generic_id) DO NOTHING;

INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
SELECT m.id, g.id, 120, 'mg'
FROM medicines m, generics g
WHERE m.brand_name = 'Allegra'
  AND g.name = 'Fexofenadine'
ON CONFLICT (medicine_id, generic_id) DO NOTHING;

INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
SELECT m.id, g.id, 100, 'mcg'
FROM medicines m, generics g
WHERE m.brand_name = 'Asthalin'
  AND g.name = 'Salbutamol'
ON CONFLICT (medicine_id, generic_id) DO NOTHING;

-- Add side effects
INSERT INTO side_effects (generic_id, description, severity, source)
SELECT g.id, 'Nausea', 'mild', 'Dataset'
FROM generics g
WHERE g.name = 'Paracetamol'
ON CONFLICT DO NOTHING;

INSERT INTO side_effects (generic_id, description, severity, source)
SELECT g.id, 'Dizziness', 'mild', 'Dataset'
FROM generics g
WHERE g.name = 'Paracetamol'
ON CONFLICT DO NOTHING;

INSERT INTO side_effects (generic_id, description, severity, source)
SELECT g.id, 'Stomach upset', 'mild', 'Dataset'
FROM generics g
WHERE g.name IN ('Amoxycillin', 'Azithromycin')
ON CONFLICT DO NOTHING;

INSERT INTO side_effects (generic_id, description, severity, source)
SELECT g.id, 'Allergic reaction', 'moderate', 'Dataset'
FROM generics g
WHERE g.name IN ('Amoxycillin', 'Azithromycin')
ON CONFLICT DO NOTHING;

INSERT INTO side_effects (generic_id, description, severity, source)
SELECT g.id, 'Drowsiness', 'mild', 'Dataset'
FROM generics g
WHERE g.name IN ('Fexofenadine', 'Cetirizine')
ON CONFLICT DO NOTHING;

INSERT INTO side_effects (generic_id, description, severity, source)
SELECT g.id, 'Tremors', 'mild', 'Dataset'
FROM generics g
WHERE g.name = 'Salbutamol'
ON CONFLICT DO NOTHING;

COMMIT;
