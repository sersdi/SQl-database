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

#Соединения Union							

# Использование UNION [DISTINCT] - FULL OUTER JOIN
SELECT *
FROM users
LEFT JOIN private_messages ON users.id = private_messages.sender_id
	UNION DISTINCT
SELECT *
FROM users
RIGHT JOIN private_messages ON users.id = private_messages.sender_id

# Использование UNION ALL - самые активные в сообщениях пользователи
SELECT 
	count(*) AS cnt,
	sender_id
FROM (
	SELECT sender_id 
	FROM channel_messages 
		UNION ALL 
	SELECT sender_id 
	FROM group_messages  
) AS s
GROUP BY sender_id
ORDER BY cnt DESC 

																		#Оконные функции			

# подсчет популярности яыков (с группировкой и агрегирующей функцией)
SELECT 
	COUNT(*) AS cnt,
	app_language 
FROM user_settings
GROUP BY app_language;

# то же (с оконной функцией)
SELECT DISTINCT 
	COUNT(*) OVER (PARTITION BY app_language) AS cnt,
	app_language 
FROM user_settings;

# оконные функции позволяют выводить любые другие поля таблицы
SELECT DISTINCT 
	COUNT(*) OVER (PARTITION BY app_language) AS cnt,
	app_language,
	color_scheme 
FROM user_settings;

# в рамках одного запроса можно использовать несколько оконных функций
SELECT DISTINCT 
	ROW_NUMBER() OVER() AS rn,
	RANK() OVER(ORDER BY app_language) AS language_rank,
	DENSE_RANK() OVER(ORDER BY app_language) AS language_rank2,
	ROW_NUMBER() OVER(PARTITION BY app_language) AS rn2,
	COUNT(*) OVER (PARTITION BY app_language) AS cnt1,
	COUNT(*) OVER (PARTITION BY color_scheme) AS cnt2,
	app_language,
	color_scheme 
FROM user_settings
ORDER BY app_language, rn2;

# альтернативный синтаксис (именованные оконные функции)
SELECT DISTINCT 
	COUNT(*) OVER win1 AS cnt,
	app_language 
FROM user_settings
WINDOW win1 AS (PARTITION BY app_language);

# использование одного 'окна' вместе с разными фунциями
SELECT
  app_language,
  ROW_NUMBER() OVER w AS 'row_number',
  RANK()       OVER w AS 'rank',
  DENSE_RANK() OVER w AS 'dense_rank'
FROM user_settings
WINDOW w AS (ORDER BY app_language);

																	#Общие табличные выражения				

# пример из прошлых уроков (получение данных о пользователе из разных таблиц с помощью вложенных запросоов)
SELECT 
	firstname ,
	lastname ,
	(SELECT app_language FROM user_settings WHERE user_id = users.id) AS 'app_language',
	(SELECT is_premium_account FROM user_settings WHERE user_id = users.id) AS 'is_premium_account'
FROM users
WHERE id = 2;

# тот же результат, но с помощью CTE (общего табличного выражения)
WITH cte1 AS (
	SELECT 
		user_id,
		app_language ,
		is_premium_account
	FROM user_settings
)
SELECT 
	firstname ,
	lastname , 
	app_language ,
	is_premium_account	
FROM cte1
JOIN users AS u ON u.id = cte1.user_id
WHERE id = 2
;

# в 1 запросе можно использовать несколько табличных выражений (у каждого из них должно быть свое уникальное имя)
WITH cte1 AS (
	SELECT * FROM channel_subscribers 
),
cte2 AS (
	SELECT * FROM group_members  
)
SELECT * FROM cte2
# ....;

																
																	# Рекурсивные табличные выражения
# вывод иерархии сообщений (кто-кому отвечал)
WITH RECURSIVE message_replies(id, body, history) AS (
	SELECT id, body, cast(id AS CHAR(100))
	FROM group_messages 
	WHERE reply_to_id IS NULL 
		UNION ALL 
	SELECT gm.id, gm.body, CONCAT(mr.history, ' <-- ', gm.id)
	FROM message_replies AS mr
	JOIN group_messages AS gm ON mr.id = gm.reply_to_id
)
SELECT * FROM message_replies ORDER BY history



