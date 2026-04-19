-- KolaySüt — Supabase Migration
-- Çalıştırma: Supabase Dashboard > SQL Editor

CREATE TABLE IF NOT EXISTS kolaysut_ciftlikler (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  ciftlik_adi text NOT NULL,
  sahip_adi text,
  telefon text,
  sehir text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS kolaysut_senaryolar (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  ciftlik_id uuid REFERENCES kolaysut_ciftlikler(id) ON DELETE CASCADE NOT NULL,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  senaryo_adi text NOT NULL DEFAULT 'Yeni Senaryo',
  aciklama text,
  is_aktif boolean DEFAULT false,
  fiyatlar jsonb DEFAULT '{}',
  suru jsonb DEFAULT '{}',
  rasyon jsonb DEFAULT '{}',
  giderler jsonb DEFAULT '{}',
  enflasyon jsonb DEFAULT '{}',
  kredi jsonb DEFAULT '{}',
  gelir_kanallari jsonb DEFAULT '{}',
  senaryo_params jsonb DEFAULT '{}',
  yatirimlar jsonb DEFAULT '{}',
  sonuclar jsonb DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS kolaysut_raporlar (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  ciftlik_id uuid REFERENCES kolaysut_ciftlikler(id) ON DELETE CASCADE NOT NULL,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  senaryo_id uuid REFERENCES kolaysut_senaryolar(id) ON DELETE SET NULL,
  rapor_adi text NOT NULL,
  rapor_tipi text DEFAULT 'fizibilite',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE kolaysut_ciftlikler ENABLE ROW LEVEL SECURITY;
ALTER TABLE kolaysut_senaryolar ENABLE ROW LEVEL SECURITY;
ALTER TABLE kolaysut_raporlar ENABLE ROW LEVEL SECURITY;

CREATE POLICY "kullanici_kendi_ciftligini_gorur" ON kolaysut_ciftlikler
  FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "kullanici_kendi_senaryolarini_gorur" ON kolaysut_senaryolar
  FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "kullanici_kendi_raporlarini_gorur" ON kolaysut_raporlar
  FOR ALL USING (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER kolaysut_ciftlikler_updated
  BEFORE UPDATE ON kolaysut_ciftlikler
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER kolaysut_senaryolar_updated
  BEFORE UPDATE ON kolaysut_senaryolar
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
