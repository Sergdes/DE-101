 Модуль 2 - Домашняя работа

# 1. Подключение к Базам Данных и SQL
Мы  установили клиент SQL для подключения базы данных (в нашем случае DBeaver).
Создаем 3 таблицы и загружаем данные из [Superstore Excel](<source/Sample - Superstore.xls>) файла в нашу базу данных. Сохраняем в вашем GitHub скрипт загрузки данных и создания таблиц. Загрузку данных можно произвести с помощью уже подготовленных [скриптов SQL} (https://github.com/Data-Learn/data-engineering/tree/master/DE-101%20Modules/Module01/DE%20-%20101%20Lab%201.1) или же можно подготовить csv файлы для таждой таблици (сохранить как для каждого листа книги, и предварительно заменив разделитель дробной части с "," на ".") и произвести загрузку в SQL :


Вот пример запросов:

Напишем запросы, чтобы ответить на вопросы из Модуля 01.
Ниже мое решение:
# 3. SQL-запросы к базе данных
Ниже приведены примеры моих SQL-запросов к базе данных

## 3.1. Ежемесячные продажи по сегментам
```sql
select extract(year from order_date) as year,
 extract(month from order_date) as month,
 segment,
 round(sum(sales), 2) as monthly_sales
from orders
group by year, month, segment
order by year, month, segment;
```
![Результат](images/2023-07-07_19-54-21.png)

## 3.2. Ежемесячные продажи по сегментам

'''sql
SELECT
    o.state,
    COUNT(*) AS total_orders,
    COUNT(r.returned) AS returned_orders,
    COUNT(o.order_id) - COUNT(r.returned) AS non_returned_orders,
    ROUND((COUNT(r.returned) * 100)/(COUNT(o.order_id)), 2) AS returned_percentage,
    ROUND(((COUNT(*) - COUNT(r.returned)) * 100 / COUNT(*)) , 2) AS non_returned_percentage
FROM
    public.orders AS o
LEFT JOIN
    public."returns" AS r ON o.order_id = r.order_id
GROUP BY
    o.state
ORDER BY
    o.state;
'''
#### Если не объявлять тип данных результатом для процентов будет либо 0 либо 100. Решить можно как у меня  указать корректный тип данных, либо сначала умножить на 100 а потом только делить (в этом случае округление не потребуется).