SELECT 
	firstname,
	lastname
FROM users
WHERE id in (SELECT user_id FROM user_settings WHERE app_language = 'russian')
ORDER BY lastname;


select
    id,
    views_count,
    created_at,
    (select firstname from users where id = 2) as name,
    (select lastname from users where id = 2) as lastname,
    (select count(user_id) from stories_likes where user_id = 2) as count
from stories
where user_id = 2
order by views_count desc;


SELECT
    u.firstname,
    u.lastname,
    email
FROM users u
LEFT OUTER JOIN channel_subscribers cs ON u.id = cs.user_id
WHERE cs.user_id IS NULL;
 
SELECT DISTINCT 
	user_id,
	COUNT(*) OVER (PARTITION BY channel_id) AS cnt
FROM channel_subscribers
LIMIT 1;


																#Полнотекстовый поиск

# обычный фильтр с оператором WHERE-LIKE
SELECT *
FROM saved_messages 
WHERE body LIKE '%ratione%' OR body LIKE '%est%';

# создание полнотекстового индекса на поле body
CREATE FULLTEXT INDEX full_body_idx ON saved_messages(body);

# полнотекстовый поиск в режиме BOOLEAN
# + обязательное слово
# - исключаемое слово
SELECT *
FROM saved_messages 
WHERE match(body) AGAINST('+ratione +est -voluptatem' IN BOOLEAN MODE);

# полнотекстовый поиск в режиме BOOLEAN
# * заменитель любого окончания слова
SELECT *
FROM saved_messages 
WHERE MATCH(body) AGAINST('+ratione +est +vol*' IN BOOLEAN MODE);



																			#Представление (VIEW)
# удалить представление с проверкой
DROP VIEW IF EXISTS v_users_messages;

# создать представление
CREATE VIEW v_users_messages AS 
	SELECT 
		users.id AS uid, firstname, lastname,
		private_messages.id AS pmid, sender_id, body, created_at
	FROM users
	LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id
	ORDER BY private_messages.id
	LIMIT 12;
	
# создать или изменить представление
CREATE OR REPLACE VIEW v_users_messages AS 
	SELECT 
		users.id AS uid, firstname, lastname,
		private_messages.id AS pmid, sender_id, body, created_at
	FROM users
	LEFT OUTER JOIN private_messages ON users.id = private_messages.sender_id
	ORDER BY private_messages.id
	LIMIT 12;
	
# вывод данных через представление	
SELECT * 
FROM v_users_messages
WHERE uid =5 ;	


																		#Процедуры

# удаление процедуры с проверкой
DROP PROCEDURE IF EXISTS my_procedure;

# установка нового разделителя команд
DELIMITER //

# создание самой процедуры
CREATE PROCEDURE my_procedure()
BEGIN
    SELECT 456;
    SELECT 456;
    SELECT 456;
END//

# возвращение стандартного разделителя команд
DELIMITER ;    
    
# вызов процедуры    
CALL my_procedure();

##########################################################################

# процедура, возвращающая указанное число случайных групп или каналов
DROP PROCEDURE IF EXISTS telegram.random_society;

DELIMITER $$
$$
CREATE PROCEDURE telegram.random_society(cnt int)
BEGIN
    SELECT id, title , invite_link , 'channel' AS community_type
    FROM channels 
        UNION 
    SELECT id, title , invite_link , 'group' AS community_type
    FROM `groups`  
    ORDER BY rand()
    LIMIT cnt;
END $$
DELIMITER ;


# вызов процедуры
CALL random_society(3);




																	#Вызовы функции
# создаем функцию
CREATE FUNCTION `telegram`.`get_premium_percentage`() 
RETURNS float
    READS SQL DATA
BEGIN
    DECLARE premium_users_count INT;
    DECLARE total_users_count INT;
    DECLARE _result FLOAT;    
   
    SET premium_users_count = (
        SELECT count(*)
        FROM user_settings
        WHERE is_premium_account = TRUE 
    );
   
    SET total_users_count = (
        SELECT count(*)
        FROM user_settings
    );
    
    SET _result = premium_users_count / total_users_count;
    
    RETURN _result;
END

