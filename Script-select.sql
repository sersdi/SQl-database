# Команда select - позволяет читать данные с помощью select запросов

SELECT 'Hello world';     # выводим в консоль 

SELECT *				# выводим всю таблицу 
FROM users;

SELECT id, firstname, lastname, login, email, password_hash, phone, is_deleted
FROM users;			# выводим таблицу с определенными полями 

SELECT id, firstname, email,  phone
FROM users;

SELECT *
FROM users
WHERE id = 1;	      #выводим строку из таблицы с id 1

SELECT *
FROM users
LIMIT 5;			  # выводим только 5 строчек таблицы 

SELECT *
FROM users
ORDER BY email;			#сортировка по полю email (по стандарту сортируется в алфавитном порядке )

SELECT count(firstname)		#выводит кол-во строк где указан firstname 
FROM users;
										# выводит кол-во уникальных имен которые есть в  таблице без повторов 
SELECT count(distinct firstname)
FROM users;

SELECT count(*)				#считаем все строки которые есть в таблице 
FROM users;

SELECT *
FROM users 
WHERE id = 1;
SELECT *
FROM user_settings 
WHERE user_id = 1;

SELECT *
FROM channels 
WHERE title COLLATE utf8mb4_0900_as_cs LIKE '%M%';  #collate отвечает за настройку сортировки cs-регистрочувствительность ci-неригостручувстивтельный

SELECT *
FROM users
WHERE firstname  LIKE '____';    #_ фильтрация по кол-ву букв _ = 1буква 


SELECT *
FROM private_messages
WHERE sender_id  = 2 AND receiver_id = 3
	OR sender_id = 3 AND receiver_id  = 2
ORDER BY created_at  desc;                       # сортировка по дате (desc - сортировка по убыванию)

SELECT count(*)
FROM private_messages
WHERE receiver_id = 3 AND is_read =0;


UPDATE private_messages						#обновили поле 
SET is_read = 1
WHERE sender_id  = 2 AND receiver_id = 3;

SELECT count(*)
FROM private_messages
WHERE sender_id  = 29 AND receiver_id = 3 AND is_read =0
ORDER BY created_at  desc;   

--диалог между двумя пользователями--
SELECT *
FROM private_messages
WHERE (sender_id  = 3 AND receiver_id = 5		 #добавили сортировку(в скобки заключили приоритет) 
	OR sender_id = 5 AND receiver_id  = 3)
	AND media_type = 'audio';

--сколько у меня непрочитанных сообщений от пользователя X
SELECT count(*)											   #функция count одна из агрегирующих функций(count min max avg sum)
FROM private_messages
WHERE sender_id  = 6 AND receiver_id = 5 AND is_read =0;

--сколько у меня всего непрочитанных сообщений 
SELECT count(*)
FROM private_messages
WHERE receiver_id = 5 AND is_read =0;


--АГРЕГИРУЮЩИЕ ФУНКЦИИ--
SELECT YEAR(birthday)
FROM users;

SELECT MIN(YEAR(birthday))
FROM users;

SELECT MAX(YEAR(birthday))
FROM users;

SELECT round (AVG(YEAR(birthday)))  #round огругляет стреднее значение (avg)
FROM users;

SELECT SUM(amount)
FROM sakila.payment
WHERE customer_id = 1;

#группировка (group by)
SELECT
	count(*) AS cnt,  #AS переименовали count в  cnt  что бы далее с ним работать в коде 
	app_language
FROM user_settings 
GROUP BY app_language 
ORDER BY cnt DESC;

SELECT 						# Нашли самый популярный канал
	count(*) AS cnt,
	channel_id
FROM channel_subscribers
WHERE status = 'joined'
GROUP BY channel_id
ORDER BY cnt DESC 
LIMIT 1 ;

SELECT
	count(*) AS cnt, 
	group_id
FROM group_messages
GROUP BY group_id
ORDER BY cnt DESC;

