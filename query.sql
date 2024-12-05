
WITH FilteredPenjualan AS (
  SELECT 
    p.id_produk, 
    pr.id_produksi,
    SUM(p.jumlah_terjual) AS total_terjual
  FROM 
    table_penjualan p
  JOIN 
    table_produksi pr
  ON 
    p.id_produk = pr.id_produk
  WHERE 
    DATE(p.tanggal_penjualan) BETWEEN '2024-01-01' AND '2024-04-30'
    AND MOD(CAST(RIGHT(pr.id_produksi, 1) AS INT64), 2) = 0
  GROUP BY 
    p.id_produk, pr.id_produksi
),
RankedProduk AS (
  SELECT 
    id_produk, 
    id_produksi,
    total_terjual,
    RANK() OVER (ORDER BY total_terjual DESC) AS rank
  FROM 
    FilteredPenjualan
)
SELECT 
  id_produk, 
  id_produksi, 
  total_terjual
FROM 
  RankedProduk
WHERE 
  rank = 1;
