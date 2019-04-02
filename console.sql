alter table rentals add column id_rental bigint(10) unsigned not null auto_increment primary key

# 1. Średni wiek kierowcy dla poszczególnych marek samochodow

select brand, round(avg(age)) as 'średni wiek kierowcy'
from car_brands cb, cars c, rentals r, users u
where cb.id_brand = c.id_brand
  and c.id_car = r.id_car
  and r.id_user = u.id_user
group by brand
order by `średni wiek kierowcy`desc ;

# 2. Policzyc ile jest uzytkownikow, ktorzy nie wypozyczyli samochodow wiecej niz 5 razy


select u.id_user, count(id_rental) as 'ilość'
from users u, rentals r
where u.id_user = r.id_user
group by r.id_user
having ilość<5;





# 3. Wykaz samochodow z przebiegiem mniejszym od sredniego przebiegu wszystkich pojazdow
select id_car, mileage
from cars c
having mileage < (select avg(mileage) from cars);


select avg(mileage) from cars;



# 4. Wykaz samochodow, ktore zostaly wypozyczone na max. 2 dni
select c.id_car
from cars c, rentals r
where c.id_car = r.id_car
  and date(start_time) between date_sub(date(end_time), interval 2 day ) and date(end_time);

# 5. Ktore samochody przyniosly najwieksze zyski w poprzednim miesiacu?

select c.id_car, sum(r.total_price) as 'łączny przychód'
from cars c, rentals r
where c.id_car = r.id_car
  and month(end_time) = month(current_date)-1
  and year(end_time) = year(current_date)
group by c.id_car
order by `łączny przychód`desc ;


#średni czas wypożyczenia samochodu

select avg(abs(datediff(end_time, start_time))) as 'sredni czas'
from rentals r ;


select brand, round(avg(abs(datediff(end_time, start_time)))) as 'sredni czas'
from rentals r
join cars c on r.id_car = c.id_car
join car_brands cb on c.id_brand = cb.id_brand
group by brand
order by `sredni czas`desc ;


#której marki samochody są najstarsze
select brand, datediff(year(current_date), prod_year) as 'sredni wiek'
from cars
join car_brands cb on cars.id_brand = cb.id_brand
group by brand
order by `sredni wiek`desc ;

select datediff(sysdate(), 2017);

select brand, round(avg(year(current_date) - prod_year))as 'wiek'
from cars
join car_brands cb on cars.id_brand = cb.id_brand
group by brand
order by wiek desc ;

select year(current_date) - 2015;

