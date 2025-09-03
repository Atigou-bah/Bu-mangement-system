CREATE TABLE livre(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    titre VARCHAR(100) NOT NULL,
    auteur VARCHAR(100) NOT NULL, 
    nb_pages INT CHECK (nb_pages > 0)
); 

CREATE TABLE etudiant(
    id_etudiant INT PRIMARY KEY AUTO_INCREMENT, 
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL, 
    formation VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL
); 

CREATE TABLE emprunt (
    id_emprunt INT PRIMARY KEY AUTO_INCREMENT,
    id_etudiant INT NOT NULL,
    id_livre INT NOT NULL,
    date_emprunt DATE DEFAULT (CURRENT_DATE),
    nb_jours_max INT NOT NULL,
    nb_jours_restant INT NOT NULL,
    penalite DECIMAL(5,2) DEFAULT 0,
    CONSTRAINT fk_emprunt_etudiant FOREIGN KEY (id_etudiant) REFERENCES etudiant(id_etudiant),
    CONSTRAINT fk_emprunt_livre FOREIGN KEY (id_livre) REFERENCES livre(id)
);


CREATE INDEX idx_emprunt_etudiant ON emprunt(id_etudiant);
CREATE INDEX idx_emprunt_livre ON emprunt(id_livre);