import pymysql
from faker import Faker
import random

config = {
    'host': 'localhost',
    'user': 'root',  # ou 'pythonuser' si tu utilises un autre user
    'password': 'Atigoubah23',
    'database': 'bu_universitaire',
    'charset': 'utf8mb4',  # toujours bien mettre le charset
    'cursorclass': pymysql.cursors.DictCursor  # optionnel, tu peux utiliser Cursor classique aussi
}

# Connexion
conn = pymysql.connect(**config)
cursor = conn.cursor()
fake = Faker()

# Générer des étudiants
for i in range(1, 500):
    cursor.execute("""
                   INSERT INTO etudiant (id_etudiant, nom, prenom, formation, mail)
                   VALUES (%s, %s, %s, %s, %s)
                   """, (
                       1000 + i,
                       fake.last_name(),
                       fake.first_name(),
                       random.choice(['informatique', 'droit', 'mathematique', 'economie']),
                       fake.email()
                   ))

# Générer des livres 
for i in range(1,100):
    cursor.execute("""
                   INSERT INTO livre (id,titre,auteur,nb_pages)
                   VALUES(%s,%s,%s,%s)
                   """,(
                       i,
                       fake.name(),
                       fake.sentence(nb_words=4),
                       random.randint(100,1000)
                   ))


# Récupérer IDs existants
cursor.execute("SELECT id FROM livre")
livre_ids = [row['id'] for row in cursor.fetchall()]

cursor.execute("SELECT id_etudiant FROM etudiant")
etudiant_ids = [row['id_etudiant'] for row in cursor.fetchall()]

for i in range(1, 251):
    id_etudiant = random.choice(etudiant_ids)
    id_livre = random.choice(livre_ids)
    
    date_emprunt = fake.date_between(start_date='-60d', end_date='today')
    nb_jours_max = random.randint(7, 30)
    nb_jours_restant = random.randint(0, nb_jours_max)
    penalite = 0
    if nb_jours_restant == 0:
        penalite = round(random.uniform(0, 10), 2)
    
    cursor.execute("""
        INSERT INTO emprunt (id_etudiant, id_livre, date_emprunt, nb_jours_max, nb_jours_restant, penalite)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (id_etudiant, id_livre, date_emprunt, nb_jours_max, nb_jours_restant, penalite))
conn.commit()
conn.close()

print("✅ Données insérées avec succès dans MySQL !")
