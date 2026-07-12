
-- Generated Seed Data
DO $$
DECLARE
  v_cat_id uuid;
  v_mfr_id uuid;
  v_med_id uuid;
  v_gen_id uuid;
BEGIN

  -- Record 1: Avastin 400mg Injection
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Cancer of colon and rectum Non-small cell lung cancer Kidney cancer Brain tumor Ovarian cancer Cervical cancer';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Cancer of colon and rectum Non-small cell lung cancer Kidney cancer Brain tumor Ovarian cancer Cervical cancer') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Roche Products India Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Roche Products India Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Avastin 400mg Injection';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Avastin 400mg Injection', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/f5a26c491e4d48199ab116a69a969be3.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 809, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Bevacizumab
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Bevacizumab';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Bevacizumab', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 400, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rectal bleeding') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rectal bleeding', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Taste change') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Taste change', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nosebleeds') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nosebleeds', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Back pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Back pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dry skin') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dry skin', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'High blood pressure') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'High blood pressure', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Protein in urine') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Protein in urine', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Inflammation of the nose') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Inflammation of the nose', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 2: Augmentin 625 Duo Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glaxo SmithKline Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glaxo SmithKline Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Augmentin 625 Duo Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Augmentin 625 Duo Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/wy2y9bdipmh6rgkrj0zm.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 298, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Amoxycillin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Amoxycillin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Amoxycillin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Clavulanic Acid
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Clavulanic Acid';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Clavulanic Acid', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 125, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 3: Azithral 500 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Alembic Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Alembic Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Azithral 500 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Azithral 500 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/kqkouvaqejbyk47dvjfu.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 125, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Azithromycin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Azithromycin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Azithromycin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 4: Ascoril LS Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Cough with mucus';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Cough with mucus') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glenmark Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glenmark Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Ascoril LS Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Ascoril LS Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/3205599cc49d4073ae66cbb0dbfded86.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 747, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Ambroxol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Ambroxol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Ambroxol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '30mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hives') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hives', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Levosalbutamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Levosalbutamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Levosalbutamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '1mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hives') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hives', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Guaifenesin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Guaifenesin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Guaifenesin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '50mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hives') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hives', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 5: Aciloc 150 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Gastroesophageal reflux disease (Acid reflux)Treatment of Peptic ulcer disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Gastroesophageal reflux disease (Acid reflux)Treatment of Peptic ulcer disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cadila Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cadila Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aciloc 150 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aciloc 150 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/pn7apngctvrtweencwi1.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 597, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Ranitidine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Ranitidine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Ranitidine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 150, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Gastrointestinal disturbance') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Gastrointestinal disturbance', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 6: Allegra 120mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Sneezing and runny nose due to allergiesTreatment of Allergic conditions';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Sneezing and runny nose due to allergiesTreatment of Allergic conditions') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sanofi India Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sanofi India Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Allegra 120mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Allegra 120mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/fa7427131ec64163b5bbafb529df0736.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1474, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Fexofenadine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Fexofenadine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Fexofenadine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 120, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Drowsiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Drowsiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 7: Avil 25 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Allergic conditionsTreatment of Respiratory disease with excessive mucusTreatment of Skin conditions with inflammation & itchingTreatment and prevention of Meniere''s disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Allergic conditionsTreatment of Respiratory disease with excessive mucusTreatment of Skin conditions with inflammation & itchingTreatment and prevention of Meniere''s disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sanofi India Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sanofi India Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Avil 25 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Avil 25 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/mmsye6bf97tkcocat24j.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 704, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Pheniramine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Pheniramine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Pheniramine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 25, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sedation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sedation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 8: Aricep 5 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Alzheimer''s disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Alzheimer''s disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Eisai Pharmaceuticals India Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Eisai Pharmaceuticals India Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aricep 5 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aricep 5 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/d7ojjdaw2gsm5sie1glu.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 278, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Donepezil
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Donepezil';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Donepezil', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 5, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Common cold') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Common cold', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Urinary incontinence') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Urinary incontinence', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Insomnia difficulty in sleeping') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Insomnia difficulty in sleeping', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Weight loss') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Weight loss', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Accidental injury') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Accidental injury', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 9: Amoxyclav 625 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Abbott';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Abbott', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Amoxyclav 625 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Amoxyclav 625 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/acaa6608e016456f9cafcca2156ad3de.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 807, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Amoxycillin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Amoxycillin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Amoxycillin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Clavulanic Acid
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Clavulanic Acid';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Clavulanic Acid', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 125, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 10: Atarax 25mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'AnxietyTreatment of Skin conditions with inflammation & itching';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('AnxietyTreatment of Skin conditions with inflammation & itching') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Dr Reddy''s Laboratories Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Dr Reddy''s Laboratories Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Atarax 25mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Atarax 25mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/v9py58kciridvbi7bqls.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 833, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Hydroxyzine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Hydroxyzine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Hydroxyzine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 25, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sedation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sedation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 11: Azee 500 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cipla Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cipla Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Azee 500 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Azee 500 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/jbpnjvst3ph0xnrq199o.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1173, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Azithromycin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Azithromycin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Azithromycin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 12: Anovate Cream
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Piles';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Piles') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'USV Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('USV Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Anovate Cream';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Anovate Cream', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/gnsem6ircqxmwmjkprkw.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 316, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Phenylephrine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Phenylephrine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Phenylephrine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.10% w/w')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Application site reactions burning irritation itching and redness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Application site reactions burning irritation itching and redness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Beclometasone
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Beclometasone';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Beclometasone', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.025% w/w')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Application site reactions burning irritation itching and redness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Application site reactions burning irritation itching and redness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Lidocaine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Lidocaine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Lidocaine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '2.50% w/w')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Application site reactions burning irritation itching and redness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Application site reactions burning irritation itching and redness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 13: Allegra-M Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Sneezing and runny nose due to allergies';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Sneezing and runny nose due to allergies') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sanofi India Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sanofi India Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Allegra-M Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Allegra-M Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/eh4vt8l9fuo4nvx3qwif.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 95, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Montelukast
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Montelukast';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Montelukast', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Skin rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Skin rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Flu like symptoms') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Flu like symptoms', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Drowsiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Drowsiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Fexofenadine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Fexofenadine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Fexofenadine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 120, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Skin rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Skin rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Flu like symptoms') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Flu like symptoms', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Drowsiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Drowsiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 14: Ascoril D Plus Syrup Sugar Free
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Dry cough';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Dry cough') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glenmark Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glenmark Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Ascoril D Plus Syrup Sugar Free';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Ascoril D Plus Syrup Sugar Free', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/9fe5ed4f4fce4eaea6588d2ce60115ec.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 618, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Phenylephrine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Phenylephrine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Phenylephrine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 5, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Chlorpheniramine Maleate
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Chlorpheniramine Maleate';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Chlorpheniramine Maleate', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 2, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Dextromethorphan Hydrobromide
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Dextromethorphan Hydrobromide';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Dextromethorphan Hydrobromide', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 15: Alex Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Dry cough';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Dry cough') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glenmark Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glenmark Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Alex Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Alex Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/mqdfwomjrjv3lvlq08ae.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 783, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Phenylephrine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Phenylephrine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Phenylephrine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '5mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Chlorpheniramine Maleate
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Chlorpheniramine Maleate';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Chlorpheniramine Maleate', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '2mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Dextromethorphan Hydrobromide
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Dextromethorphan Hydrobromide';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Dextromethorphan Hydrobromide', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '10mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 16: Armotraz Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Breast cancer';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Breast cancer') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cipla Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cipla Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Armotraz Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Armotraz Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/sytnbc3dtkhxddk5smxs.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 206, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Anastrozole
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Anastrozole';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Anastrozole', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 1, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hot flashes') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hot flashes', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Osteoporosis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Osteoporosis', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Skin rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Skin rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Weakness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Weakness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 17: Augmentin Duo Oral Suspension
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Resistance Tuberculosis (TB)Treatment of Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Resistance Tuberculosis (TB)Treatment of Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glaxo SmithKline Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glaxo SmithKline Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Augmentin Duo Oral Suspension';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Augmentin Duo Oral Suspension', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/hg4gkjmjrg9956tqtmoz.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1284, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Amoxycillin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Amoxycillin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Amoxycillin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 200, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergy') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergy', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Clavulanic Acid
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Clavulanic Acid';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Clavulanic Acid', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 28.5, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergy') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergy', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 18: Albendazole 400mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Parasitic infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Parasitic infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cadila Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cadila Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Albendazole 400mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Albendazole 400mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/c3f704ec89504863915d4433a19d0014.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 71, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Albendazole
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Albendazole';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Albendazole', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 400, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased liver enzymes') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased liver enzymes', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 19: Arkamin Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Hypertension (high blood pressure)';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Hypertension (high blood pressure)') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Torrent Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Torrent Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Arkamin Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Arkamin Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/kvdgswy8eyzkwmulwlyf.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 76, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Clonidine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Clonidine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Clonidine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 100, 'mcg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dryness in mouth') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dryness in mouth', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Fatigue') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Fatigue', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sleepiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sleepiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Insomnia difficulty in sleeping') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Insomnia difficulty in sleeping', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 20: Allegra 180mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Sneezing and runny nose due to allergiesTreatment of Allergic conditions';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Sneezing and runny nose due to allergiesTreatment of Allergic conditions') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sanofi India Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sanofi India Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Allegra 180mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Allegra 180mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/6103f02e6df148fda2a8fd6e87008179.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 181, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Fexofenadine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Fexofenadine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Fexofenadine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 180, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Drowsiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Drowsiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 21: Altraday Capsule SR
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Pain relief';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Pain relief') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sun Pharmaceutical Industries Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sun Pharmaceutical Industries Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Altraday Capsule SR';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Altraday Capsule SR', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/ahmbxmi2bd1wiojpxqld.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 768, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Aceclofenac
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Aceclofenac';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Aceclofenac', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 200, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Flatulence') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Flatulence', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Rabeprazole
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Rabeprazole';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Rabeprazole', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 20, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Flatulence') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Flatulence', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 22: Atarax 10mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'AnxietyTreatment of Skin conditions with inflammation & itching';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('AnxietyTreatment of Skin conditions with inflammation & itching') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Dr Reddy''s Laboratories Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Dr Reddy''s Laboratories Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Atarax 10mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Atarax 10mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/78d80a6bca96417f83c6d38c5c140c0b.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 400, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Hydroxyzine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Hydroxyzine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Hydroxyzine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sedation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sedation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 23: Aldigesic-SP Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Pain relief';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Pain relief') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Alkem Laboratories Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Alkem Laboratories Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aldigesic-SP Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aldigesic-SP Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/86cc6259fcc8462f876cdeb85d9aa87d.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 881, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Aceclofenac
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Aceclofenac';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Aceclofenac', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 100, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Paracetamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Paracetamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Paracetamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 325, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Serratiopeptidase
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Serratiopeptidase';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Serratiopeptidase', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 24: Aldactone Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Hypertension (high blood pressure) Edema Low potassium Heart failure';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Hypertension (high blood pressure) Edema Low potassium Heart failure') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'RPG Life Sciences Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('RPG Life Sciences Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aldactone Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aldactone Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/thkgrdicoq6adxgpwu2e.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1067, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Spironolactone
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Spironolactone';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Spironolactone', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 25, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Leg cramps') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Leg cramps', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Drowsiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Drowsiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Confusion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Confusion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Breast enlargement in male') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Breast enlargement in male', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased creatinine level in blood') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased creatinine level in blood', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 25: Aricep 10 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Alzheimer''s disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Alzheimer''s disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Eisai Pharmaceuticals India Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Eisai Pharmaceuticals India Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aricep 10 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aricep 10 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/fgnxl4znhmpzu2r0mals.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1387, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Donepezil
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Donepezil';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Donepezil', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Common cold') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Common cold', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Urinary incontinence') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Urinary incontinence', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Insomnia difficulty in sleeping') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Insomnia difficulty in sleeping', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Weight loss') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Weight loss', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Accidental injury') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Accidental injury', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 26: Aricep-M  Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Alzheimer''s disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Alzheimer''s disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Eisai Pharmaceuticals India Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Eisai Pharmaceuticals India Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aricep-M  Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aricep-M  Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/a458dc3089a64183962fe107b20f3481.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 976, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Donepezil
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Donepezil';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Donepezil', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 5, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Bleeding under the skin') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Bleeding under the skin', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Memantine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Memantine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Memantine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 5, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Bleeding under the skin') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Bleeding under the skin', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 27: Andre I-Kul Eye Drop
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Allergic eye disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Allergic eye disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Intas Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Intas Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Andre I-Kul Eye Drop';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Andre I-Kul Eye Drop', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/0d82813d035349cea0c99da3fd52469d.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 240, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Camphor
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Camphor';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Camphor', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.01% w/v')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye irritation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye irritation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stinging in the eyes') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stinging in the eyes', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Blurred vision') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Blurred vision', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Photophobia') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Photophobia', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Menthol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Menthol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Menthol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.005% w/v')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye irritation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye irritation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stinging in the eyes') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stinging in the eyes', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Blurred vision') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Blurred vision', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Photophobia') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Photophobia', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Naphazoline
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Naphazoline';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Naphazoline', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.05% w/v')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye irritation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye irritation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stinging in the eyes') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stinging in the eyes', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Blurred vision') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Blurred vision', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Photophobia') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Photophobia', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Phenylephrine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Phenylephrine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Phenylephrine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.12% w/v')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Eye irritation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Eye irritation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stinging in the eyes') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stinging in the eyes', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Blurred vision') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Blurred vision', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Photophobia') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Photophobia', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 28: Anafortan 25 mg/300 mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Abdominal pain';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Abdominal pain') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Abbott';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Abbott', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Anafortan 25 mg/300 mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Anafortan 25 mg/300 mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/4424607f37424d51b2aac2c9d8b18ecd.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 395, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Camylofin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Camylofin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Camylofin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 25, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dryness in mouth') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dryness in mouth', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Blurred vision') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Blurred vision', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Paracetamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Paracetamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Paracetamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 300, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dryness in mouth') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dryness in mouth', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Blurred vision') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Blurred vision', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 29: Atarax Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'AnxietyTreatment of Skin conditions with inflammation & itching';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('AnxietyTreatment of Skin conditions with inflammation & itching') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Dr Reddy''s Laboratories Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Dr Reddy''s Laboratories Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Atarax Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Atarax Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/ktaklgpxpq94qk1tfffg.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 508, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Hydroxyzine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Hydroxyzine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Hydroxyzine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sedation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sedation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Constipation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Constipation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 30: Ambrodil-S Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Cough';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Cough') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Aristo Pharmaceuticals Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Aristo Pharmaceuticals Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Ambrodil-S Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Ambrodil-S Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/c25660f6b3f2447ea4666a0780982a3f.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1300, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Ambroxol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Ambroxol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Ambroxol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '15mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Salbutamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Salbutamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Salbutamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '1mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 31: Asthakind-DX Syrup Sugar Free
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Dry cough';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Dry cough') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Mankind Pharma Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Mankind Pharma Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Asthakind-DX Syrup Sugar Free';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Asthakind-DX Syrup Sugar Free', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/769827d9bf334847a74374b4af97921a.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1372, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Phenylephrine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Phenylephrine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Phenylephrine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '5mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Chlorpheniramine Maleate
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Chlorpheniramine Maleate';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Chlorpheniramine Maleate', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '2mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Dextromethorphan Hydrobromide
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Dextromethorphan Hydrobromide';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Dextromethorphan Hydrobromide', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '15mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 32: Aceclo Plus Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Pain relief';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Pain relief') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Aristo Pharmaceuticals Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Aristo Pharmaceuticals Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aceclo Plus Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aceclo Plus Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/qdjkuq9eipidsadmcosn.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 559, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Aceclofenac
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Aceclofenac';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Aceclofenac', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 100, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain epigastric pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain epigastric pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Paracetamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Paracetamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Paracetamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 325, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain epigastric pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain epigastric pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 33: Althrocin 500 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Alembic Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Alembic Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Althrocin 500 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Althrocin 500 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/suqhdntiejebthfbdpy0.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 925, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Erythromycin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Erythromycin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Erythromycin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 34: Asthalin Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Chronic obstructive pulmonary disease (COPD)Treatment and prevention of Asthma';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Chronic obstructive pulmonary disease (COPD)Treatment and prevention of Asthma') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cipla Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cipla Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Asthalin Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Asthalin Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/45fbf90154794c7dae0630d5c201f368.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 321, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Salbutamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Salbutamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Salbutamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '2mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nervousness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nervousness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 35: Axcer  90mg Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Prevention of heart attack and stroke';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Prevention of heart attack and stroke') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sun Pharmaceutical Industries Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sun Pharmaceutical Industries Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Axcer  90mg Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Axcer  90mg Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/6c8ab4b43c254532b37e035eaf3f931c.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 352, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Ticagrelor
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Ticagrelor';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Ticagrelor', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 90, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Bleeding') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Bleeding', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Breathlessness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Breathlessness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 36: Arachitol 6L Injection
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Vitamin D deficiencyTreatment of Osteoporosis';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Vitamin D deficiencyTreatment of Osteoporosis') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Abbott';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Abbott', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Arachitol 6L Injection';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Arachitol 6L Injection', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/485c7b62664a44fd984080ee0ee15906.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 136, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Vitamin D3
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Vitamin D3';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Vitamin D3', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 600000, 'IU')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Injection site reactions pain swelling redness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Injection site reactions pain swelling redness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Weakness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Weakness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Metallic taste') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Metallic taste', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 37: Alfoo 10mg Tablet PR
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Benign prostatic hyperplasia';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Benign prostatic hyperplasia') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Dr Reddy''s Laboratories Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Dr Reddy''s Laboratories Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Alfoo 10mg Tablet PR';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Alfoo 10mg Tablet PR', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/a34pbmqti99hu1y1zz5r.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1081, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Alfuzosin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Alfuzosin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Alfuzosin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 10, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upper respiratory tract infection') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upper respiratory tract infection', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Impotence') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Impotence', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 38: Azithral 200 Liquid
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Alembic Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Alembic Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Azithral 200 Liquid';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Azithral 200 Liquid', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/mbdxk2kboh3llijyaao2.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 512, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Azithromycin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Azithromycin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Azithromycin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '200mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 39: Acemiz Plus Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Pain relief';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Pain relief') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Lupin Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Lupin Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Acemiz Plus Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Acemiz Plus Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/m7bioz7rvmxcfshqu3iz.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 992, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Aceclofenac
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Aceclofenac';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Aceclofenac', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 100, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain epigastric pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain epigastric pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Paracetamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Paracetamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Paracetamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 325, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain epigastric pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain epigastric pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Heartburn') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Heartburn', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 40: Allegra Suspension Raspberry &amp; Vanilla
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Sneezing and runny nose due to allergiesTreatment of Allergic conditions';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Sneezing and runny nose due to allergiesTreatment of Allergic conditions') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sanofi India Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sanofi India Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Allegra Suspension Raspberry &amp; Vanilla';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Allegra Suspension Raspberry &amp; Vanilla', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/9ddf89aa480145c6830f45e48626336d.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 858, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Fexofenadine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Fexofenadine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Fexofenadine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '30mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Drowsiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Drowsiness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 41: Alex Junior Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Dry cough';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Dry cough') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glenmark Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glenmark Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Alex Junior Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Alex Junior Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/ljalzjzxyy64yutmr3tw.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1285, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Chlorpheniramine Maleate
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Chlorpheniramine Maleate';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Chlorpheniramine Maleate', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '2mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sleepiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sleepiness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Dextromethorphan Hydrobromide
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Dextromethorphan Hydrobromide';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Dextromethorphan Hydrobromide', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '5mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sleepiness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sleepiness', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 42: Azicip 500 Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cipla Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cipla Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Azicip 500 Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Azicip 500 Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/dwqhqfos0hlzsltrwraf.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 514, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Azithromycin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Azithromycin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Azithromycin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 43: Avil Injection
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Allergic conditionsTreatment of Respiratory disease with excessive mucusTreatment of Skin conditions with inflammation & itchingTreatment and prevention of Meniere''s disease';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Allergic conditionsTreatment of Respiratory disease with excessive mucusTreatment of Skin conditions with inflammation & itchingTreatment and prevention of Meniere''s disease') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Sanofi India Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Sanofi India Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Avil Injection';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Avil Injection', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/n2al1qoxuxtzshwgwbt0.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 102, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Pheniramine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Pheniramine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Pheniramine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 22.75, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Sedation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Sedation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 44: Aquasol A Capsule
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Vitamin A deficiency';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Vitamin A deficiency') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'USV Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('USV Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Aquasol A Capsule';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Aquasol A Capsule', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/mytnmvyspijambekkody.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1147, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Vitamin A
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Vitamin A';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Vitamin A', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 25000, 'IU')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'No common side effects seen') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'No common side effects seen', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 45: Anobliss Cream
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Anal fissure';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Anal fissure') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Samarth Life Sciences Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Samarth Life Sciences Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Anobliss Cream';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Anobliss Cream', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/612a8de029ee416ab320d109d19d2293.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 162, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Lidocaine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Lidocaine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Lidocaine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '1.5% w/w')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Anal irritation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Anal irritation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Nifedipine
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Nifedipine';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Nifedipine', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.3% w/w')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Anal irritation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Anal irritation', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 46: Augmentin DDS Suspension
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Resistant Tuberculosis (TB)Treatment of Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Resistant Tuberculosis (TB)Treatment of Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glaxo SmithKline Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glaxo SmithKline Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Augmentin DDS Suspension';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Augmentin DDS Suspension', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/kafbzrabyoihauyvnig4.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 329, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Amoxycillin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Amoxycillin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Amoxycillin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '400mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergy') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergy', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Clavulanic Acid
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Clavulanic Acid';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Clavulanic Acid', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '57mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Abdominal pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Abdominal pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergy') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergy', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Mucocutaneous candidiasis') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Mucocutaneous candidiasis', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 47: Almox 500 Capsule
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Bacterial infections';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Bacterial infections') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Alkem Laboratories Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Alkem Laboratories Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Almox 500 Capsule';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Almox 500 Capsule', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/h4y2f030gju0ftmou0t5.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 69, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Amoxycillin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Amoxycillin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Amoxycillin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 500, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Skin rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Skin rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 48: AF Kit Tablet
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Syndromic treatment of vaginal discharge';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Syndromic treatment of vaginal discharge') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Systopic Laboratories Pvt Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Systopic Laboratories Pvt Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'AF Kit Tablet';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('AF Kit Tablet', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/hfobjftgqrervreplh6u.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1074, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Azithromycin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Azithromycin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Azithromycin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 1000, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Taste change') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Taste change', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Ornidazole
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Ornidazole';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Ornidazole', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 750, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Taste change') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Taste change', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Fluconazole
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Fluconazole';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Fluconazole', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 150, 'mg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Taste change') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Taste change', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Indigestion') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Indigestion', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Loss of appetite') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Loss of appetite', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 49: Ascoril LS Junior Syrup
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Cough with mucus';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Cough with mucus') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Glenmark Pharmaceuticals Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Glenmark Pharmaceuticals Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Ascoril LS Junior Syrup';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Ascoril LS Junior Syrup', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/r22ftufqfbkaxevlo6wn.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 1397, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Ambroxol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Ambroxol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Ambroxol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '15mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hives') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hives', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Levosalbutamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Levosalbutamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Levosalbutamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '0.5mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hives') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hives', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Generic: Guaifenesin
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Guaifenesin';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Guaifenesin', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, NULL, '50mg/5ml')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Nausea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Nausea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Vomiting') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Vomiting', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Diarrhea') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Diarrhea', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Upset stomach') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Upset stomach', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Stomach pain') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Stomach pain', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Allergic reaction') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Allergic reaction', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Dizziness') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Dizziness', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Rash') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Rash', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Hives') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Hives', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  -- Record 50: Asthalin 100mcg Inhaler
  -- Category
  SELECT id INTO v_cat_id FROM categories WHERE name = 'Chronic obstructive pulmonary disease (COPD)Treatment and prevention of Asthma';
  IF NOT FOUND THEN
    INSERT INTO categories (name) VALUES ('Chronic obstructive pulmonary disease (COPD)Treatment and prevention of Asthma') RETURNING id INTO v_cat_id;
  END IF;

  -- Manufacturer
  SELECT id INTO v_mfr_id FROM manufacturers WHERE name = 'Cipla Ltd';
  IF NOT FOUND THEN
    INSERT INTO manufacturers (name, country) VALUES ('Cipla Ltd', 'India') RETURNING id INTO v_mfr_id;
  END IF;

  -- Medicine
  SELECT id INTO v_med_id FROM medicines WHERE brand_name = 'Asthalin 100mcg Inhaler';
  IF NOT FOUND THEN
    INSERT INTO medicines (brand_name, category_id, manufacturer_id, image_url, country, is_active)
    VALUES ('Asthalin 100mcg Inhaler', v_cat_id, v_mfr_id, 'https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/9117d15a82fc4d41889e083e295d7de9.jpg', 'India (Kaggle dataset)', true)
    RETURNING id INTO v_med_id;
  END IF;

  -- Dummy Price
  IF NOT EXISTS (SELECT 1 FROM price_records WHERE medicine_id = v_med_id) THEN
    INSERT INTO price_records (medicine_id, price, currency, source)
    VALUES (v_med_id, 604, 'PKR', 'Seed/Demo Data');
  END IF;

  -- Generic: Salbutamol
  SELECT id INTO v_gen_id FROM generics WHERE name = 'Salbutamol';
  IF NOT FOUND THEN
    INSERT INTO generics (name, category_id) VALUES ('Salbutamol', v_cat_id) RETURNING id INTO v_gen_id;
  END IF;

  -- Composition link
  INSERT INTO medicine_compositions (medicine_id, generic_id, strength_value, strength_unit)
  VALUES (v_med_id, v_gen_id, 100, 'mcg')
  ON CONFLICT (medicine_id, generic_id) DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Tremors') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Tremors', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Headache') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Headache', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Palpitations') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Palpitations', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Increased heart rate') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Increased heart rate', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Muscle cramp') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Muscle cramp', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Respiratory tract inflammation') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Respiratory tract inflammation', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Respiratory tract infection') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Respiratory tract infection', 'mild', 'Kaggle Dataset');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM side_effects WHERE generic_id = v_gen_id AND description = 'Cough') THEN
    INSERT INTO side_effects (generic_id, description, severity, source)
    VALUES (v_gen_id, 'Cough', 'mild', 'Kaggle Dataset');
  END IF;

END $$;