# вызываем функцию
SELECT telegram.get_premium_percentage();


# Переменные
# задаем локальную переменную
SET @users_count = 10;     
# читаем значение переменной
SELECT @users_count;

# выводим список глобальных переменных
SHOW GLOBAL VARIABLES;

# выводим только переменную foreign_key_checks (отвечает за проверку внешних ключей)
SHOW VARIABLES LIKE 'foreign_key_checks';

# выводим глобальное значение системной переменной
SHOW GLOBAL VARIABLES LIKE 'foreign_key_checks';

# выводим локальное значение системной переменной
SHOW SESSION VARIABLES LIKE 'foreign_key_checks';

# выключаем локально проверку внешних ключей
SET @@foreign_key_checks = 0;
SET foreign_key_checks = 0;

# выключаем глобально проверку внешних ключей
SET GLOBAL foreign_key_checks = 0;

# присвоение значений переменным в SELECT запросе
SELECT 
	@id := id,
	@firstname := firstname
FROM users
WHERE id = 1;

# чтение переменных
SELECT @id, @firstname;

# второй вариант присвоения значений переменным в SELECT запросе
SELECT id, firstname
INTO @id, @firstname
FROM users
WHERE id = 11;

# объявление переменных вне процедур\функций
SET @user_id = 5;
SET @channel_id = 5;

# является ли пользователь владельцем канала
SELECT @user_id = (
    SELECT owner_user_id
    FROM channels
    WHERE id = @channel_id
) AS 'is_owner';

																	# создание параметризованной функции

# функция определяет отношение пользователя к каналу (владелец, подписчик, посторонний)
CREATE FUNCTION `telegram`.`get_user_to_channel_relation`(
    _user_id BIGINT UNSIGNED, _channel_id  BIGINT UNSIGNED
) RETURNS varchar(15) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE owner_id BIGINT UNSIGNED;
    DECLARE subscriber_id BIGINT UNSIGNED;

    SELECT owner_user_id
    INTO owner_id
    FROM channels
    WHERE id = _channel_id;

    IF _user_id = owner_id THEN 
        RETURN 'owner';
    END IF;

    SELECT user_id
    INTO subscriber_id
    FROM channel_subscribers
    WHERE channel_id = _channel_id AND user_id = _user_id;

    IF subscriber_id THEN 
        RETURN 'subscriber';
    END IF;    

    RETURN 'outsider';
END

# вызов функции с параметрами
SELECT get_user_to_channel_relation(1, 11);



															# создание триггера на событие обновления (BEFORE UPDATE)

DROP TRIGGER IF EXISTS telegram.check_user_age_before_update;
USE telegram;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `check_user_age_before_update` 
BEFORE UPDATE ON `users` 
FOR EACH ROW 
BEGIN 
    DECLARE message varchar(100);

    IF NEW.birthday > CURRENT_DATE() THEN 
        SET message = CONCAT('Update has been cancelled.',
            'New value: ', NEW.birthday, ' is incorrect.'
            'Old value: ', OLD.birthday, ' retained.'
        );

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = message;
    END IF;    
END $$
DELIMITER ;


# создание триггера на событие вставки(BEFORE INSERT)

