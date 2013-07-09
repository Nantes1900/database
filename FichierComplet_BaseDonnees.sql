----------------------------------------------------------
-- SCHEMA DE LA BASE DE DONNEES
-- Projet Nantes1900
--
-- Marie-élise Lecoq
-- 2009
--
-- François PEREZ
-- Lucie THOURAULT
-- Avril 2010

-- Vincent Meunier
-- Olivier Catry
-- Remplacement table utilisateur par users, gestion de la modération et des droits
-- Mai 2011

-- Reprise, ajouts et corrections : Benjamin Hervy
-- Juin 2011

-- Reprise, ajouts et corrections : Pierre-Alexandre Nativel
-- Juin 2012

-- Modification mineure pour la prise en charge de CodeIgniter : Pierre-Alexandre Nativel
-- Décembre 2012

-- Reprise, ajouts et corrections : Paul-Yves Lucas
-- Mai 2013

----------------------------------------------------------

--Code sous licence GPL, voir fichier LICENSE pour plus d'infos

----------------------------------------------------------
-- RESSOURCES :
	-- ressources spécifiques 
	-- ressources textuelles
	-- ressources graphiques
	-- ressources videos
-----------------------------------------------------------


----------------------------------------------------------
-- RESSOURCES SPECIFIQUES
-----------------------------------------------------------

-- Supprime en même temps les tables héritées de ressources
DROP TABLE IF EXISTS ressource_specifique CASCADE;

-- Création de la table ressource numerique
CREATE TABLE ressource_specifique (

	ressource_specifique_id serial		NOT NULL,
	username		varchar(32)	NOT NULL,	-- créateur de la ressource : NOT NULL -1 par défaut
	
	-- Caractéristiques
	titre			text 		NOT NULL,	-- Nom du document UNIQUE
	description		text,
	reference_ressource 	text 		NOT NULL,
	disponibilite		text,				-- lieu de disponibilité ou chemin vers la ressource à afficher
	theme_ressource		text,				-- thèmes de la ressource
	auteurs			text[],				-- tableau d'auteurs : format par défaut : prenom NOM
	editeur			text,
	ville_edition		text,

	date_debut_ressource	date,
	date_precision 		varchar(32),
	
	archive_ressource	boolean		DEFAULT false,	-- par défaut, tant que l'archive n'est pas validée elle est à TRUE
	validation		boolean		DEFAULT false, 	-- par défaut, la ressource n'est pas validée (validation = FALSE)

	mots_cles		text,				-- mots clé associés à la ressource

	date_creation   timestamp DEFAULT current_timestamp,	-- date de création de la ressource dans la base : date actuelle lors de l'ajout
	date_maj	timestamp[],								-- tableaux de dates de mise à jour dans la base
	last_modified	timestamp DEFAULT current_timestamp,	-- pour l'indexation de Solr : date de dernière modification

	UNIQUE(titre)
);


----------------------------------------------------------
-- RESSOURCES GRAPHIQUES
-----------------------------------------------------------
-- Supprime en même temps les tables héritées de ressources
DROP TABLE IF EXISTS ressource_graphique CASCADE;

