-- 取消追蹤後觸發紀錄邏輯

DELIMITER $$

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows (follower_id, follow_who_id) VALUES (OLD.follower_id,OLD.follow_who_id);
    END;

$$
DELIMITER ;