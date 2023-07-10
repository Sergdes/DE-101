-- ************************************** "public".calendar_dim
drop table if exists calendar_dim Cascade;
CREATE TABLE "public".calendar_dim
(
 date_id  int NOT NULL,
 year     int NOT NULL,
 quarter  int NOT NULL,
 month    int NOT NULL,
 week     int NOT NULL,
 week_day varchar(20) NOT NULL,
 "date"     date NOT NULL,
 leap     varchar(20) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY (date_id)
);


-- ************************************** "public".customer_dim
drop table if exists customer_dim Cascade;
CREATE TABLE "public".customer_dim
(
 cust_id       int NOT NULL,
 customer_id   varchar(50) NOT NULL,
 customer_name varchar(22) NOT NULL,
 segment       varchar(11) NOT NULL,
 CONSTRAINT PK_2 PRIMARY KEY ( cust_id )
);


-- ************************************** "public".geography_dim
drop table if exists geography_dim Cascade;
CREATE TABLE "public".geography_dim
(
 geo_id      int NOT NULL,
 country     varchar(30) NOT NULL,
 region      varchar(30) NOT NULL,
 "state"       varchar(30) NOT NULL,
 city        varchar(30) NOT NULL,
 postal_code int NOT NULL,
 CONSTRAINT PK_3 PRIMARY KEY ( geo_id )
);

-- ************************************** "public".managers_dim
drop table if exists managers_dim Cascade;
CREATE TABLE "public".managers_dim
(
 manager_id   int NOT NULL,
 manager_name varchar(17) NOT NULL,
 CONSTRAINT PK_4 PRIMARY KEY ( manager_id )
);

-- ************************************** "public".product_dim
drop table if exists product_dim Cascade;
CREATE TABLE "public".product_dim
(
 prod_id      int not null NOT NULL,
 category     varchar(15) NOT NULL,
 subcategory  varchar(17) NOT NULL,
 product_name varchar(127) NOT NULL,
 product_id   varchar(50) NOT NULL,
 CONSTRAINT PK_5 PRIMARY KEY ( prod_id )
);


-- ************************************** "public".ship_dim
drop table if exists ship_dim Cascade;
CREATE TABLE "public".ship_dim
(
 ship_id   int NOT NULL,
 ship_mode varchar(14) NOT NULL,
 CONSTRAINT PK_6 PRIMARY KEY ( ship_id )
);

-- ************************************** "public".sales_fact
drop table if exists sales_fact Cascade;
CREATE TABLE "public".sales_fact
(
 sales_id   int NOT NULL,
 profit     numeric(21,16) NOT NULL,
 discount   numeric(4, 2) NOT NULL,
 order_id   varchar(14) NOT NULL,
 quantity   int4 NOT NULL,
 sales      numeric(9,4) NOT NULL,
 geo_id     int NOT NULL,
 cust_id    int NOT NULL,
 manager_id int NOT NULL,
 ship_id    int NOT NULL,
 date_id    int NOT NULL,
 prod_id    int not null NOT NULL,
 CONSTRAINT PK_7 PRIMARY KEY ( sales_id, profit, discount ),
 CONSTRAINT FK_1 FOREIGN KEY ( geo_id ) REFERENCES "public".geography_dim ( geo_id ),
 CONSTRAINT FK_2 FOREIGN KEY ( cust_id ) REFERENCES "public".customer_dim ( cust_id ),
 CONSTRAINT FK_3 FOREIGN KEY ( manager_id ) REFERENCES "public".managers_dim ( manager_id ),
 CONSTRAINT FK_4 FOREIGN KEY ( ship_id ) REFERENCES "public".ship_dim ( ship_id ),
 CONSTRAINT FK_5 FOREIGN KEY ( date_id ) REFERENCES "public".calendar_dim ( date_id ),
 CONSTRAINT FK_6 FOREIGN KEY ( prod_id ) REFERENCES "public".product_dim ( prod_id )
);

CREATE INDEX FK_1 ON "public".sales_fact
(
 geo_id
);

CREATE INDEX FK_2 ON "public".sales_fact
(
 cust_id
);

CREATE INDEX FK_3 ON "public".sales_fact
(
 manager_id
);

CREATE INDEX FK_4 ON "public".sales_fact
(
 ship_id
);

CREATE INDEX FK_5 ON "public".sales_fact
(
 date_id
);

CREATE INDEX FK_6 ON "public".sales_fact
(
 prod_id
);
