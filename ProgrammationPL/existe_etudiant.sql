DELIMITER $$

CREATE FUNCTION existe_etudiant(p_id_etudiant INT) 
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE nb INT;

    SELECT COUNT(*) INTO nb
    FROM etudiant
    WHERE id_etudiant = p_id_etudiant;

    IF nb > 0 THEN
        RETURN TRUE;  
    ELSE
        RETURN FALSE;  
    END IF;
END$$

DELIMITER ;
