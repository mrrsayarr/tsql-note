



declare @x int = 3
declare @y varchar(40) = 'Amasya'
declare @z datetime2

set @z = getdate(); -- Bugünün tarihini getirir
select 'Bugünün tarihi: ' + cast(@z as varchar(30)) -- ÇIKTI: Bugünün tarihi: 12.03.2023 13.12... diye yazar 
-- tür değişikliği için "cast" kullanılır

--------------------------------------------------------------

select ad, soyad from TABLO_ADI where ISTENEN_SÜTUN_ADI = 'Samsun'

declare @adi nvarchar(MAX), @soyadi nvarchar(MAX)
select @adi=ad, @soyadi=soyad from TABLO_ADI where ISTENEN_SÜTUN_ADI = 'Samsun'
select @adi [Musteri Adı], @soyadi [Musteri Soyadı] -- Tablo halinde yazdırır

print 'Musteri adı: ' + @adi --Mesaj olarak terminalde verir
print 'Musteri Soyadı: ' + @soyadi --Mesaj olarak terminalde verir


--------------------------------------------------------------

-- "go" AMACI İŞLEMİ BİTEN KOMUTLARI BİRBİRNDEN AYIRIR!
create database database -- db oluşturma
go -- AMACI İŞLEMİ BİTEN KOMUTLARI BİRBİRNDEN AYIRIR
use VERİ_TABANI_ADI -- Veritabanı oluştur
go
Create Table TEST_TABLE (
    kolonID int primary key identity(1,1),
    kolon1 nvarchar(MAX),
    kolon2 nvarchar(MAX)
)

--------------------------------------------------------------

-- İF ElSE KOMUTLARI
declare @isim nvarchar(MAX)
set @isim = 'Funda'

if @isim = 'Funda'
    print 'Doğru'
else 
    print 'Yanlış'

--------------------------

declare @s1 int=3, @s2 int=5

if @s1 * @s2 > 50
begin
    print 'Sonuç: ' + cast(@s1 * @s2 as varchar(5))
    print '50''den büyüktür'
end
else
begin
    print 'Sonuç: ' + cast(@s1 * @s2 as varchar(5))
    print '50''den küçüktür'
end

--------------------------------------------------------------

select * from TABLO where SUTUN = 'Samsun'

if @@ROWCOUNT > 0 -- Sütunda bulunan Samsun sayısı verir yani sütunu okur/sayar
    print 'var'
else
    print 'yok'

--------------------------------------------------------------

declare @adi varchar(30)='Ahmet', @soyadi varchar(50)='Yılmaz'

select * from TABLO_ADI where ad=@adi and soyad=@soyadi

if @@ROWCOUNT > 0
    print 'var' -- Eğer tabloda varsa VAR cevabını döner
else
    print 'yok' -- Eğer tabloda yoksa YOK cevabını döner

--------------------------------------------------------------

delete from TABLO_ADI where ad='canan'
print @@rowcount -- siler ve 1 rows etkilenir

---------------------

insert TABLO_ADI(ad,soyad) values ('Canan', 'Gül111'),('Canan', 'Gül2222'),('Canan', 'Gül333')
print @@rowcount -- Etkilenen satır sayısı: 3 olur


--------------------------------------------------------------

-- exists: Sorgu anlamına gelir
if exists(select * from TABLO_ADI)
    print 'kayıt var'
else
    print 'kayıt yok'

--------------------------------------------------------------

-- while
declare @sayac int = 1

while @sayac < 50
begin   
    print @sayac
    set @sayac += 1
        if sayac%5=0 break -- 5 oldu mu döngü biter
        -- continue olsa 5 ve katlarını yazdırmaz
end

---------------------

-- while
declare @sayac int = 1

while @sayac < 50
begin
    if @sayac%5=0
    begin
        set @sayac += 1
        continue -- continue olsa 5 ve katlarını yazdırmaz
    end
    print @sayac
    set @sayac += 1 
end

--------------------------------------------------------------


declare @harf char(1);
declare @sayac int = 65; -- a=65
set @harf = char(@sayac)
-- print @harf

while @sayac < 91 -- z=65
begin
    print(@sayac)
    set @sayac += 1
end

--------------------------------------------------------------

declare @i int = 1, @j int = 1

while @i < 10
begin
    while @j < 10
    begin
        print(cast(@i as nvarchar(MAX)) + 'x' + cast(@j as nvarchar(MAX)) +  '=' + cast(@i * @j as nvarchar(MAX))
        --print cast(@i * @j as varchar(8))
        set @j = @j + 1
    end

    set @i = @i + 1
    set @j = 1
end

















































