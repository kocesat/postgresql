
-- Creating messages TABLE
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	sender VARCHAR(4),
	receiver VARCHAR(4),
	amount DECIMAL
)

-- Querying Gönderdiği Aldığı Mesaj Adet ve Tutarlar
SELECT 
  COALESCE(as_sender.sender, as_receiver.receiver) AS "Katılımcı", 
  COALESCE(sending_volume, 0) AS "Gönderdiği Adet", 
  COALESCE(sending_value, 0) AS "Gönderdiği Tutar",
  COALESCE(receiving_volume, 0) AS "Aldığı Adet",
  COALESCE(receiving_value, 0) AS "Aldığı Tutar"
FROM 
(
  SELECT sender, count(id) AS sending_volume, sum(amount) AS sending_value 
  FROM messages
  GROUP BY sender
) AS as_sender
FULL JOIN 
(
  SELECT receiver, count(id) AS receiving_volume, sum(amount) AS receiving_value 
  FROM messages
  GROUP BY receiver
) AS as_receiver
ON as_receiver.receiver = as_sender.sender;