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
--Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
--Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff


--Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
--Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
--Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
--Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie

--Napisz polecenie, wyświetlające CROSS JOIN między shippers i suppliers. użyteczne dla listowania wszystkich możliwych sposobów w jaki dostawcy mogą dostarczać swoje produkty

--Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08.

--Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
--Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
--Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma ‘United Package’
--Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections’

--Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
--Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.

--Napisz polecenie, które wyświetla listę wszystkich kupujących te same produkty.

--Zmodyfikuj poprzedni przykład, tak aby zlikwidować duplikaty

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
