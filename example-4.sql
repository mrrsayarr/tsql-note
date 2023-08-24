-- PROCEDURE
-- PROCEDURE
-- PROCEDURE
-- PROCEDURE
-- PROCEDURE
-- PROCEDURE (SAKLI YORDAM)

-- PROCEDURE > VİEW

create proc proc_name (
    -- varsa parametreler

) as 
-- sorgular, kodlar, şartlar, fonksiyonlar

create proc ornekProc
(
    @id int
) as 
select * from  TABLO_ADI where musteriNo >= @id

exec ornekProc 3 -- 3 ten büyük olan değerleri getirir 
-- exec Procedure çalıştırmak için kullanılır

----------------------------------------------------------------

create proc ornekProc2
(
    @id int
    @point int 
) as 
select * from  TABLO_ADI where musteriNo >= @id or puan >= @point
go
exec ornekProc2 3,50

----------------------------------------------------------------

Alter proc sonucGetir (
    @bf int 
) as
select * from TABLO_ADI where birimFiyat >= @bf
return @@rowcount 

go 

declare @sonuc int 
exec @sonuc = sonucGetir 45
print cast(@sonuc as nvarchar(MAX)) + ' Kadar ürün sorgulandı'
-- Çıktı olarak: 1 kadar ürün sorgulandı

----------------------------------------------------------------

create proc MusteriGetir (
    @id int
    @ad nvarchar(MAX) output,
    @soyad nvarchar(MAX) output
) as 
select @ad = ad, @soyad = soyad from TABLO_ADI where musNo = @id

declare @musAd nvarchar(MAX), @musSoyad nvarchar(MAX)
exec MusteriGetir 5, @musAd output, @musSoyad output
print @musAd + ' ' + @musSoyad as AD_SOYAD 
-- AD_SOYAD adında Tablo oluşturur ve içine: 
-- Çıktı olark : "Beyza kılıç" döner 

----------------------------------------------------------------

-- Dışardan aldığı isim, soyisim ve şehir bilgilerini
-- Personeller tablosundaki  iligili saklı yordamı (Procedure) yaz

create table personel (
    ad nvarchar(MAX),
    soyad nvarchar(MAX),
    sehir nvarchar(MAX)
);
go
create proc ekle (
    @ad_ nvarchar(MAX),
    @soyad_ nvarchar(MAX),
    @sehir_ nvarchar(MAX)
)
as
instert personel(ad, soyad, sehir) values (@ad_, @soyad_, @sehir_)

exec ekle 'Yavuz', 'Ceylan', 'Mardin'
exec ekle 'Yavuz Ali', 'şule', 'Denizli'
exec ekle 'Ahmegt', 'Deniz', 'İstanbul'
exec ekle 'Merve', 'Keriz', 'Ankara'

select * from TABLO_ADI -- Diyerek sonuçlar tablo şeklinde gözükür

---------

-- Eğer herhangi bir bilgi verilmiyorsa aşağıdaki tarife uygulanabilir
Alter proc ekle (
    @ad_ nvarchar(MAX) = 'No name',
    @soyad_ nvarchar(MAX) = 'No Surname',
    @sehir_ nvarchar(MAX) = 'No city'
)

exec(select * from TABLO_ADI) -- Tüm sorguları çalıştırır

----------------------------------------------------------------

create proc sp_TabloOlustur (
    @tabloadi nvarchar(MAX),
    @kolon1 nvarchar(MAX),
    @kolon1oz nvarchar(MAX),
    @kolon2 nvarchar(MAX),
    @kolon2oz nvarchar(MAX)
)

as

exec(
    'crete table ' + @tabloadi + ' ( ' + @kolon1 + ' ' + kolon1oz + ', ' + kolon2 + ' ' + kolon2oz + ' )'
)

exec sp_TabloOlustur 'Tablom1', 'ID', 'int primary key identity(100, 1)', 'kolon2', 'nvarchar(MAX)'

select * from Tablom1 -- ID ve kolon2 sütüunlu bir tablo oluşur

----------------------------------------------------------------

-- view mi procedure çağırır, procedure mi view çağırır ?

-- PROCEDURE >> VİEW











