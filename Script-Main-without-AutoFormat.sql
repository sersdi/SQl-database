DROP DATABASE IF EXISTS telegram;
CREATE SCHEMA telegram;
USE telegram;

DROP TABLE IF EXISTS users;
CREATE TABLE `users`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    # id SERIAL, # BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT 'фамилия',
    login VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(256),
    phone BIGINT UNSIGNED UNIQUE, # +7 (900) 123-45-67 => 79 001 234 567

    INDEX idx_users_username(firstname, lastname)
) COMMENT 'пользователи';

#1 x 1
DROP TABLE IF EXISTS user_settings;
CREATE TABLE user_settings(
	user_id BIGINT unsigned NOT NULL PRIMARY KEY,
	is_premium_account BIT,
	is_night_mode_enabled BIT,
	color_scheme ENUM('classic', 'day','tinted'),
	app_language ENUM('english', 'french','russian'),
	status_text VARCHAR(70),
	notifications_and_sounds JSON,
	created_at DATETIME DEFAULT NOW()
);

# ALTER TABLE user_settings RENAME COLUMN LANGUAGE TO app_language;

ALTER TABLE user_settings ADD CONSTRAINT fk_user_settings_user_id	#Alter Table создание внешних ключей  сonstraint(ограничение целостности данных)
FOREIGN KEY (user_id) REFERENCES users(id) 							# foreign key внешний ключ(поле)     references ссыылается на какую то таблицу и её поле
ON UPDATE CASCADE 							# значение cascade по умолчанию для on update (задание поведения при обновлении данных в главной  таблице)
ON DELETE RESTRICT; 						# значение restrict по умолочанию для on delete (задание поведение при удалении в главной таблице)

# ON UPDATE CASCADE(при изменении записи в главной таблице, каскадно автоматчески изменится на соответствующие значение в зависимой таблице)
# restrict(не можем удалить запись из главной таблицы если на неё ссылается зависимая таблица)
# set null(выставляем отсутсвие значения при наступлении события on update или on delete)
# set default()

						#Команда alter table изменяет существующую таблицу	тем или иным способом												

ALTER TABLE users ADD COLUMN  birthday datetime;   #добавляем поля в основную таблицу(не можем напрямую добавлять поля тк потеряем данные пользователей при пересоздании таблицы)

ALTER TABLE users MODIFY COLUMN birthday date;  #если нужно поменять тип данных у поля

ALTER TABLE users RENAME COLUMN birthday TO date_of_birth; #меянем название поля

ALTER TABLE users DROP COLUMN date_of_birth;     #удалили поле

#  если Забыли добавить primary key что бы значения поля user_id были уникальными и не повторялись можем использовать 2 варианта:
# 	ALTER TABLE user_settings ADD PRIMARY key(user_id);
# 	ALTER TABLE user_settings MODIFY COLUMN user_id BIGINT unsigned NOT NULL PRIMARY KEY;


#DROP TABLE IF EXISTS media_types;			#альтернативный способ создарния вместо поля media_type в табилце private_massages создаем ещё таблицу(справочник) 
#CREATE TABLE media_types(					#обычно такую таблицу создают когда значения со временем могут добавляться 
#	id serial,							
#	name varchar(50)
#	
#);

