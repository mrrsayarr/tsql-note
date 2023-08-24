

-- geçici tablolar/ temporary tables
-- tablonun orjinalini bozmak istemiyoruz ama bize veriler lazım ise geçici tablolar kullanılır

use DB_NAME
select * from TABLO_ADI

select ad, soyad, sehir into geciciTablo from TABLO_ADI -- Bu sanal değil fiziksel tablo olduğu için bellekte bir alan kaplar


-- Sanal tablo
select ad, soyad, sehir into #geciciTablo2 from TABLO_ADI -- Fiziksel olarak tablo oluşmadı şu an sanalda erişmek için ise:
select * from #geciciTablo2 -- normal şekilde de erişir
select * from #geciciTablo2 where add like '%a%'
delete from #geciciTablo2 where ad = 'abc'
insert #geciciTablo2(ad,soyad) values('abc','sdds'), ('Merve', 'sdfsdf')
-- normal tablolarda nasıl işlem yapılırsa sanal tablolarda da uygulanabilir
-- bellekte tutulur eğer uygulama kapanırsa silinir


select ad, soyad, sehir into ##geciciTablo2 from TABLO_ADI -- olduğunda serverda başka kişilerde geçici tabloyu kullanabilir
-- aynı işlemlerde bunun üzerinden yapılabilir

----------------------------------------------------------------


create table uniqueDeneme (
    id int primary key,
    ad varchar(50),
    kod uniqueidentifier -- newıd()
)

insert uniqueDeneme values(100,'denemeUnique', NEWID())

select * from uniqueDeneme


----------------------------------------------------------------

create view denemeView1
as
-- sorgular 
select CUS.customerName as AD, ORD.orderDate as TARIH -- customerName = AD oldu, orderDate = TARIH oldu
from customers as CUS join orders as ORD 
on CUS.CustomerID = ORD.customerID
-- 2 tablo birleştirildi 
-- customerID lerin eşit olduğu veriler gelir -- Ad ve Tarih kısımları AD ve TARIH adında gelir, NULL ksımlarda gelir
-- bu kod çalıştığı zaman Views sekmesinde kodlar ve tablo ya erişilebilir

select * from denemeView1 where Ad like 'ana%' -- adı ana ile başlayanları getirir

----------------------------------------------------------------

create view denemeView2
as
select top 5 ad, soyad from musteri order by Ad
select * from denemeView2 -- sadece ilk 5 kişinin ad ve soyad sütununu gösterir
-- gösterdiği verilerin tümü sanal yani view tablodadır

----------------------------------------------------------------

create view denemeView3
as 
select ad as ADI, soyad as SOYAD from musteri -- musteri tablosundan verileri çeker
go 
select * from denemeView3


----------------------------------------------------------------

-- with encryption: amaç tabloyu şifreler, değişikliği engellemedir
-- with schemabinding: amaç bağlı olduğu tablolarda herhangi bir tabloya veya sütuna kilit koyma 
-- with check option: amaç 

create view denemeView4
with encryption -- tablo şifrelendi
as
select ad as ADI, soyad as SOYADI from musteri

----------------------------------------------------------------

-- FONKSİYONLAR
-- scalar: geriye değer döndüren fonksiyonlar(varchar, int, byte, char)
-- inline: geriye tablo döndüren fonksiyonlar: örneğin "view" gibi

--view varsa fonkisyon kullanma, fonkisyon varsa view kullanmak sıkıntı olabilir

create function topla(@sayi1 int, @sayi2 int) returns int
as 
begin
    declare @toplam int -- toplam türünü belirttik
    set  @toplam = @sayi1 + @sayi2;
    return @toplam;
end

----------------------------------------------------------------

-- diyelim ki bu kod encrypt edildi
create function topla(@sayi1 int, @sayi2 int) returns int
with encryption
as 
begin
    declare @toplam int -- toplam türünü belirttik
    set  @toplam = @sayi1 + @sayi2;
    return @toplam;
end

select dbo.topla(2,4) -- 6 çıktısnı verir

----------------------------------------------------------------

create table urunstok2 (
    id int  primary key identity(100,0),
    birimfiyat int,
    stokmiktari int
)
go 
insert urunstok2 (birimfiyat, stokmiktari) 
values (15,50), (14,500), (35,508), (25,250)

create function maliyet(@bf int, @sm int) returns nvarchar(MAX)
as
begin
    @declare @sonuc int = @bf*@sm*1.8
    return @sonuc
end

-- dbo yapma sebebi fonksiyon içine erişme amacı var
select id, birimfiyat, stokmiktari, dbo.maliyet(birimfiyat,stokmiktari)
from urunstok2

select * from urunstok2

-- dönen değer tablo olabilir, tablo bırakmıyor































