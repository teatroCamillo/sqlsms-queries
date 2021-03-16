--JOIN
use joindb;

--użycie aliasów

--bez
select buyer_name, Sales.buyer_id, qty
from Buyers, Sales
where Buyers.buyer_id = Sales.buyer_id;

--z
select buyer_name, s.buyer_id, qty
from Buyers as b, Sales as s
where b.buyer_id = s.buyer_id;

--INNER JOIN
select buyer_name, Sales.buyer_id, qty
from Buyers inner join Sales
on Buyers.buyer_id = Sales.buyer_id;

use Northwind;
--Napisz polecenie zwracające nazwy produktów i firmy je dostarczające (baza northwind)
--tak aby produkty bez „dostarczycieli” i „dostarczyciele” bez produktów nie pojawiali się w wyniku.
select p.ProductName, s.CompanyName
from Products as p inner join Suppliers as s
on p.SupplierID = s.SupplierID;

--Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po 01 marca 1998 (baza northwind)
select distinct c.CompanyName, o.OrderDate
from Customers as c join Orders as o
on c.CustomerID = o.CustomerID
where OrderDate > '3/1/1998';

--Napisz polecenie zwracające wszystkich klientów z datami zamówień (baza northwind).
select CompanyName, OrderDate
from Customers as c left outer join Orders as o
on c.CustomerID = o.CustomerID
where OrderDate is not null;

use library;
--Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko i data urodzenia dziecka.
select lastname, firstname, birth_date
from juvenile as j join member as m
on j.member_no = m.member_no;

--Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
select distinct t.title
from loan as l left join title as t
on l.title_no = t.title_no;

--Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
select in_date, DATEDIFF(D, out_date, in_date) as diff, fine_paid
from loanhist as lh join title as t
on lh.title_no = t.title_no
where t.title like 'Tao Teh King' and fine_paid is not null;

--Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
select r.isbn
from reservation as r join member as m
on r.member_no = m.member_no
where lastname = 'Graff' and firstname = 'Stephen' and middleinitial like 'A';

--Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
use Northwind
select p.ProductName, UnitPrice, s.CompanyName, s.Address, s.City, s.PostalCode
from Products as p join Suppliers as s
on p.SupplierID = s.SupplierID
where UnitPrice between 20.00 and 30.00;

 SELECT ProductName, UnitPrice, Address+' '+City+' '+PostalCode+' '+Country AS 'Adres' 
 FROM Products, Suppliers 
 WHERE Suppliers.SupplierID = Products.SupplierID AND (UnitPrice BETWEEN 20.00 AND 30.00)


--Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’1
select p.ProductName, p.UnitsInStock, s.CompanyName
from Products as p 
join Suppliers as s
on p.SupplierID = s.SupplierID
where s.CompanyName = 'Tokyo Traders';

--Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
select cu.CompanyName, cu.Address, cu.City, cu.PostalCode
from Customers as cu
where cu.CustomerID not in (select c.CustomerID
							from Orders as o
							right join Customers as c
							on o.CustomerID = c.CustomerID
							where YEAR(o.OrderDate) = 1997);

--Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie
select s.CompanyName, s.Phone
from Suppliers as s
join Products as p
on s.SupplierID = p.SupplierID
where p.UnitsInStock = 0 or p.UnitsInStock is null;


--Napisz polecenie, wyświetlające CROSS JOIN między shippers i suppliers. użyteczne dla listowania wszystkich możliwych sposobów w jaki dostawcy mogą dostarczać swoje produkty
select Suppliers.CompanyName, Shippers.CompanyName
from Suppliers 
cross join Shippers;


--Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08.
select p.ProductID, p.ProductName
from Products as p
join [Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on od.OrderID = o.OrderID
where o.OrderDate = '7/8/96';

--Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
select p.ProductName, p.UnitPrice, s.Address, s.City, s.PostalCode, c.CategoryName
from Products as p
join Suppliers as s
on p.SupplierID = s.SupplierID
join Categories as c
on p.CategoryID = c.CategoryID
where p.UnitPrice between 20.00 and 30.00 and c.CategoryName = 'Meat/Poultry';

--Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
select p.ProductName, p.UnitPrice, s.CompanyName
from Products as p
join Categories as c
on p.CategoryID = c.CategoryID
join Suppliers as s
on p.SupplierID = s.SupplierID
where c.CategoryName = 'Confections';

--Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma ‘United Package’
select c.CompanyName, c.Phone
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID
join Shippers as s
on o.ShipVia = s.ShipperID
where YEAR(o.OrderDate) = 1997 and s.CompanyName = 'United Package';

--Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections’
select distinct c.CompanyName, c.Phone
from Customers as c
join Orders as o
on c.CustomerID = o.CustomerID
join [Order Details] as od
on o.OrderID = od.OrderID
join Products as p
on od.ProductID = p.ProductID
join Categories as cat
on p.CategoryID = cat.CategoryID
where cat.CategoryName = 'Confections';


--Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
use library
select m.firstname, m.lastname, j.birth_date, a.street, a.city
from juvenile as j
join member as m
on j.member_no = m.member_no
join adult as a
on j.adult_member_no = a.member_no;

--Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.
select mj.firstname as [Chaild Firstname], mj.lastname as [Chaild Lastname], j.birth_date, a.street, a.city, ma.firstname as [Paretn Firstname], ma.lastname as [Parent Lastname]
from juvenile as j
join member as mj
on j.member_no = mj.member_no
join adult as a
on j.adult_member_no = a.member_no
join member as ma
on a.member_no = ma.member_no;

--Napisz polecenie, które wyświetla listę wszystkich kupujących te same produkty.
use joindb
select a.buyer_id as b1, a.prod_id, b.buyer_id as b2
from Sales as a
join Sales as b
on a.prod_id = b.prod_id;

--Zmodyfikuj poprzedni przykład, tak aby zlikwidować duplikaty
select a.buyer_id as b1, a.prod_id, b.buyer_id as b2
from Sales as a
join Sales as b
on a.prod_id = b.prod_id
where a.buyer_id <> b.buyer_id;

--Napisz polecenie, które pokazuje pary pracowników zajmujących to samo stanowisko.

--Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza northwind)
--Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
--Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996
--Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996. Interesują nas tylko adresy takich członków biblioteki, którzy aktualnie nie przetrzymują książek.

--Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą kolumnę – name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedynczą kolumnę – address) dla wszystkich dorosłych członków biblioteki
--Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover, dla książek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN
--Napisz polecenie które zwraca o użytkownikach biblioteki o nr 250, 342, i 1675 (dla każdego użytkownika: nr, imię i nazwisko członka biblioteki), oraz informację o zarezerwowanych książkach (isbn, data)
--Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają więcej niż dwoje dzieci zapisanych do biblioteki

--Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej niż dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki
