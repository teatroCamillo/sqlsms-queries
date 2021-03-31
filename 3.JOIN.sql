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

SELECT firstname, lastname, birth_date, street 
FROM juvenile 
INNER JOIN member 
ON member.member_no=juvenile.member_no 
INNER JOIN adult 
ON adult.member_no=juvenile.adult_member_no;

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
use Northwind
select e0.EmployeeID, e0.Title, e1.EmployeeID, e1.Title
from Employees as e0
join Employees as e1
on e0.Title = e1.Title
where e0.EmployeeID < e1.EmployeeID;

--Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza northwind)
select e0.EmployeeID, e1.ReportsTo
from Employees as e0
join Employees as e1
on e0.EmployeeID = e1.EmployeeID;

SELECT e1.lastname+' '+e1.firstname as szef, e2.lastname+' '+e2.firstname as podwladny 
FROM Employees as e1
JOIN Employees as e2 
ON e1.EmployeeID=e2.ReportsTo


--Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
select e0.EmployeeID, e1.ReportsTo, e0.FirstName, e0.LastName
from Employees as e0
join Employees as e1
on e0.EmployeeID = e1.EmployeeID
where e1.ReportsTo is null;

SELECT FirstName+' '+Lastname 
FROM Employees
WHERE ReportsTo IS NULL


--Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996
use library
select a.city, a.state, a.street, a.zip
from juvenile as j
join adult as a
on a.member_no = j.adult_member_no
where j.birth_date < '1/1/96';

SELECT street, city 
FROM adult
INNER JOIN juvenile 
ON adult.member_no=juvenile.adult_member_no
WHERE birth_date < '1996-01-01'

--Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996. Interesują nas tylko adresy takich członków biblioteki, którzy aktualnie nie przetrzymują książek.
select distinct a.member_no, a.city, a.state, a.street, a.zip
from adult as a
join juvenile as j
on a.member_no = j.adult_member_no
left join loan as l
on l.member_no = a.member_no
where j.birth_date < '1/1/96' and l.member_no is null;

select distinct a.member_no, a.city, a.state, a.street, a.zip
from adult as a
join juvenile as j
on a.member_no = j.adult_member_no
where j.birth_date < '1996-01-01' and a.member_no not in (select distinct member_no from loan);

--Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą kolumnę – name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedynczą kolumnę – address) dla wszystkich dorosłych członków biblioteki
select distinct m.firstname + ' ' + m.lastname as name, a.street + ' ' + a.city + ' ' + a.zip as address
from adult as a
join member as m
on a.member_no = m.member_no;

--Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover, dla książek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN
select distinct i.isbn, c.copy_no, c.on_loan, t.title, i.translation, i.cover
from item as i
join copy as c
on i.isbn = c.isbn
join title as t
on t.title_no = i.title_no
where i.isbn = 1 or i.isbn = 500 or i.isbn = 1000
order by 1;

--Napisz polecenie które zwraca o użytkownikach biblioteki o nr 250, 342, i 1675 (dla każdego użytkownika: nr, imię i nazwisko członka biblioteki), oraz informację o zarezerwowanych książkach (isbn, data)
select m.member_no, m.firstname, m.lastname, r.isbn, r.log_date
from member as m
join reservation as r
on m.member_no = r.member_no
where m.member_no = 250 or m.member_no = 342 or m.member_no = 1675;

--Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają więcej niż dwoje dzieci zapisanych do biblioteki
select j.adult_member_no, COUNT(j.member_no), m.firstname, m.lastname, a.state
from member as m
join adult as a
on m.member_no = a.member_no
join juvenile as j
on a.member_no = j.adult_member_no
where a.state = 'AZ'
group by j.adult_member_no, m.firstname, m.lastname, a.state
having COUNT(j.member_no) > 2


--Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej niż dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki
use library;
select m.member_no, COUNT(j.member_no) as children, m.firstname, m.lastname, a.state
from member as m
join adult as a
on m.member_no = a.member_no
join juvenile as j
on a.member_no = j.adult_member_no
group by m.member_no, m.firstname, m.lastname, a.state
having (a.state = 'AZ' and COUNT(j.member_no) > 2) or (a.state = 'CA' and COUNT(j.member_no) > 3);



--ĆWICZENIA
--1.1 Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek oraz nazwę klienta.
use Northwind;

select od.OrderID, SUM(od.Quantity) as total_amount, c.CompanyName
from [Order Details] as od
join Orders as o
on od.OrderID = o.OrderID
join Customers as c
on o.CustomerID = c.CustomerID
group by od.OrderID,  c.CompanyName;


--1.2 Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których łączna liczbę zamówionych jednostek jest większa niż 250.
select od.OrderID, SUM(od.Quantity) as total_amount, c.CompanyName
from [Order Details] as od
join Orders as o
on od.OrderID = o.OrderID
join Customers as c
on o.CustomerID = c.CustomerID
group by od.OrderID,  c.CompanyName
having SUM(od.quantity) > 250;

