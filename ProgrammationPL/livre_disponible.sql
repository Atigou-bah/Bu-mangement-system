DELIMITER $$

CREATE FUNCTION livre_disponible(p_id_livre INT) 
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE nb INT;

    SELECT COUNT(*) INTO nb
    FROM emprunt
    WHERE id_livre = p_id_livre
      AND nb_jours_restant IS NULL; 

    IF nb = 0 THEN
        RETURN TRUE;   
    ELSE
        RETURN FALSE;  
    END IF;
END$$

DELIMITER ;