-- Création de la table ressource_graphique
CREATE TABLE ressource_graphique (
	
	ressource_graphique_id	serial 		NOT NULL,
	username		varchar(32)	,		-- créateur de la ressource : NOT NULL -1 par défaut
	
	-- Caractéristiques
	titre			text 		NOT NULL,	-- Nom du document UNIQUE
	description		text,
	reference_ressource 	text 		NOT NULL,
	disponibilite		text,				-- lieu de disponibilité ou chemin vers la ressource à afficher
	theme_ressource		text,				-- thèmes de la ressource
	auteurs			text,				-- tableau d'auteurs : format par défaut : prenom NOM
	editeur			text,
	ville_edition		text,

	date_debut_ressource	date,
	date_precision 		varchar(32),
	
	archive_ressource	boolean		DEFAULT false,	-- par défaut, tant que l'archive n'est pas validée elle est à TRUE
	validation		boolean		DEFAULT false, 	-- par défaut, la ressource n'est pas validée (validation = FALSE)

	mots_cles		text,				-- mots clé associés à la ressource

	date_creation   timestamp DEFAULT current_timestamp,	-- date de création de la ressource dans la base : date actuelle lors de l'ajout
	date_maj	timestamp[],								-- tableaux de dates de mise à jour dans la base
	last_modified	timestamp DEFAULT current_timestamp,	-- pour l'indexation de Solr : date de dernière modification

	UNIQUE(titre),
	legende			text,		-- texte qui devra être ajouté sous la ressource_graphique
	couleur			boolean, 	-- TRUE = couleur / FALSE = NB
	image			text,		-- sert à stocker le nom du fichier image
	image_link		varchar(255),	-- stockage d'une url correspondant à l'image
	original		 boolean,	-- Indique si la ressource provient d'une source primaire ou non
	pagination		integer, 	-- Nombre de pages total de la ressource

	--Pour les ressources de type photo
	dimension		varchar(32),	-- x et y en cm
	date_prise_vue		date,		
	localisation		text,
	cote			varchar(32),
	technique		text,		-- technique d'exécution

	type_support		text
);


----------------------------------------------------------
-- RESSOURCES VIDEO
-----------------------------------------------------------
-- Supprime en même temps les tables héritées de ressources
DROP TABLE IF EXISTS ressource_video CASCADE;
-- Création de la table video
CREATE TABLE ressource_video (
	
	ressource_video_id		serial 		NOT NULL,
	username		varchar(32)		,	-- créateur de la ressource : NOT NULL -1 par défaut
	
	-- Caractéristiques
	titre			text 		NOT NULL,	-- Nom du document UNIQUE
	description		text,
	reference_ressource 	text 		NOT NULL,
	disponibilite		text,				-- lieu de disponibilité ou chemin vers la ressource à afficher
	theme_ressource		text,				-- thèmes de la ressource
	auteurs			text,				-- tableau d'auteurs : format par défaut : prenom NOM
	editeur			text,
	ville_edition		text,

	date_debut_ressource	date,
	date_precision 		varchar(32),
	
	archive_ressource	boolean		DEFAULT false,	-- par défaut, tant que l'archive n'est pas validée elle est à TRUE
	validation		boolean		DEFAULT false, 	-- par défaut, la ressource n'est pas validée (validation = FALSE)

	mots_cles		text,				-- mots clé associés à la ressource

	date_creation   timestamp DEFAULT current_timestamp,	-- date de création de la ressource dans la base : date actuelle lors de l'ajout
	date_maj	timestamp[],								-- tableaux de dates de mise à jour dans la base
	last_modified	timestamp DEFAULT current_timestamp,	-- pour l'indexation de Solr : date de dernière modification

	UNIQUE(titre),
	date_production		date,
	video			text,		-- stockage du nom de la video
	video_link		varchar(255),	-- stockage d'un lien vers une page web contenant la video
	duree			integer, 	-- durée en secondes
	diffusion		text,		
	versionVideo		text,		
	distribution		text,
	generique		text,
	production		text
);

----------------------------------------------------------
-- RESSOURCES TEXTUELLES
-----------------------------------------------------------

-- Supprime en même temps les tables héritées de ressources
DROP TABLE IF EXISTS ressource_textuelle CASCADE;

