DELIMITER $$

CREATE PROCEDURE emprunter_livre(IN p_id_etudiant INT, IN p_id_livre INT)
BEGIN 
    IF existe_etudiant(p_id_etudiant) AND livre_disponible(p_id_livre) THEN 
        INSERT INTO emprunt(id_emprunt, id_etudiant, id_livre, date_emprunt, nb_jours_max, nb_jours_restant, penalite,date_retour) 
        VALUES (NULL, p_id_etudiant, p_id_livre, CURDATE(), 15, 15, 0.0,NULL); 
    ELSE
        SELECT 'Livre non disponible ou étudiant inexistant' AS message; 
    END IF;
END$$

DELIMITER ;

