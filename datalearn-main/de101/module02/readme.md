 Модуль 2 - Домашняя работа

# 1. Подключение к Базам Данных и SQL
Мы  установили клиент SQL для подключения базы данных (в нашем случае DBeaver).
Создаем 3 таблицы и загружаем данные из [Superstore Excel](<source/Sample - Superstore.xls>) файла в нашу базу данных. Сохраняем в вашем GitHub скрипт загрузки данных и создания таблиц.
Вот пример запросов:

Напишем запросы, чтобы ответить на вопросы из Модуля 01.
Ниже мое решение:
# 3. SQL-запросы к базе данных
Ниже приведены примеры моих SQL-запросов к базе данных
## 3.1. Ежемесячные продажи по сегментам

select extract(year from order_date) as year,
 extract(month from order_date) as month,
 segment,
 round(sum(sales), 2) as monthly_sales
from orders
group by year, month, segment
order by 1, 2, 3;

![Результат](images/2023-07-07_19-54-21.png)