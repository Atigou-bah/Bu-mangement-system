DELIMITER $$

CREATE FUNCTION nb_jours_retard(date_retour_prevue DATE, date_retour_effective DATE) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    IF date_retour_effective > date_retour_prevue THEN
        RETURN DATEDIFF(date_retour_effective, date_retour_prevue);
    ELSE
        RETURN 0;
    END IF;
END$$

DELIMITER ;
