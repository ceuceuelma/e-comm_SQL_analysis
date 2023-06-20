--1.	Kita akan memberikan promosi untuk customer perempuan di kota Depok melalui email. 
--Tolong berikan data ada berapa customer yang harus kita berikan promosi per masing-masing jenis email.
SELECT
 id,
 email
FROM
 `abiding-ascent-303108.ecommerce.customer`
WHERE
 city='Depok'
 AND gender='Female'
ORDER BY
 id ASC


 --2.	Berikan saya 10 id customer dengan total pembelian overall terbesar. 
 --Saya akan memberikan diskon untuk campaign 9.9!
 SELECT
 customer_id,
 SUM(total) total_pembelian
FROM
 `abiding-ascent-303108.ecommerce.transaction`
GROUP BY
 1
ORDER BY
 2 DESC
LIMIT
 10


--3.	Bro! Ada berapa produk ya di database kita yang punya harga kurang dari 10000? 
--Mau gue data nih buat flash sale.
SELECT
 id,
 price
FROM
 `abiding-ascent-303108.ecommerce.product`
WHERE
 price<10000
ORDER BY
 id


--4.	Tolong list 5 product_id yang paling banyak dibeli dong, mau kita kasih diskon nih di campaign 11.11.
SELECT
 product_id,
 SUM(quantity) jumlah_terjual
FROM
 `abiding-ascent-303108.ecommerce.transaction`
GROUP BY
 1
ORDER BY
 2 DESC
LIMIT
 5


 --5.	Berapa jumlah transaksi, pendapatan dan jumlah produk yang terjual di platform kita sekarang secara bulanan? 
 --apakah terjadi kenaikan atau tidak?
SELECT
 DATE_TRUNC(DATE(created_at),MONTH),
 COUNT(DISTINCT id) jumlah_transaksi,
 SUM(quantity) produk_terjual,
 SUM(total) pendapatan
FROM
 `abiding-ascent-303108.ecommerce.transaction`
GROUP BY
 1
ORDER BY
 1 ASC


--6.	Saya ingin melakukan pemerataan marketing di perusahaan kita. 
--Boleh saya minta info Total belanja dan rata-rata belanja dari customer kita per kota?
SELECT
 city,
 SUM(total) total_belanja,
 AVG(total) avg_belanja
FROM
 `abiding-ascent-303108.ecommerce.transaction` a
LEFT JOIN
 abiding-ascent-303108.ecommerce.customer b
ON
 a.customer_id=b.id
GROUP BY
 1
ORDER BY
 2 DESC


--7.	Ada berapa customer yang memiliki total belanja keseluruhan lebih dari > 200000 ? 
--Tolong di breakdown by tipe storenya ya!
SELECT
 type,
 COUNT(DISTINCT customer_id) jumlah_customer
FROM
 `abiding-ascent-303108.ecommerce.transaction` a
LEFT JOIN
 abiding-ascent-303108.ecommerce.store b
ON
 a.store_id=b.id
GROUP BY
 1
HAVING
 SUM(total)>200000
ORDER BY
 2 DESC