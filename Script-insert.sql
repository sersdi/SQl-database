
# Команда insert- позволяет вставлять данные в таблицу 

INSERT INTO users(id, firstname, lastname, email, phone)
VALUES ('1', 'Kelsie', 'Olson', 'asdsD@live.ru', '91239219');

INSERT INTO users(id, firstname, lastname, email, phone)
VALUES ('2', 'Orkqm', 'LSad', 'asdD@live.ru', '9112339219');

INSERT INTO users(id, firstname, lastname, email, phone)
VALUES ('3', 'Kele', 'Olson', 'asd2wdasddD@live.ru', '91213239219');

INSERT IGNORE INTO users(id, firstname, lastname, email, phone)
VALUES ('3', 'Kele', 'Olson', 'asd2wdasddD@live.ru', '91213239219');

INSERT IGNORE INTO users(id, firstname, lastname, email, phone)
VALUES ('3', 'Kele', 'Olson', 'asd2wdasddD@live.ru', '91213239219');

INSERT INTO users(firstname, lastname, email, phone)
VALUES ('Kel', 'Olso', 'asd2w8888dasddD@live.ru', '9121323988219');

ALTER TABLE users ADD COLUMN is_deleted BIT DEFAULT 0;					#добавили новое поле в таблицу

INSERT INTO users(firstname, lastname, is_deleted)
VALUES ('Kelsdr', 'Olsosad', DEFAULT);

INSERT INTO users(firstname, lastname, is_deleted)
VALUES ('Kelsdasdr', 'Olsosadasd', null);

INSERT INTO users
VALUES (101, 'Kelsdr', 'Olsosad', NULL, 'sdsad2323@esaldo', DEFAULT, 981238940);

INSERT INTO users(firstname, lastname, email, phone) VALUES     # пакетная вставка данных лучше использовать ее, тк она быстрее чем одиночная 
('Kelsdasdr', 'Olsosadasd', 'sdeo22@live.ry', 91238576),
('Wemma', 'Ootin', 'sej2sd@kil.ru', 9152),
('Cemma', 'Gotin', 'sj2@kil.ru', 9123152),
('Semma', 'Rotin', 'sej2@3ril.ru', 912);

INSERT INTO users					#одиночная вставка более интуитивно понятная 
SET 
	firstname = 'Ksrsa',
	lastname = 'Romka',
	email = 'sde@love',
	login = 'haseas2',
	phone ='9231239124'
;

INSERT INTO users							#Логика вставки такая же как в одничных запросах через values
	(firstname, lastname, email, phone)
SELECT
	'Kelsda', 'Olsoasd', 'assddD@live.ru', '91123213';


INSERT INTO users (firstname, lastname, email)         # Вставка из других баз данных
SELECT first_name, last_name, email					
FROM sakila.staff;


INSERT INTO users (id, firstname, lastname , email, phone)	 # Обновление данных в таблице
VALUES (2, 'Lucie', 'Robeerts', 'sed@live.ri', 9123957)
ON duplicate KEY UPDATE 					 #если ключ с таким значением уже есть в табилце то надо выполнить обновление данных(в нашем случае это поле id)
	firstname = 'Lucie',
	lastname = 'Robeerts',
	email = 'sed@live.ri',
	phone = 9123957
;

INSERT INTO reactions_list(code) VALUES (😱);
INSERT INTO reactions_list(code) VALUES (😈);
INSERT INTO reactions_list(code) VALUES (🛠️);
INSERT INTO reactions_list(code) VALUES (🙃);



















