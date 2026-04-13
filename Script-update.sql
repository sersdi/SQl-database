USE telegram;				# почаем какую базу данных будем использовать 

INSERT INTO channels(title, invite_link, owner_user_id, is_private)    # добавляем данные в таблицу 
VALUES ('MySQL news', 'http://t.me/mysqsl_news', 1, true);


INSERT INTO channel_subscribers (channel_id, user_id, status)			# добавляем данные в таблицу
VALUES (1, 2, 'requested');

INSERT INTO channel_subscribers (channel_id, user_id, status)			# добавляем данные в таблицу
VALUES (1, 3, 'requested');

INSERT INTO channel_subscribers (channel_id, user_id, status)			# добавляем данные в таблицу
VALUES (1, 4, 'requested');

	
UPDATE channel_subscribers							# обновляем данные в таблице 
SET 
	status = 'joined'
WHERE channel_id = 1 AND user_id = 2
;

UPDATE channel_subscribers
SET 
	status = 'joined'
WHERE channel_id = 1 AND user_id = 3
;

UPDATE channel_subscribers
SET 
	status = 'left'
WHERE channel_id = 1 AND user_id = 2
;


ALTER TABLE channel_subscribers 
MODIFY COLUMN status ENUM('requested', 'joined', 'left', 'removed');


UPDATE channel_subscribers
SET 
	status = 'removed'
WHERE channel_id = 1 AND user_id = 4
;

UPDATE channels 
SET title = 'General SQL news'
WHERE id = 1;





