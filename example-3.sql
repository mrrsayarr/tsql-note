

-- 20.03.2023 TARHLİ DERS ÖNEMLİ KISIMLAR
rollback -- sınav bakarsın
transaction -- sınav bakarsın
go 
begin end
@@rowcount -- satır sorgulama
if else -- yapısı
-- for döngüsü yok
while 
view -- konusu
-- daha güvenli
with encryption 
with schemabinding
with check option 
---

--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--FONKSİYONLAR
--------------------------------------------------------------------------------------------------

-- VİDEO 3 
create function kareAl(@sayi int) return int --geri değer döndürğü için returns int yazılır
-- Eğer geriye bir mesaj döndürülmek istense return nvarchar(MAX) tarzında bir kullanım şart
as
begin
    return @sayi * @sayi 

end
go
select dbı.kareAl(5) -- Çıktı olarak 25 döner
--Bu fonksiyonun adı SCALER (scaler) fonksiyondur

-- Eğer yukarıdaki işlemde bir değişiklik yapmak istiyoruz tekrar kodu çalıştırınca hata verecektir
-- Bu yüzden crete yerine "alter" kullanmak gerekir

print 'karesi: ' + cast(dbo.kareAl(5) as varchar(20)) -- Mesaj döndürme ve tip dönüşümü

--------------------------------------------------------------------------------------------------

-- Inline fonksiyon örneği
create function inlineOrnek(@ad varchar(20), @soyad varchar(20)) returns table
as 
return select * from TABLO_ADI where ad=@ad or soyad=@soyad

select * from dbo.inlineOrnek('Fatma', 'Aydın') -- İsminde fatma ve aydın geçen kişileri tablo olarak getirecektir

--------------------------------------------------------------------------------------------------

-- with encryption kullanımı
create function inlineOrnek2d(@ad varchar(20), @soyad varchar(20)) returns table
with encryption -- Tabloyu düzenlemeyi kısıtlar
as 
return select * from TABLO_ADI where ad=@ad or soyad=@soyad

--------------------------------------------------------------------------------------------------

create table ogrenciSınav(
    id int primary key identity(2020000,1),
    vize int,
    final int
)
insert ogrenciSınav(vize, final) values (100,60), (40,70),(50,50)

select * from TABLO_ADI 

create function ortalama(@v int, @f int) returns float -- Fonksiyon oluşturur
as
begin
    return @v * 0.4 + @f * 0.6
end

-- tablo ile ilişkilendirme
select id dbo.ortalama(vize,final) from TABLO_ADI where final >= 50
-- ortalaması 50 ve üzerinde olanları tablo halinde gösterir

--------------------------------------------------------------------------------------------------

create function ortalama2(@id int, @v int, @f int) returns nvarchar(MAX) -- Fonksiyon oluşturur
as
begin
    declare @sonuc float = @v * 0.4 + @f * 0.6
    declare @durum nvarchar(MAX)
    declare mesaj nvarchar(MAX) = cast(@id as nvarchar(MAX) ) + 
        'Numarali öğrencinino ortalaması: ' + cast(@sonuc as nvarchar(MAX) )
        if @sonuc >= 60 
            set @durum = 'Geçti :) ' +   @mesaj
        else
            set @durum = 'Kaldı :( ' +   @mesaj
    return @durum
end

--Raporlama
select id, dbo.ortalama2(id, vize, final) as 

--------------------------------------------------------------------------------------------------