-- Création de la table ressource textuelle
CREATE TABLE ressource_textuelle (
	
	ressource_textuelle_id		serial 		NOT NULL,
	username		varchar(32)		,	-- créateur de la ressource : NOT NULL -1 par défaut
	
	-- Caractéristiques
	titre			text 		NOT NULL,	-- Nom du document UNIQUE
	description		text,
	reference_ressource 	text 		NOT NULL,
	disponibilite		text,				-- lieu de disponibilité ou chemin vers la ressource à afficher
	theme_ressource		text,				-- thèmes de la ressource
	auteurs			text,				-- tableau d'auteurs : format par défaut : prenom NOM
	editeur			text,
	ville_edition		text,

	date_debut_ressource	date,
	date_precision 		varchar(32),
	
	archive_ressource	boolean		DEFAULT false,	-- par défaut, tant que l'archive n'est pas validée elle est à TRUE
	validation		boolean		DEFAULT false, 	-- par défaut, la ressource n'est pas validée (validation = FALSE)

	mots_cles		text,				-- mots clé associés à la ressource

	date_creation   timestamp DEFAULT current_timestamp,	-- date de création de la ressource dans la base : date actuelle lors de l'ajout
	date_maj	timestamp[],								-- tableaux de dates de mise à jour dans la base
	last_modified	timestamp DEFAULT current_timestamp,	-- pour l'indexation de Solr : date de dernière modification

	UNIQUE(titre),
	sous_categorie		text,				-- préciser ici le type de la ressource (éventuel)	
	pagination		integer		DEFAULT 0	 -- Nombre de pages total de la ressource

);

---------------------------------------------------------------
-- DOCUMENTATIONS
---------------------------------------------------------------
DROP TABLE IF EXISTS documentation_specifique CASCADE;
CREATE TABLE documentation_specifique (
	documentation_specifique_id	serial NOT NULL,
	objet_id			serial NOT NULL,
	ressource_specifique_id		serial NOT NULL

);

DROP TABLE IF EXISTS documentation_graphique CASCADE;
CREATE TABLE documentation_graphique (
	documentation_graphique_id	serial NOT NULL,
	objet_id			serial NOT NULL,
	ressource_graphique_id		serial NOT NULL,
	page_consultee			text

);

DROP TABLE IF EXISTS documentation_video CASCADE;
CREATE TABLE documentation_video (
	documentation_video_id		serial NOT NULL,
	objet_id			serial NOT NULL,
	ressource_video_id		serial NOT NULL

);

DROP TABLE IF EXISTS documentation_textuelle CASCADE;
CREATE TABLE documentation_textuelle (
	documentation_textuelle_id	serial NOT NULL,
	objet_id			serial NOT NULL,
	ressource_textuelle_id		serial NOT NULL,
	page_consultee			text

);

---------------------------------------------------------------
-- OBJET
---------------------------------------------------------------
DROP TABLE IF EXISTS objet CASCADE;
CREATE TABLE objet (
	objet_id		serial		NOT NULL,
	username		varchar(32)	,
	
	nom_objet 		text		NOT NULL UNIQUE,
	resume			text,
	historique		text,
	description		text,
	adresse_postale		text,

	validation 	boolean		DEFAULT false,
	archive_objet	boolean		DEFAULT false,
					
	mots_cles	text,
	date_creation   timestamp 	DEFAULT current_timestamp,	
	date_maj	timestamp[],

	last_modified	timestamp 	DEFAULT current_timestamp,
	
	geom_maquette 	text,
	
	UNIQUE(nom_objet)

);