DROP TRIGGER IF EXISTS telegram.check_user_age_before_insert;
USE telegram;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `check_user_age_before_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN 
    IF NEW.birthday > CURRENT_DATE() THEN
        SET NEW.birthday = CURRENT_DATE();
    END IF;    
END $$
DELIMITER ;


# вставка некорректных данных (дата рождения)
INSERT INTO users 
SET 
    firstname = 'Nick',
    lastname = 'Durov',
    birthday = '2040.10.10'
;

# обновление на некорректные данные (дата рождения)
UPDATE users 
SET birthday = '2040.10.10'
WHERE id = 10;



															# вызов транзакции
CALL add_user('Solar2', 'Reickal2', 'ser.234@exaple.ru', '2002-06-05', FALSE, 'english', @trans_result);
SELECT @trans_result;

# удаляем процедуру с проверкой
DROP PROCEDURE IF EXISTS telegram.add_user;

# устанавливаем разделитель команд
DELIMITER $$

# создаем процедуру
CREATE PROCEDURE telegram.add_user(
    _firstname VARCHAR(100), 
    _lastname VARCHAR(100), 
    _email VARCHAR(100), 
    _birthday DATE,
    _is_premium_account BIT, 
    _app_language ENUM('english','french','russian','german','belorussian','croatian','dutch'), 
    
    OUT trans_result VARCHAR(200)
)
BEGIN
# объявляем необходимые переменные
    DECLARE has_error BIT DEFAULT 0;
    DECLARE code VARCHAR(100);
    DECLARE error_string VARCHAR(100);

# объявляем обработчик исключений
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET has_error = 1;
    
        GET stacked DIAGNOSTICS CONDITION 1
            code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
         
        SET trans_result = CONCAT('Error occured! Code: ', code, '. Text: ', error_string);
    END;

# начинаем транзакцию    
    START TRANSACTION;    
        INSERT INTO `users` (firstname, lastname, email, birthday)
        VALUES (_firstname, _lastname, _email, _birthday);

        INSERT INTO `user_settings` (user_id, is_premium_account, app_language, created_at)
        VALUES (LAST_INSERT_ID(), _is_premium_account, _app_language, NOW());
    
# проверяем ошибки
    IF has_error THEN
        # SET trans_result = 'Error!';
        ROLLBACK;
    ELSE 
        SET trans_result = 'Ok.';
        COMMIT;
    END IF;
END$$

# возвращаем разделитель в значение по умолчанию
DELIMITER ;


# вызываем процедуру с параметрами
CALL add_user('Leslie3', 'Reichel3',  'cronin.emmitt3@example.net', '1982-05-01', FALSE, 'english', @trans_result);

# читаем результат выполнения процедуры
SELECT @trans_result;

# проверяем данные в таблицах
SELECT * FROM users ORDER BY id DESC;
SELECT * FROM user_settings ORDER BY user_id DESC;



																					#Уровни изоляций транзакций 

# вывести нужную переменную
SHOW VARIABLES LIKE '%isolation%';

# установить глобальный уровень изоляции транзакций в значение READ UNCOMMITTED
SET global TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

# установить глобальный уровень изоляции транзакций в значение READ COMMITTED
SET global TRANSACTION ISOLATION LEVEL READ COMMITTED;

# установить глобальный уровень изоляции транзакций в значение REPEATABLE READ
SET global TRANSACTION ISOLATION LEVEL REPEATABLE READ;

# установить глобальный уровень изоляции транзакций в значение SERIALIZABLE
SET global TRANSACTION ISOLATION LEVEL SERIALIZABLE;

# зайти на локальный сервер MySQL
mysql - u root -p

# выйти из сервера (закончить текущую сессию)
exit

# переключиться на БД telegram
use telegram;

# начать транзакцию
start transaction;
begin;

# зафиксировать изменения и закончить транзакцию
commit;

# отменить изменения и закончить транзакцию
rollback;



																			#Блокировка таблиц
# вывести идентификатор текущего подключения
SELECT CONNECTION_ID();

# вывести список активных подключений к серверу
SHOW PROCESSLIST;

# заблокировать таблицу stories на чтение
LOCK TABLE stories READ;

# заблокировать таблицу stories на запись
LOCK TABLE stories WRITE;

# разблокировать все таблицы
UNLOCK TABLES;


																		#Взаимная блокировка
# включить логирование дополнительной информации о блокировках
SET GLOBAL innodb_print_all_deadlocks = ON;

# проверить значение глобальной переменной
SHOW VARIABLES LIKE 'innodb_print_all_deadlocks';

# вывести информацию о текущих блокировках
SELECT * FROM performance_schema.data_locks

# вывести информацию о текущих ожидающих командах
SELECT * FROM performance_schema.data_lock_waits;

# вывести количество взаимных блокировок со времени старта сервера
SELECT `count` 
FROM INFORMATION_SCHEMA.INNODB_METRICS
WHERE NAME="lock_deadlocks";

# посмотреть имя/путь файла с логами ошибок
SELECT @@log_error;





																						#Права доступа
# вывести инфо о текущем пользователе
SELECT CURRENT_USER();
SELECT user();

# вывести список всех пользователей на сервере (с информацией о правах доступа)
SELECT * FROM mysql.user;

# вывести права доступа текущего пользователя
SHOW grants;

# вывести права доступа указанного пользователя
SHOW grants FOR 'root'@'localhost';

# создать пользователя и указать ему пароль
CREATE USER 'john_admin'@'localhost' IDENTIFIED BY '12345';
CREATE USER 'max_tester'@'localhost' IDENTIFIED BY '12345';

# раздать пользователю максимальные права на всем сервере
GRANT ALL PRIVILEGES ON *.* TO 'john_admin'@'localhost';
# проверить права
SHOW grants FOR 'john_admin'@'localhost';

# создать пользователя без указания пароля
CREATE USER 'alex_dev'@'localhost';

# задать пароль пользователю
SET PASSWORD FOR 'alex_dev'@'localhost' = '12345';

# задать пользователю максимальные права на указанную БД
GRANT ALL PRIVILEGES ON telegram.* TO 'alex_dev'@'localhost';
# проверить результат
SHOW grants FOR 'alex_dev'@'localhost';

# задать пользователю указанный набор прав (DDL + DML) на указанной БД
GRANT CREATE, ALTER, DROP, SELECT, UPDATE, INSERT, DELETE 
ON telegram.* 
TO 'max_tester'@'localhost';
# проверить
SHOW grants FOR 'max_tester'@'localhost';

# забрать права на указанные команды у пользователя
REVOKE CREATE, ALTER, DROP 
ON telegram.* 
FROM 'max_tester'@'localhost';
# проверить
SHOW grants FOR 'max_tester'@'localhost';

# создать пользователя с необходимостью менять пароль раз в 180 дней и прочими ограничениями
CREATE USER 'paul_manager'@'localhost' 
PASSWORD EXPIRE INTERVAL 180 DAY
FAILED_LOGIN_ATTEMPTS 3 
PASSWORD_LOCK_TIME 2;

# сменить/задать пароль пользователю
SET PASSWORD FOR 'paul_manager'@'localhost' = '12345';

# задать права доступа только на чтение для указанного пользователя
GRANT SELECT ON telegram.* TO 'paul_manager'@'localhost';

# забрать все права у пользователя на указанную БД
REVOKE ALL PRIVILEGES ON telegram.* FROM 'paul_manager'@'localhost';

# выдать права только на чтение и только на указанные поля
GRANT SELECT(firstname, lastname) ON telegram.users TO 'paul_manager'@'localhost';

# удалить пользователя
DROP USER 'paul_manager'@'localhost';

# выдать указанные права пользователю
GRANT DELETE ON world.* TO 'alex_dev'@'localhost';
GRANT SELECT ON world.* TO 'alex_dev'@'localhost';
GRANT UPDATE ON world.* TO 'alex_dev'@'localhost';
GRANT INSERT ON world.* TO 'alex_dev'@'localhost';



																				#Роли
# создать роли
CREATE ROLE '_admin';
CREATE ROLE '_developer', '_tester', '_manager';

# посмотреть определение таблицы user в БД mysql
SHOW COLUMNS FROM mysql.user;
# вывести содержимое указанной таблицы
SELECT * FROM mysql.user;

# раздать права ролям (по аналогии с пользователями в прошлом уроке)
GRANT ALL privileges ON *.* TO '_admin';
GRANT ALL privileges ON telegram.* TO '_developer';
GRANT CREATE, ALTER, DROP, SELECT, UPDATE, INSERT, DELETE 
ON telegram.* 
TO '_tester';
GRANT SELECT ON telegram.* TO '_manager';

# забрать права у пользователей
REVOKE ALL ON *.* 
FROM 
	`john_admin`@`localhost`, 
	`alex_dev`@`localhost`, 
	`max_tester`@`localhost`, 
	`paul_manager`@`localhost`;

# проверить права пользователей
SHOW GRANTS FOR `john_admin`@`localhost`;
SHOW GRANTS FOR `alex_dev`@`localhost`;

# присвоить группы пользователям
GRANT '_admin' TO `john_admin`@`localhost`;
GRANT '_developer' TO `alex_dev`@`localhost`;
GRANT '_tester' TO `max_tester`@`localhost`;
GRANT '_manager' TO `paul_manager`@`localhost`;

# проверить роль текущего пользователя
SELECT CURRENT_ROLE();

# установить роли по умолчанию (чтобы роль применялась автоматически для пользователей)
SET DEFAULT ROLE ALL TO
	`john_admin`@`localhost`, 
	`alex_dev`@`localhost`, 
	`max_tester`@`localhost`, 
	`paul_manager`@`localhost`;

# забрать роль у пользователя
REVOKE '_manager' FROM `paul_manager`@`localhost`;

# создать нового менеджера
CREATE USER 'anna_manager'@'localhost' IDENTIFIED BY '12345'
PASSWORD EXPIRE INTERVAL 180 DAY
FAILED_LOGIN_ATTEMPTS 3 
PASSWORD_LOCK_TIME 2;

# присвоить группу новому пользователю
GRANT '_manager' TO `anna_manager`@`localhost`;
# установить роль по умолчанию для него
SET DEFAULT ROLE ALL TO `anna_manager`@`localhost`;

# удалить роль
DROP ROLE '_manager';



																		#Вопросы оптимизации(лишний join)
# задать используемую БД
USE telegram;

# изначальный запрос с объединением
SELECT 
    firstname,
    lastname,
    email,
    status_text
FROM telegram.users u
JOIN telegram.user_settings us ON u.id = us.user_id 
WHERE id = 1;

# добавление нового поля в таблицу users
ALTER TABLE users ADD COLUMN status_text VARCHAR(70);

# копирование данных из таблицы user_settings в таблицу users (поле status_text)
UPDATE users AS u 
JOIN user_settings AS us ON u.id = us.user_id
SET u.status_text = us.status_text ;

# удаление поля в таблице user_settings 
ALTER TABLE user_settings DROP COLUMN status_text;

# обновленный (более оптимальный, без JOIN) запрос, выводящий те же данные, что и изначальный запрос
SELECT 
    firstname,
    lastname,
    email,
    status_text
FROM telegram.users u
# JOIN telegram.user_settings us ON u.id = us.user_id 
WHERE id = 1;



																			#денормализация
# изначальный простой SELECT запрос
SELECT *
FROM stories 
WHERE user_id IN (1,2,3);

# запрос с учетом количества лайков
SELECT 
    s.id,
    COUNT(*)
FROM stories s
JOIN stories_likes sl ON s.id = sl.story_id 
WHERE s.user_id IN (1,2,3)
GROUP BY s.id;

# добавление нового поля для подсчета лайков (собственно, денормализация)
ALTER TABLE stories ADD COLUMN likes_count bigint UNSIGNED DEFAULT 0;

# упрощение финального запроса (достаточно обратиться к 1 таблице)
SELECT 
    s.id,
    likes_count,
    s.*
FROM stories s
# JOIN stories_likes sl ON s.id = sl.story_id 
WHERE s.user_id IN (1,2,3)
# GROUP BY s.id;


																	#Настройки сервера

# включаем логирование медленных запросов
SET GLOBAL slow_query_log = 'ON';

# определяем расположение лога для медленных запросов
SET GLOBAL slow_query_log_file = 'c:\\mysql-slow-query.log';

# устанавливаем критерий для медленных запросов (время исполнения в секундах)
SET GLOBAL long_query_time = 1;

# включаем логирование для запросов, не использующих индексы
SET GLOBAL log_queries_not_using_indexes = 'ON';

# выводим наши переменные
SHOW GLOBAL variables LIKE '%slow%';
SHOW GLOBAL variables LIKE '%long%';

# пример запроса, не использующего индекс
SELECT *
FROM channels 
WHERE title = 'some channel title...';

# пример запроса, использующего индекс
SELECT *
FROM channels 
WHERE id = 1;

# добавление индекса на поле title
ALTER TABLE channels ADD INDEX (title);

																	#Анализ запросов 
# удаляем внешний ключ из таблицы stories_likes
ALTER TABLE telegram.stories_likes DROP FOREIGN KEY stories_likes_ibfk_2;

# удаляем индекс из таблицы stories_likes (на том же поле)
ALTER TABLE telegram.stories_likes DROP INDEX story_id;

# количество строк в таблице stories_likes
SELECT count(*) FROM stories_likes;

# проблемный (медленный запрос)
 EXPLAIN SELECT 
    s.id,
    COUNT(*) AS cnt,
    u.firstname,
    u.lastname,
    (SELECT app_language from user_settings us WHERE u.id = us.user_id) AS app_language
FROM users u
JOIN stories s ON u.id = s.user_id 
JOIN stories_likes sl ON s.id = sl.story_id 
GROUP BY s.id
ORDER BY cnt DESC 
LIMIT 20;


									# использование команды EXPLAIN (применима ко всем командам из набора CRUD)
EXPLAIN SELECT 
	s.id,
	COUNT(*) AS cnt,
	u.firstname,
	u.lastname,
	(SELECT app_language from user_settings us WHERE u.id = us.user_id) AS app_language
FROM users u
JOIN stories s ON u.id = s.user_id 
JOIN stories_likes sl ON s.id = sl.story_id 
GROUP BY s.id
ORDER BY cnt DESC 
LIMIT 20;

# пример быстро исполняющегося запроса
# вывод данных о пользователе
SELECT 
	firstname,
	lastname,
	app_language,
	is_premium_account AS 'is_premium',
	created_at 
FROM users AS u
JOIN user_settings AS us ON us.user_id = u.id
WHERE id = 1;



													# анализ запроса до исправления ошибок
EXPLAIN SELECT 
    s.id,
    COUNT(*) AS cnt,
    u.firstname,
    u.lastname,
    (SELECT app_language from user_settings us WHERE u.id = us.user_id) AS app_language
FROM users u
JOIN stories s ON u.id = s.user_id 
JOIN stories_likes sl ON s.id = sl.story_id 
GROUP BY s.id
ORDER BY cnt DESC 
LIMIT 20;

# возвращаем индекс
ALTER TABLE stories_likes ADD INDEX (story_id);

# возвращаем внешний ключ
ALTER TABLE stories_likes ADD FOREIGN KEY (story_id) REFERENCES stories(id);

# анализ запроса после исправления ошибок
EXPLAIN SELECT 
    s.id,
    COUNT(*) AS cnt,
    u.firstname,
    u.lastname,
    (SELECT app_language from user_settings us WHERE u.id = us.user_id) AS app_language
FROM users u
JOIN stories s ON u.id = s.user_id 
JOIN stories_likes sl ON s.id = sl.story_id 
GROUP BY s.id
ORDER BY cnt DESC 
LIMIT 20;


											#Графический план показательные примеры
# фильтрация по непроиндексированному полю
SELECT * FROM users 
WHERE login = 'any string...'; 

# фильтрация с оператором LIKE
SELECT * FROM users 
WHERE login LIKE 'any string...'; 

# индексация поля login
ALTER TABLE users ADD INDEX (login);

# повторные запросы после добавления индекса
SELECT * FROM users 
WHERE login = 'any string...'; 
# 
SELECT * FROM users 
WHERE login like 'any string...'; 

# оператор LIKE не может использовать индексы
SELECT * FROM users 
WHERE login LIKE '%any string...'; 

SELECT * FROM users 
WHERE login LIKE '_any string...'; 

# поиск по идентификатору (первичному ключу) - самый эффективные способ получения данных
SELECT * FROM users 
WHERE id = 1; 


# вывод данных о пользователе
-- скоррелированный вложенный вариант запроса
SELECT 
    firstname,
    lastname,
    (SELECT app_language FROM user_settings WHERE user_id = users.id) AS 'app_language',
    (SELECT is_premium_account FROM user_settings WHERE user_id = users.id) AS 'is_premium',
#    (SELECT status_text FROM user_settings WHERE user_id = users.id) AS 'status_text',
    (SELECT created_at FROM user_settings WHERE user_id = users.id) AS 'created_at'
FROM users
WHERE id = 1;

-- вариант с использованием INNER JOIN
SELECT 
    firstname,
    lastname,
    app_language,
    is_premium_account AS 'is_premium',
#    status_text,
    created_at
FROM users AS u
JOIN user_settings AS us ON us.user_id = u.id
WHERE id = 1;