# 1 x M
DROP TABLE IF EXISTS `private_messages`;
CREATE TABLE `private_messages`(
	`id` serial,
	`sender_id` bigint unsigned NOT NULL,  #sender_id отправитель
	`receiver_id` bigint unsigned NOT NULL,	#receiver_id получатель
	`reply_to_id` bigint unsigned  NULL,
	`media_type` enum('text', 'image', 'audio', 'video'),
#	media_type_id bigint insigned NOT NULL  (нужно создать внешний ключ для таблицы справочника )
#	body varchar(), #limit 65535
	`body` text,
#	file blob    #blob(binary large object, если используется файл то файл преобразуется в массив байт и хранится в этом поле по порядку)
	`filename` varchar(200),
	`created_at` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (sender_id) REFERENCES users(id),
	FOREIGN KEY (receiver_id) REFERENCES users(id),
	FOREIGN KEY (reply_to_id) REFERENCES private_messages(id)
);

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups`(
	id serial,
	title varchar(45),
	icon varchar(45),
	invite_link varchar(100),
	settings JSON,
	owner_user_id bigint unsigned NOT NULL,
	is_private BIT,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (owner_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS `group_members`;
CREATE TABLE `group_members`(
	`id` serial,
	`group_id` bigint unsigned NOT NULL,
	`user_id` bigint unsigned NOT NULL,
	`created_at` datetime default now(),
	
	FOREIGN KEY (user_id)  REFERENCES users(id),
	FOREIGN KEY (group_id)  REFERENCES `groups`(id)
);

DROP TABLE IF EXISTS `group_messages`;
CREATE TABLE `group_messages`(
	id serial,
	group_id bigint unsigned NOT NULL,
	sender_id bigint unsigned NOT NULL,
	reply_to_id bigint unsigned NOT NULL,
	media_type enum('text', 'image', 'audio', 'video'),
	body TEXT,
	filename VARCHAR(100) NULL,
	created_at datetime default now(),
	
	FOREIGN KEY (sender_id)  REFERENCES users(id),
	FOREIGN KEY (group_id)  REFERENCES `groups`(id),
	FOREIGN KEY (reply_to_id)  REFERENCES group_messages(id)
);

DROP TABLE IF EXISTS `channels`;
CREATE TABLE `channels`(
	id serial,
	title varchar(45),
	icon varchar(45),
	invite_link varchar(100),
	settings JSON,
	owner_user_id bigint unsigned NOT NULL,
	is_private BIT,
#	channel_type enum('public', 'private');
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (owner_user_id)  REFERENCES users(id)
);

#M x M
DROP TABLE IF EXISTS `channel_subscribers`;
CREATE TABLE `channel_subscribers`(
	channel_id bigint UNSIGNED NOT NULL,
	user_id bigint UNSIGNED NOT NULL,
	status enum('requested', 'joined', 'left'),
	created_at datetime DEFAULT now(),
	updated_at datetime ON UPDATE current_timestamp,   #при обновлении строчки в этой таблице в поле автоматически проставляется текущее время
	
	PRIMARY KEY(user_id, channel_id),     #тк эта таблица связывает две другие таблицы(channels,users) добавляем первичный ключ что бы значения были уникальными и можно было идентифицировать запись
	FOREIGN KEY (channel_id)  REFERENCES channels(id),
	FOREIGN KEY (user_id)  REFERENCES users(id)
);

DROP TABLE IF EXISTS `channel_messages`;
CREATE TABLE `channel_messages`(
	id serial,
	channel_id bigint unsigned NOT NULL,
	sender_id bigint unsigned NOT NULL,
	media_type enum('text', 'image', 'audio', 'video'),
	body TEXT,
	filename VARCHAR(100) NULL,
	created_at datetime default now(),
	
	FOREIGN KEY (sender_id)  REFERENCES users(id),
	FOREIGN KEY (channel_id)  REFERENCES channels(id)
);

DROP TABLE IF EXISTS `saved_messages`;
CREATE TABLE `saved_messages`(
	id serial,        						 # идентификатор записи
	user_id BIGINT UNSIGNED NOT NULL,
	body text,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (user_id)  REFERENCES users(id)
);

DROP TABLE IF EXISTS `reactions_list`;
CREATE TABLE `reactions_list`(
	id serial,        						
	code varchar(1)
) DEFAULT charset = utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `private_message_reactions`;
CREATE TABLE `private_message_reactions`(
	reaction_id BIGINT unsigned NOT NULL,
	message_id BIGINT unsigned NOT NULL,
	user_id BIGINT unsigned NOT NULL,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (user_id)  REFERENCES users(id),
	FOREIGN KEY (reaction_id)  REFERENCES reactions_list(id),
	FOREIGN KEY (message_id)  REFERENCES private_messages(id)
);

DROP TABLE IF EXISTS `channel_message_reactions`;
CREATE TABLE `channel_message_reactions`(
	reaction_id BIGINT unsigned NOT NULL,
	message_id BIGINT unsigned NOT NULL,
	user_id BIGINT unsigned NOT NULL,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (user_id)  REFERENCES users(id),
	FOREIGN KEY (reaction_id)  REFERENCES reactions_list(id),
	FOREIGN KEY (message_id)  REFERENCES channel_messages(id)
);

DROP TABLE IF EXISTS `group_message_reactions`;
CREATE TABLE `group_message_reactions`(
	reaction_id BIGINT unsigned NOT NULL,
	message_id BIGINT unsigned NOT NULL,
	user_id BIGINT unsigned NOT NULL,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (user_id)  REFERENCES users(id),
	FOREIGN KEY (reaction_id)  REFERENCES reactions_list(id),
	FOREIGN KEY (message_id)  REFERENCES group_messages(id)

);

DROP TABLE IF EXISTS stories;
CREATE table stories (
	id serial,
	user_id bigint unsigned NOT NULL,
	caption varchar(140),
	filename varchar(100),
	views_count int UNSIGNED,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS stories_like;
CREATE TABLE stories_like(
	id serial,
	story_id bigint unsigned NOT NULL,
	user_id bigint unsigned NOT NULL,
	created_at datetime DEFAULT now(),
	
	FOREIGN KEY (story_id) REFERENCES stories(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);


	
	