select 									# фильтрация(Hаving) применяется к группе
	count(*) as cnt,
	channel_id
from channel_messages
group by channel_id 
HAVING cnt > 40
order by cnt DESC

SELECT *
FROM stories 
WHERE user_id in (2,3,4,5)				# сортируем по полю с несколькими значениями 
ORDER BY id;

SELECT *
FROM stories 
having user_id in (2,3,4,5)				# сортируем по полю с несколькими значениями 
ORDER BY id;


SELECT *
FROM users
WHERE phone IS null;				# сотрировка с полями null

SELECT *
FROM users
WHERE phone IS not null;				


SELECT IF (NULL  = NULL, 'true', 'false');

SELECT IF (1 = 1, 'true', 'false');


												# Пейджинг(limit+offset)(постраничный вывод записей)
SELECT *
FROM users
WHERE phone IS NOT null
ORDER BY id
LIMIT 5 offset 10;						#offset-смещение


										# Условия, ветвления (if, case)
SELECT 
	is_private,
	IF (is_private, 'private', 'public') AS publicity,
	title
FROM channels;

SELECT 
	is_private,
	CASE(is_private)
		WHEN 0 THEN 'public'
		WHEN 1 THEN  'private'
		ELSE 'not set'
	END AS publicity,
	title
FROM channels;

SELECT 
    COUNT(*) AS cnt,
    CASE 
        WHEN year(birthday) > 1945 AND year(birthday) < 1965 THEN 'baby boomer'
        WHEN year(birthday) > 1964 AND year(birthday) < 1980 THEN 'generation X'
        WHEN year(birthday) > 1979 AND year(birthday) < 1996 THEN 'millenial'
        WHEN year(birthday) > 1995 AND year(birthday) < 2012 THEN 'generation Z'
        WHEN year(birthday) > 2011 THEN 'alpha'
    END    AS generation
FROM users
GROUP BY generation
ORDER BY min(YEAR(birthday))
# ORDER BY cnt DESC ;

-- то же, но с использованием функции BETWEEN
SELECT 
    count(*) AS cnt,
    CASE 
        WHEN year(birthday) BETWEEN 1945 AND 1965 THEN 'baby boomer'
        WHEN year(birthday) BETWEEN 1966 AND 1980 THEN 'generation X'
        WHEN year(birthday) BETWEEN 1981 AND 1995 THEN 'millenial'
        WHEN year(birthday) BETWEEN 1996 AND 2011 THEN 'generation Z'
        WHEN year(birthday) > 2011 THEN 'alpha'
    END    AS generation
FROM users
GROUP BY generation
ORDER BY min(YEAR(birthday))


select 
    id,
    LEFT(title,30),
    is_private 
from `groups` 
where is_private = 0
order by title;

SELECT
	is_premium_account,
	count(*) AS users_amount
FROM user_settings
GROUP BY is_premium_account ;

select 
    count(*) as count,
    reaction_id
from private_message_reactions
GROUP BY reaction_id
HAVING count > 80
ORDER BY count DESC;

select
    count(*)
from channels
where icon is not NULL;

select 
    id,
    views_count,
    if(views_count > 1000, 'popular', 'not popular') AS is_popular
from stories
ORDER BY is_popular;

																##Сложные селект запросы

SELECT														# запрос при котором собираем данные из двух таблиц
 	firstname,
 	lastname,	
 	(SELECT app_language FROM user_settings WHERE user_id = 1) AS 'app_language',				## вложенные селект запросы
 	(SELECT is_premium_account FROM user_settings WHERE user_id = 1 ) AS 'is_premium_account'
FROM users
WHERE id = 1;

ALTER TABLE private_messages
ADD COLUMN is_read BIT NOT NULL DEFAULT 0;

SELECT count(*)
FROM private_messages
WHERE receiver_id = (SELECT id FROM users WHERE email = 'uhammes@example.com') 
	AND is_read = 0;

