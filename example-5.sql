
-- DML VE DDL
-- TETİKLEYİCİ

create trigger TRIGGER_ADI
after delete, insert, update
-- ya da for
as
-- kodlar tetiklenecek

----------------------------------------------------------------

-- INSERT
create trigger trgInsert
on TABLO_ADI
after insert
as 
select * from TABLO_ADI

insert TABLO_ADI(ad,soyad) values ('Murat', 'Aydın') -- Ekleme yapınca tetiklenir

----------------------------------------------------------------

-- DELETE 
create trigger trgDelete
on TABLO_ADI
after delete
as
update TABLO_ADI set birimFiyat = birimFiyat + 5
select * from TABLO_ADI

delete from TABLO_ADI where id = 120

----------------------------------------------------------------

-- UPDATE
create trigger trgUpdate
on TABLO_ADI
after update
as
insert orders(orderID, customerID, orderDate) values (RAND(), RAND(), GETDATE())

select * from TABLO_ADI -- görmek için

update TABLO_ADI set sehir='Adana' shere musNo=6

----------------------------------------------------------------

-- LOG TUTMA UYGULAMASI YAPIMI
create table logTable(
    id int primary key identity(1,1),
    aciklama nvarchar(MAX)
)

create trigger LogExample
on TABLO_ADI
after delete
as
declare @adi nvarchar(MAX), @soyadi nvarchar(MAX)

select @adi=ad, @soyadi=soyad from deleted -- Geçici tablodan çeker
insert logTable (aciklama) values (@adi + ' ' + @soyadi + 'ad soyadı personel '
 + SUSER_SNAME() + ' kullanıcı tarafindan ' + CONVERT(nvarchar(MAX), GETDATE())
 + ' silinmiştir.' )

delete from TABLO_ADI where nusNo=6

select * from logTable
-- Çıktı: Fatma k0oç detktop... tarafından silinmiştir gib bir şey yazar

----------------------------------------------------------------

create trigger trgUpdate2
on TABLO_ADI
after update
as
declare @eskiadi nvarchar(MAX), @yeniadi nvarchar(MAX)

select @eskiadi=ad from deleted
select @yeniadi=ad from inserted

insert logTable(aciklama) values ('Adi:' 
 + @eskiadi + ' olan personel' 
 + @yeniadi 
 + ' yeni adıyla  '
 + SUSER_SNAME() + ' kullanıcı tarafindan ' 
 + CONVERT(nvarchar(MAX), GETDATE())
 + ' tarihinde güncellenmiştir.' )

 update personeller set ad = 'mehmet' where id =104


