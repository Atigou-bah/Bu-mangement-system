DELIMITER $$

CREATE FUNCTION emprunt_en_cours(p_id_etudiant INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE nb INT;

    SELECT COUNT(*) 
    INTO nb
    FROM emprunt em
    WHERE em.id_etudiant = p_id_etudiant
    RETURN nb;
END$$

DELIMITER ;

            