--1.3 Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.
select od.OrderID, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total, c.CompanyName
from [Order Details] as od
join Orders as o
on od.OrderID = o.OrderID
join Customers as c
on o.CustomerID = c.CustomerID
group by od.OrderID,  c.CompanyName;


--1.4 Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których łączna liczba jednostek jest większa niż 250.
select od.OrderID, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total, SUM(od.quantity) as quantityy, c.CompanyName
from [Order Details] as od
join Orders as o
on od.OrderID = o.OrderID
join Customers as c
on o.CustomerID = c.CustomerID
group by od.OrderID,  c.CompanyName
having SUM(od.quantity) > 250;


--1.5 Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko pracownika obsługującego zamówienie
select e.EmployeeID, e.LastName, e.FirstName, od.OrderID, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total, SUM(od.quantity) as quantityy, c.CompanyName
from [Order Details] as od
join Orders as o
on od.OrderID = o.OrderID
join Customers as c
on o.CustomerID = c.CustomerID
join Employees as e
on o.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.LastName, e.FirstName, od.OrderID, c.CompanyName
having SUM(od.quantity) > 250;

--2.1 Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez klientów jednostek towarów.
select ca.CategoryID, ca.CategoryName, SUM(od.Quantity) as total_quantity
from Categories as ca
join Products as p
on ca.CategoryID = p.CategoryID
join [Order Details] as od
on p.ProductID = od.ProductID
group by ca.CategoryID, ca.CategoryName;

--2.2 Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówień 
select ca.CategoryID, ca.CategoryName,SUM(od.Quantity) as total_quantity, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Categories as ca
join Products as p
on ca.CategoryID = p.CategoryID
join [Order Details] as od
on p.ProductID = od.ProductID
group by ca.CategoryID, ca.CategoryName;

--2.3 Posortuj wyniki w zapytaniu z punktu 2.2 wg: 
--a) łącznej wartości zamówień 
select ca.CategoryID, ca.CategoryName, SUM(od.Quantity) as total_quantity, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Categories as ca
join Products as p
on ca.CategoryID = p.CategoryID
join [Order Details] as od
on p.ProductID = od.ProductID
group by ca.CategoryID, ca.CategoryName
order by total;

--b) łącznej liczby zamówionych przez klientów jednostek towarów.
select ca.CategoryID, ca.CategoryName, SUM(od.Quantity) as total_quantity, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Categories as ca
join Products as p
on ca.CategoryID = p.CategoryID
join [Order Details] as od
on p.ProductID = od.ProductID
group by ca.CategoryID, ca.CategoryName
order by total_quantity;


--3.1 Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
select s.ShipperID, s.CompanyName, COUNT(o.OrderID) as amount_via
from Shippers as s
join Orders as o
on s.ShipperID = o.ShipVia
where Year(o.ShippedDate) = '1997'
group by s.ShipperID, s.CompanyName;


--3.2 Który z przewoźników był najaktywniejszy (przewiózł największą liczbę zamówień) w 1997r, podaj nazwę tego przewoźnika
select top 1 s.ShipperID, s.CompanyName, COUNT(o.OrderID) as amount_via
from Shippers as s
join Orders as o
on s.ShipperID = o.ShipVia
where Year(o.ShippedDate) = '1997'
group by s.ShipperID, s.CompanyName
order by amount_via desc;

--3.3 Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i nazwisko takiego pracownika
select top 1 e.FirstName, e.LastName, COUNT(o.OrderID) as max_liczba_obs
from Orders as o 
join Employees as e
on o.EmployeeID = e.EmployeeID
where Year(o.OrderDate) = '1997'
group by e.FirstName, e.LastName
order by max_liczba_obs desc;

--4.1 Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
select e.FirstName, e.LastName, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Orders as o 
join Employees as e
on o.EmployeeID = e.EmployeeID
join [Order Details] as od
on o.OrderID = od.OrderID
group by e.FirstName, e.LastName;

--4.2 Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika
select top 1 e.FirstName, e.LastName, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Orders as o 
join Employees as e
on o.EmployeeID = e.EmployeeID
join [Order Details] as od
on o.OrderID = od.OrderID
group by e.FirstName, e.LastName
order by total desc;

--4.3 Ogranicz wynik z pkt 4.1 tylko do pracowników 
--a) którzy mają podwładnych 
select e.FirstName, e.LastName, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Orders as o 
join Employees as e
on o.EmployeeID = e.EmployeeID
join [Order Details] as od
on o.OrderID = od.OrderID
where e.ReportsTo is not null
group by e.FirstName, e.LastName

--b) którzy nie mają podwładnych
select e.FirstName, e.LastName, SUM(od.Quantity * (od.UnitPrice * (1 - od.Discount))) as total
from Orders as o 
join Employees as e
on o.EmployeeID = e.EmployeeID
join [Order Details] as od
on o.OrderID = od.OrderID
where e.ReportsTo is null
group by e.FirstName, e.LastName