SELECT 
	count(*),
	# reaction_id,
	(SELECT code FROM reactions_list WHERE id = reaction_id) AS reaction_code
FROM private_message_reactions
GROUP BY reaction_id;


														## Обьединения(cross join, inner join)

# CROSS JOIN
SELECT *
FROM users, private_messages;

# также CROSS JOIN
SELECT *
FROM users
JOIN private_messages;

# количество строк в таблицах
SELECT count(*) FROM users;
SELECT count(*) FROM private_messages ;

# количество строк в CROSS JOIN
SELECT count(*)
FROM users, private_messages;

# можно объединять больше двух таблиц
SELECT *
FROM users, private_messages, channels, channel_messages ;

# CROSS JOIN - работает медленно
SELECT *
FROM users
CROSS JOIN private_messages
WHERE users.id = private_messages.sender_id ;

# INNER JOIN - работает эффективно
SELECT *
FROM users
INNER JOIN private_messages ON users.id = private_messages.sender_id ;

																		
																		# left join right join
# INNER JOIN
SELECT *
FROM users
INNER JOIN private_messages ON users.id = private_messages.sender_id;

# LEFT [OUTER] JOIN
SELECT *
FROM users
LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id;

# INNER JOIN - количество строк
SELECT count(*)
FROM users
INNER JOIN private_messages ON users.id = private_messages.sender_id;

# LEFT [OUTER] JOIN - количество строк
SELECT count(*)
FROM users
LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id;


# LEFT JOIN - отсортированная выборка
SELECT *
FROM users
LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id
ORDER BY private_messages.id;


# LEFT JOIN - фильтрация (только пользователи без сообщений)
SELECT *
FROM users
LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id
WHERE private_messages.id IS NULL 
ORDER BY private_messages.id
# LIMIT 12;


# LEFT JOIN = INNER JOIN
SELECT *
FROM users
LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id
WHERE private_messages.id IS NOT NULL 
ORDER BY private_messages.id;


# LEFT JOIN
SELECT users.*, private_messages.*
FROM users
LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id
ORDER BY private_messages.id


# RIGHT JOIN = LEFT JOIN
SELECT users.*, private_messages.*
FROM private_messages
RIGHT OUTER JOIN users ON users.id = private_messages.sender_id
ORDER BY private_messages.id

															# full outer join 
# FULL OUTER JOIN
SELECT *
FROM users
LEFT JOIN private_messages ON users.id = private_messages.sender_id
	UNION
SELECT *
FROM users
RIGHT JOIN private_messages ON users.id = private_messages.sender_id

# количество строк в INNER JOIN 
SELECT COUNT(*)
FROM users
INNER JOIN private_messages ON users.id = private_messages.sender_id

# количество строк в LEFT JOIN 
SELECT COUNT(*)
FROM users
LEFT JOIN private_messages ON users.id = private_messages.sender_id

# количество строк в RIGHT JOIN 
SELECT COUNT(*)
FROM users
RIGHT JOIN private_messages ON users.id = private_messages.sender_id

# арифметика JOIN
INNER JOIN = 5
LEFT JOIN = 9
RIGHT JOIN = 8 
FULL OUTER JOIN = 12 = 9 + 8 - 5 = 5 + 4 + 3


														#Вложенные запросы vs Обьеденения
#скореллированый вложнный запрос
SELECT
	firstname,
	lastname,
	(SELECT app_language FROM user_settings WHERE user_id = users.id) AS 'app_laguage',
	(SELECT is_premium_account FROM user_settings WHERE user_id=users.id) AS 'is_premium_account',
	(SELECT created_at FROM user_settings WHERE user_id=users.id) AS 'created'
FROM users
WHERE id = 1;

#Через join (обьеденения)
SELECT
	firstname,
	lastname,
	app_language,
	is_premium_account AS 'is_premium',
	created_at
FROM users AS u
JOIN user_settings AS us ON us.user_id = u.id
WHERE id = 1;