---------------------------------------------------------------
-- TEMPORAL GEOMETRY
---------------------------------------------------------------
DROP TABLE IF EXISTS temp_geom CASCADE;
CREATE TABLE temp_geom (
	geom_id			serial		NOT NULL,
	objet_id		serial     	NOT NULL,
	username		varchar(32)	NOT NULL,
	
	the_geom		geometry,

	date_debut_geom 	date,
	date_fin_geom		date,
	date_precision 		varchar(32), 	-- Permet de renseigner la précision des valeurs date
	datation_indication_debut 	text, 	-- Renseigne un autre type de datation (à formater dans l'interface de saisie)
	datation_indication_fin 	text,

	validation 	boolean		DEFAULT false,
	archive_objet	boolean		DEFAULT false,
					
	mots_cles	text,
	date_creation   timestamp 	DEFAULT current_timestamp,	
	date_maj	timestamp[],

	last_modified	timestamp 	DEFAULT current_timestamp
);


---------------------------------------------------------------
-- RELATION (à affiner)
---------------------------------------------------------------
DROP TABLE IF EXISTS relation CASCADE;
CREATE TABLE relation (
	relation_id	 	serial 		NOT NULL,
	objet_id_1		serial		NOT NULL,
	objet_id_2		serial		NOT NULL,
	type_relation_id	serial		NOT NULL,
	username		varchar(32) 	NOT NULL,

	date_debut_relation 	date,
	date_fin_relation	date,
	date_precision varchar(32), -- Permet de renseigner la précision des valeurs date
	datation_indication_debut text, -- Renseigne un autre type de datation (à formater dans l'interface de saisie)
	datation_indication_fin text,
	
	parent 			boolean		NULL,		-- False => relation réflexive, True => source = parent
	
	date_creation   timestamp DEFAULT current_timestamp, 
	last_modified	timestamp DEFAULT current_timestamp


);

---------------------------------------------------------------
-- TYPE RELATION
---------------------------------------------------------------
DROP TABLE IF EXISTS type_relation CASCADE;
CREATE TABLE type_relation (
	type_relation_id	serial	NOT NULL primary key,
	type_relation		varchar(32) NOT NULL,
	definition		text	NULL
	
	
);

INSERT INTO type_relation VALUES (1, 'A Definir', '');
INSERT INTO type_relation VALUES (2, 'Direct', '');
INSERT INTO type_relation VALUES (3, 'Indirect', '');


---------------------------------------------------------------
-- PROPOSITION
-- Permet de gérer la modération pour les contributions externes
-- La gestion des ajouts est gérée via l'application web et l'attribut "validation" des tables «objet» et «ressource»
-- La gestion des modifications et suppressions est gérée via ces tables
---------------------------------------------------------------


-- Supprime en même temps les tables héritées
DROP TABLE IF EXISTS proposition CASCADE;

-- Création de la table
CREATE TABLE proposition(
	        proposition_id         	serial 		NOT NULL,
		username        	varchar(32)     NOT NULL,       -- créateur de la ressource : NOT NULL -1 par défaut
		en_attente		integer
);


-- Supprime en même temps les tables héritées
DROP TABLE IF EXISTS proposition_retire CASCADE;

-- Création de la table 
CREATE TABLE proposition_retire(

	        nom_table 	text 	NOT NULL,
	        donne_id 	integer NOT NULL       	-- id de tuple a supprimer

)INHERITS (proposition);


-- Supprime en même temps les tables héritées
DROP TABLE IF EXISTS proposition_modifie CASCADE;

-- Création de la table 
CREATE TABLE proposition_modifie(

	        nom_table 	text	 NOT NULL,
	        donnee_id       integer  NOT NULL,   	-- id de tuple a modifier
	        modifications	text 			-- tableau "serialize" contenant les modifs 
		
) INHERITS (proposition);

---------------------------------------------------------------
-- USERS
---------------------------------------------------------------

DROP TABLE IF EXISTS users CASCADE;
					
--Le mot de passe de l'utilisateur doit pouvoir être assez long pour supporter un hashage de type blowfish
CREATE TABLE users (

	username 	varchar(32),
	userid 	varchar(32),
	password 	varchar(128),
	user_level	int 	NOT NULL,
	timestamp 	int 	NOT NULL,

	nom 		text 	NOT NULL,
	prenom 		text 	NOT NULL,
	adresse_postale 	text,
	email 		varchar(50),
	telephone 	varchar(32),
	profession 	text,
         
	UNIQUE(username)
);


---------------------------------------------------------------
-- USER LEVEL
---------------------------------------------------------------

DROP TABLE IF EXISTS Userlevel;

CREATE TABLE Userlevel (


	 user_level int primary key,
	 type text not null

);

INSERT INTO Userlevel values(0, 'non valide'); --valeur par défaut, sera remplacé par 1-visiteur sur validation par email

INSERT INTO Userlevel values(1, 'Visiteur');

INSERT INTO Userlevel values(3, 'Informateur');

INSERT INTO Userlevel values(4, 'Chercheur');

INSERT INTO Userlevel values(5, 'Moderateur');

INSERT INTO Userlevel values(9, 'Administrateur');

INSERT INTO Userlevel values(10, 'Super Administrateur');

INSERT INTO Userlevel values(-1, 'Banni'); --valeur spéciale pour invalider un utilisateur et l'empêcher de se connecter

--------------------------------------------------------------------------------------------------------------------------
--Cet utilisateur est le super administrateur, c'est à partir de ce compte qu'on peut créer les comptes administrateurs
--Le mot de passe fourni a été généré via le site puis récupéré dans la base, il s'agit de NantesChatBateau
--Penser à mettre à jour les données personnelles selon qui l'utilise
--------------------------------------------------------------------------------------------------------------------------

INSERT INTO users VALUES ('Nantes1900', '0', '795a3674efd1d6455c028d1f15fb422325fbb77f', '10', '0','-', '-', '-','ee@ee.fr','','');


DROP TABLE IF EXISTS active_users;

CREATE TABLE active_users (
 username varchar(32) primary key,
 timestamp int not null
);

DROP TABLE IF EXISTS active_guests;

CREATE TABLE active_guests (
 ip varchar(15) primary key,
 timestamp int not null
);

DROP TABLE IF EXISTS banned_users;

CREATE TABLE banned_users (
	 username varchar(32) primary key,
	 timestamp int not null
);


---------------------------------------------------------------
-- Creation d'une table ci_sessions pour la prise en charge des sessions par CodeIgniter
---------------------------------------------------------------

CREATE TABLE ci_sessions (
    session_id character varying(40) DEFAULT '0'::character varying NOT NULL,
    ip_address character varying(16) DEFAULT '0'::character varying NOT NULL,
    user_agent character varying(150) NOT NULL,
    last_activity integer DEFAULT 0 NOT NULL,
    user_data text NOT NULL
);

---------------------------------------------------------------
-- AJOUT DE CONTRAINTES
---------------------------------------------------------------

-- CLE PRIMAIRE --
ALTER TABLE ONLY ci_sessions
    	ADD CONSTRAINT ci_sessions_pkey PRIMARY KEY (session_id);

ALTER TABLE ressource_specifique
	ADD CONSTRAINT pk_ressource_specifique PRIMARY KEY (ressource_specifique_id);

ALTER TABLE ressource_graphique
	ADD CONSTRAINT pk_ressource_graphique PRIMARY KEY (ressource_graphique_id);

ALTER TABLE ressource_video
	ADD CONSTRAINT pk_ressource_video PRIMARY KEY (ressource_video_id);

ALTER TABLE ressource_textuelle
	ADD CONSTRAINT pk_ressource_textuelle PRIMARY KEY (ressource_textuelle_id);

ALTER TABLE objet
	ADD CONSTRAINT pk_objet PRIMARY KEY (objet_id);
	
ALTER TABLE temp_geom
	ADD CONSTRAINT pk_temp_geom PRIMARY KEY (geom_id);

ALTER TABLE relation
	ADD CONSTRAINT pk_relation PRIMARY KEY (relation_id);

ALTER TABLE proposition
	ADD CONSTRAINT pk_proposition PRIMARY KEY (proposition_id);

ALTER TABLE documentation_textuelle
	ADD CONSTRAINT pk_documentationTextuelle PRIMARY KEY (documentation_textuelle_id);

ALTER TABLE documentation_graphique
	ADD CONSTRAINT pk_documentationGraphique PRIMARY KEY (documentation_graphique_id);

ALTER TABLE documentation_video
	ADD CONSTRAINT pk_documentationVideo PRIMARY KEY (documentation_video_id);

ALTER TABLE documentation_specifique
	ADD CONSTRAINT pk_documentationSpecifique PRIMARY KEY (documentation_specifique_id);

ALTER TABLE users
	ADD CONSTRAINT pk_users PRIMARY KEY (username);

-- CLE ETRANGERE --
ALTER TABLE ressource_specifique
	ADD CONSTRAINT fk_createurRessourceSpecifique FOREIGN KEY (username) 
	REFERENCES users(username) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE ressource_graphique
	ADD CONSTRAINT fk_createurRessourceGraphique FOREIGN KEY (username) 
	REFERENCES users(username) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE ressource_video
	ADD CONSTRAINT fk_createurRessourceVideo FOREIGN KEY (username) 
	REFERENCES users(username) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE ressource_textuelle
	ADD CONSTRAINT fk_createurRessourceTextuelle FOREIGN KEY (username) 
	REFERENCES users(username) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE objet
	ADD CONSTRAINT fk_createurObjet FOREIGN KEY (username) 
	REFERENCES users(username) ON DELETE SET NULL ON UPDATE CASCADE;
	
ALTER TABLE temp_geom
	ADD CONSTRAINT fk_createurGeom FOREIGN KEY (username)
	REFERENCES users(username) ON DELETE CASCADE ON UPDATE CASCADE;
	
ALTER TABLE temp_geom
	ADD CONSTRAINT fk_objetGeom FOREIGN KEY (objet_id)
	REFERENCES objet(objet_id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE relation
	ADD CONSTRAINT fk_objet1 FOREIGN KEY (objet_id_1)
	REFERENCES objet(objet_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE relation
	ADD CONSTRAINT fk_objet2 FOREIGN KEY (objet_id_2)
	REFERENCES objet(objet_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE relation
	ADD CONSTRAINT fk_typeRelation FOREIGN KEY (type_relation_id)
	REFERENCES type_relation(type_relation_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE users
	ADD CONSTRAINT fk_userLevel FOREIGN KEY (user_level)
	REFERENCES Userlevel(user_level) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE proposition
	ADD CONSTRAINT fk_createurProposition FOREIGN KEY (username)
	REFERENCES users(username) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_textuelle
	ADD CONSTRAINT fk_objetDocumenteTextuelle FOREIGN KEY (objet_id)
	REFERENCES objet(objet_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_textuelle
	ADD CONSTRAINT fk_ressourceDocumenteTextuelle FOREIGN KEY (ressource_textuelle_id)
	REFERENCES ressource_textuelle(ressource_textuelle_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_graphique
	ADD CONSTRAINT fk_objetDocumenteGraphique FOREIGN KEY (objet_id)
	REFERENCES objet(objet_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_graphique
	ADD CONSTRAINT fk_ressourceDocumenteGraphique FOREIGN KEY (ressource_graphique_id)
	REFERENCES ressource_graphique(ressource_graphique_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_video
	ADD CONSTRAINT fk_objetDocumenteVideo FOREIGN KEY (objet_id)
	REFERENCES objet(objet_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_Video
	ADD CONSTRAINT fk_ressourceDocumenteVideo FOREIGN KEY (ressource_video_id)
	REFERENCES ressource_video(ressource_video_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_specifique
	ADD CONSTRAINT fk_objetDocumenteSpecifique FOREIGN KEY (objet_id)
	REFERENCES objet(objet_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE documentation_specifique
	ADD CONSTRAINT fk_ressourceDocumenteSpecifique FOREIGN KEY (ressource_specifique_id)
	REFERENCES ressource_specifique(ressource_specifique_id) ON DELETE CASCADE ON UPDATE CASCADE;


-- CONTRAINTES D INTEGRITE --

ALTER TABLE temp_geom
ADD CONSTRAINT verif_dates CHECK ( CASE WHEN (date_fin_geom <> NULL) THEN date_debut_geom <= date_fin_geom END);





