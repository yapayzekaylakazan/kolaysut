# KolaySüt — Çiftlik Fizibilite Yönetimi

Süt sığırcılığı için tam kapsamlı fizibilite ve yönetim platformu.

## Özellikler

- Çok kullanıcılı yapı (her çiftlik kendi hesabıyla)
- Birden fazla senaryo kaydet / karşılaştır
- Enflasyon parametreli 5 yıl projeksiyon
- Kredi / finansman modülü (eşit taksit / eşit anapara)
- Sürü dinamiği motoru (buzağı → düve → inek)
- Gelir kanalları: süt, buzağı, gübre, ıskarta, süt ürünü
- Monte Carlo simülasyonu (500 iterasyon)
- Başabaş analizi + döviz kuru duyarlılık
- Aylık nakit akışı tablosu (18 ay)
- PDF rapor çıktısı

## Kurulum

1. Bu repoyu GitHub Pages'e yükle
2. `index.html` içindeki `SUPA_URL` ve `SUPA_KEY` değerlerini kendi Supabase projenle güncelle
3. Supabase'de `kolaysut_ciftlikler` ve `kolaysut_senaryolar` tablolarını oluştur (migration dosyasına bak)

## Teknolojiler

- Vanilla JS + HTML/CSS (framework yok)
- Supabase (Auth + PostgreSQL)
- Chart.js
- jsPDF

## Deploy

```bash
git add -A
git commit -m "güncelleme"
git push
```
