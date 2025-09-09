DELIMITER $$

CREATE PROCEDURE retour_livre(IN p_id_emprunt INT, IN p_date_retour DATE)
BEGIN
    DECLARE v_date_emprunt DATE;
    DECLARE v_nb_jours_max INT;
    DECLARE v_retard INT;
    DECLARE v_id_livre INT;

    -- Gestion des erreurs SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Erreur lors du retour, transaction annulée' AS message;
    END;

    -- Démarrer la transaction
    START TRANSACTION;

    -- Récupération des infos d’emprunt
    SELECT date_emprunt, nb_jours_max, id_livre
    INTO v_date_emprunt, v_nb_jours_max, v_id_livre
    FROM emprunt
    WHERE id_emprunt = p_id_emprunt;

    -- Calcul du retard
    SET v_retard = DATEDIFF(p_date_retour, v_date_emprunt);

    -- Mise à jour en fonction du retard
    IF v_retard > v_nb_jours_max THEN
        UPDATE emprunt
        SET penalite = calculer_frais_retard(v_retard - v_nb_jours_max),
            date_retour = p_date_retour
        WHERE id_emprunt = p_id_emprunt;
    ELSE
        UPDATE emprunt
        SET date_retour = p_date_retour,
            penalite = 0.0
        WHERE id_emprunt = p_id_emprunt;
    END IF;


    -- Valider la transaction
    COMMIT;

    SELECT 'Retour enregistré avec succès' AS message;
END$$

DELIMITER ;
