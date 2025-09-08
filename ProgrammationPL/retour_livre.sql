DELIMITER $$

CREATE PROCEDURE retour_livre(IN p_id_emprunt INT, IN p_date_retour DATE)
BEGIN
    DECLARE v_date_emprunt DATE;
    DECLARE v_nb_jours_max INT;
    DECLARE v_retard INT;

    SELECT date_emprunt, nb_jours_max
    INTO v_date_emprunt, v_nb_jours_max
    FROM emprunt
    WHERE id_emprunt = p_id_emprunt;

    SET v_retard = DATEDIFF(p_date_retour, v_date_emprunt);

    IF v_retard > v_nb_jours_max THEN
        UPDATE emprunt
        SET penalite = calculer_frais_retard(v_retard - v_nb_jours_max),
            date_retour = p_date_retour
        WHERE id_emprunt = p_id_emprunt;
    ELSE
        UPDATE emprunt
        SET date_retour = p_date_retour
        WHERE id_emprunt = p_id_emprunt;
    END IF;
END$$

DELIMITER ;
