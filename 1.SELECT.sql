--SELECT
--example
use Northwind
select employeeid, lastname, firstname, title
from Employees

--1.Wybierz nazwy i adresy wszystkich klientów
select companyname, address
from customers

--2.Wybierz nazwiska i numery telefonów pracowników
select lastname, homephone
from Employees

--3.Wybierz nazwy i ceny produktów
select productname, unitprice
from products

--4.Pokaż wszystkie kategorie produktów (nazwy i opisy)
select categoryname, description
from categories

--5.Pokaż nazwy i adresy stron www dostawców
select companyname, homepage
from suppliers



--example
--Znajdź numer zamówienia (orderid) oraz identyfikator
--klienta (customerid) dla zamówień z datą
--wcześniejszą niż 8/1/96 z tablicy zamówień (orders)
select orderid, customerid, OrderDate 
from Orders
where OrderDate < '8/1/96';

--1.Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
select companyname, address, city
from Customers
where City like 'London';

--2.Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w Hiszpanii
select companyname, address, country
from Customers
where Country like 'France' or Country like 'Spain';

--3.Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
select productname, unitprice
from Products
where UnitPrice between 20 and 30;

--4.Wybierz nazwy i ceny produktów z kategorii ‘meat’
select productname, unitprice, Categories.CategoryName
from Products, Categories
where Categories.CategoryName like '%meat%';


--5.Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
select productname, unitsinstock, Suppliers.CompanyName
from Products, Suppliers
where Suppliers.CompanyName like 'Tokyo Traders';

--6.Wybierz nazwy produktów których nie ma w magazynie
select productname, unitsinstock
from Products
where UnitsInStock = 0;



--1.Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
select *
from Products
where QuantityPerUnit like '%bottle%';

--2.Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
select LastName, FirstName, Title
from Employees
where LastName like '[B-L]%';

--3.Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
select LastName, FirstName, Title
from Employees
where LastName like '[BL]%';

--4.Znajdź nazwy kategorii, które w opisie zawierają przecinek
select *
from Categories
where Description like '%,%';

--5.Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’
select companyname
from Customers
where CompanyName like '%Store%';


--1.Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
select *
from Products
where UnitPrice < 10 or UnitPrice > 20;

--2.Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
select *
from Products
where UnitPrice between 20 and 30;

--1.Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
select * 
from Customers
where Country = 'Japan' or Country = 'Italy';

--•Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer klienta dla wszystkich niezrealizowanych jeszcze zleceń, 
--dla których krajem odbiorcy jest Argentyna
select *
from Orders
where ShippedDate is null and ShipCountry like 'Argentina';

--1.Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie
select *
from Customers
order by Country, CompanyName;

--2.Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malejąco wg ceny
select * 
from Products
order by CategoryID, UnitPrice desc;

--3.Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy), wyniki posortuj tak jak w pkt 1
select * 
from Customers 
where Country = 'Japan' or Country = 'Italy'
order by Country, CompanyName;

--Ćwiczenia końcowe: zapytania select, sortowanie, elimionowanie duplikatów, formatowanie zbioru wynikowego
--ANALIZA FUNKCJIONALNA PROJEKTU BIBLIOTEKI - library
--Książka może być pożyczona na okres max 14 dni. Czytelnik może mieć co najwyżej 4 książki.
--Gdy termin zwrotu został przekroczony, czytelnik po tygodniu dostaje upomnienie.
--Czytelnik wybiera książki, podaje bibliotekarce kartę magnetyczną, którą znajduje czytelnika. Pokazują się dane czytelnika oraz informacje o ważności karty.
--Pokazują się również informacje o wypożyczeniach czytelnika, tj tytuł, data zwrotu, ew. zaległości.
--Gdy wszystko jest w porządku, książka jest pożyczana (odczyt z kodu paskowego).
--Kilka książek może mieć ten sam tytuł: książka = item. Książki z tym samym tytułem mogą mięć różne ISBN (różne języki i okładki)
--Jeżeli czytelnik chce pożyczyć książkę, której aktualnie nie ma jest robiona dla niego rezerwacja. Gdy książka zostaje zwrócona powiadamia się czytelnika najdłużej czekającego (max 4 rezerwacje)
--Nowy czytelnik musi podać adres i telefon. Dostaje ważną na rok kartę biblioteczną
--Młodzież do 18 roku może być czytelnikiem, za zgodą dorosłego czytelnika. Jego karta ważna wraz z ważnością karty dorosłego.



use library;
--Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki
select * 
from title;

--Napisz polecenie, które wybiera tytuł o numerze 10
select *
from title
where title_no = 10;

--Napisz polecenie, które wybiera numer czytelnika i karę dla tych czytelników, którzy mają kary między $8.00 a $9.00 (z tablicy loanhist)
select distinct member_no, fine_assessed
from loanhist
where fine_assessed between 8 and 9;

--Napisz polecenie select, za pomocą którego uzyskasz numer książki i autora z tablicy title dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen
select title_no, author
from title
where author in ('Charles Dickens', 'Jane Austen');

--Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich rekordów zawierających string „adventures” gdzieś w tytule.
select *
from title
where title like '%adventures%';

--Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę
select  member_no, fine_paid
from loanhist
where fine_paid is not null;

--Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
select distinct city, state
from adult;

--Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
select *
from title
order by title;

--Napisz polecenie, które:
--wybiera numer członka biblioteki (member_no), isbn książki (isbn) i watrość naliczonej kary (fine_assessed) z tablicy loanhist 
--dla wszystkich wypożyczeń dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed)
select distinct member_no, isbn, fine_assessed
from loanhist
where fine_assessed is not null and fine_assessed != 0;

--stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
--stwórz alias ‘double fine’ dla tej kolumny
select distinct member_no, isbn, fine_assessed, fine_assessed*2 as 'double fine'
from loanhist
where fine_assessed is not null and fine_assessed != 0;

--Napisz polecenie, które
--generuje pojedynczą kolumnę, która zawiera kolumny: firstname (imię członka biblioteki), middleinitial (inicjał drugiego imienia) i 
--lastname (nazwisko) z tablicy member dla wszystkich członków biblioteki, którzy nazywają się Anderson
--nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla kolumny)
select firstname + ' ' + middleinitial + ' ' + lastname as email_name
from member 
where lastname like 'Anderson';

--zmodyfikuj polecenie, tak by zwróciło „listę proponowanych loginów e-mail” utworzonych przez połączenie imienia członka biblioteki, 
--z inicjałem drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko małymi małymi literami).
--Wykorzystaj funkcję SUBSTRING do uzyskania części kolumny znakowej oraz LOWER do zwrócenia wyniku małymi literami. Wykorzystaj operator (+) do połączenia stringów.
select LOWER(firstname + middleinitial + SUBSTRING(lastname, 0, 2)) as email_name
from member 
where lastname like 'Anderson';

--Napisz polecenie, które wybiera title i title_no z tablicy title.
--Wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie poniżej:
--The title is: Poems, title number 7
--Czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu o wyrażenie, które łączy 4 elementy:
--stała znakowa ‘The title is:’
--wartość kolumny title
--stała znakowa ‘title number’
--wartość kolumny title_no
select 'The title is: ' + title + ', title number ' + cast(title_no as varchar(10)) as title
from title;
