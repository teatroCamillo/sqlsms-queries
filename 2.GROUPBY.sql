use Northwind;

--example
select top 5 *
from [Order Details]
order by Quantity;

select top 5 with ties orderid, productid, quantity
from [Order Details]
order by Quantity;

--Declaration and initialization

--sperated
declare @x int;
set @x = 5;

--oneline
declare @y int = 33;

--use agregation function with NULL value
--COUNT(*) count NULL also
select COUNT(*)
from Employees;

select COUNT(reportsto)
from Employees;

--AVG()
select AVG(unitprice)
from Products;

--SUM()
select SUM(quantity)
from [Order Details];

--1.Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$a
select COUNT(ProductID)
from Products
where UnitPrice < 10.00 or UnitPrice > 20.00;

--2.Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
select MAX(unitprice)
from Products
where UnitPrice < 20.00;

--3.Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
select MAX(unitprice), MIN(unitprice), AVG(unitprice)
from Products
where QuantityPerUnit like '%bottle%';

--4.Wypisz informację o wszystkich produktach o cenie powyżej średniej
select * 
from Products
where Unitprice > (select AVG(unitprice) from Products);

--5.Podaj sumę/wartość zamówienia o numerze 10250
select *
from [Order Details]
where OrderID = 10250;

select SUM(unitprice * quantity * (1 - discount))
from [Order Details]
where OrderID = 10250;


--Napisz polecenie, które zwraca informacje o zamówieniach z tablicy order details. Zapytanie ma grupować i wyświetlać 
--identyfikator każdego produktu a następnie obliczać ogólną zamówioną ilość. Ogólna ilość jest sumowana funkcją agregującą 
--SUM i wyświetlana jako jedna wartość dla każdego produktu.
select ProductID, SUM(Quantity) as suma
from [Order Details]
group by ProductID;


--1.Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
select orderid, MAX(unitprice)
from [Order Details]
group by OrderID;

--2.Posortuj zamówienia wg maksymalnej ceny produktu
select orderid, MAX(unitprice) as maxp
from [Order Details]
group by OrderID
order by maxp desc;

--3.Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
select orderid, MAX(unitprice), MIN(unitprice)
from [Order Details]
group by OrderID;

--4.Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
select ShipVia, count(OrderID)
from Orders
group by ShipVia;

--5.Który z spedytorów był najaktywniejszy w 1997 roku
select top 1 ShipVia, count(OrderID)
from Orders
where YEAR(OrderDate) = 1997
group by ShipVia
order by count(orderid) desc;



--Wyświetl listę identyfikatorów produktów i ilość dla tych produktów, których zamówiono ponad 1200 jednostek
select ProductID, SUM(quantity)
from [Order Details]
group by ProductID
having SUM(quantity) > 1200;

--1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
select orderid, COUNT(OrderID)
from [Order Details]
group by OrderID
having COUNT(OrderID) > 5;

select orderid, COUNT(ProductID)
from [Order Details]
group by OrderID
having COUNT(ProductID) > 5;

--2.Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
select CustomerID, COUNT(ShippedDate), SUM(freight)
from Orders
where YEAR(OrderDate) = 1998
group by CustomerID
having COUNT(ShippedDate) > 8
order by sum(freight) desc;


-- **********************************************************************************************************
-- Ćwiczenia końcowe

--1.1.Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia w tablicy order details i wynik zwraca posortowany w malejącej kolejności (wg wartości sprzedaży).
select OrderID, SUM(quantity * (unitprice - (unitprice * discount))) as total
from [Order Details]
group by OrderID
order by total desc;

--1.2.Zmodyfikuj zapytanie z punktu 1.1, tak aby zwracało pierwszych 10 wierszy
select top 10 OrderID, SUM(quantity * (unitprice - (unitprice * discount))) as total
from [Order Details]
group by OrderID
order by total desc;

--1.3.Zmodyfikuj zapytanie z punktu 1.2, tak aby zwracało 10 pierwszych produktów wliczając równorzędne. Porównaj wyniki.
select top 10 with ties OrderID, SUM(quantity * (unitprice - (unitprice * discount))) as total
from [Order Details]
group by OrderID
order by total desc;

--2.1.Podaj liczbę zamówionych jednostek produktów dla produktów, dla których productid < 3
select productid, sum(quantity)
from [Order Details]
where ProductID < 3
group by productid;

--2.2.Zmodyfikuj zapytanie z punktu 2.1 tak aby podawało liczbę zamówionych jednostek produktu dla wszystkich produktów
select productid, sum(quantity)
from [Order Details]
group by productid;

--2.3.Podaj wartość zamówienia dla każdego zamówienia dla którego łączna liczba zamawianych jednostek produktów jest > 250
select productid, sum(quantity) as quan, SUM(Quantity*(UnitPrice - (Unitprice * Discount))) as total
from [Order Details]
group by productid
having SUM(quantity) > 250;

--3.1.Napisz polecenie, które oblicza sumaryczną ilość zamówionych towarów, porządkuje wynik wg productid i ordered i wykonuje kalkulacje rollup.
select productid, orderid, SUM(Quantity) 
from [Order Details]
group by productid, OrderID
with rollup;

--3.2.Zmodyfikuj zapytanie z punktu 3.1, tak aby ograniczyć wynik tylko do produktu o numerze 50.
--3.3.Jakie jest znaczenie wartości null w kolumnie productid i orderid?
--4.1.Napisz polecenie, które zwraca productid, orderid i quantity dla wszystkich produktów/zamówień, których orderid > 11070.
--Po każdej zmianie productid podsumuj liczbę zamówionych jednostek produktu
--5.1.Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień
--5.2.Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata i miesiące
--5.3.Dla każdego spedytora podaj wartość (opłata za przesyłkę) przewożonych przez niego zamówień
--5.4.Dla każdego spedytora podaj wartość (opłata za przesyłkę) przewożonych przez niego zamówień z podziałem na poszczególne lata
--5.5.Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej kategorii

