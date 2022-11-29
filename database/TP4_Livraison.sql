-- Active: 1668645566760@@127.0.0.1@5432@TP4_Livraison
DROP SCHEMA IF EXISTS TP4DB CASCADE;
CREATE SCHEMA TP4DB;
CREATE TABLE IF NOT EXISTS  TP4DB.Client (
		numeroClient		VARCHAR(50)		NOT NULL,
		nomClient 			VARCHAR(50)		NOT NULL,
		prenomClient		VARCHAR(50)		NOT NULL,
		courrielClient		VARCHAR(100)	NOT NULL,
		rueClient 			VARCHAR(100)	NOT NULL,
		villeClient 		VARCHAR(100)	NOT NULL,
		codepostalClient 	VARCHAR(10)		NOT NULL,
		PRIMARY KEY (numeroClient));

CREATE TABLE IF NOT EXISTS  TP4DB.Telephone (
		numeroClient		VARCHAR(50)		NOT NULL,
		numeroTelephone 	VARCHAR(20)		NOT NULL,
		PRIMARY KEY (numeroClient,numeroTelephone),
		FOREIGN KEY (numeroClient) REFERENCES TP4DB.Client ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Fournisseur (
		numeroFournisseur		VARCHAR(50)		NOT NULL,
		nomFournisseur		 	VARCHAR(50)		,
		adresseFournisseur		VARCHAR(255)	NOT NULL,
		PRIMARY KEY (numeroFournisseur));

CREATE TABLE IF NOT EXISTS  TP4DB.PlanRepas (
		numeroPlan			VARCHAR(50)		NOT NULL,
		categorie 			VARCHAR(20)		NOT NULL,
		frequence 			INTEGER			NOT NULL,
		nbrpersonnes 		INTEGER			NOT NULL,
		nbcalories 			INTEGER			NOT NULL,
		prix 				DECIMAL(7,2)	NOT NULL,
		numeroFournisseur 	VARCHAR(50)	    NOT NULL,
		PRIMARY KEY (numeroPlan),
		FOREIGN KEY (numeroFournisseur) REFERENCES TP4DB.Fournisseur ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Abonner (
		numeroClient		VARCHAR(50)		NOT NULL,
		numeroPlan		 	VARCHAR(50)		NOT NULL,
		duree		 		VARCHAR(255)	NOT NULL,
		PRIMARY KEY (numeroClient,numeroPlan),
		FOREIGN KEY (numeroClient) REFERENCES TP4DB.Client ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.PlanRepas ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Famille (
		numeroPlan			VARCHAR(50)		NOT NULL,
		PRIMARY KEY (numeroPlan),
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.PlanRepas ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Vegetarien (
		numeroPlan			VARCHAR(50)		NOT NULL,
		typeRepas			VARCHAR(255)	NOT NULL,
		PRIMARY KEY (numeroPlan),
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.PlanRepas ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Pescetarien (
		numeroPlan			VARCHAR(50)		NOT NULL,
		typePoisson			VARCHAR(255)	NOT NULL,
		PRIMARY KEY (numeroPlan),
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.PlanRepas ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Rapide (
		numeroPlan			VARCHAR(50)		NOT NULL,
		tempsPreparation	VARCHAR(255)	NOT NULL,
		PRIMARY KEY (numeroPlan),
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.Famille ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Facile (
		numeroPlan			VARCHAR(50)		NOT NULL,
		nbIngredients		INTEGER			NOT NULL,
		PRIMARY KEY (numeroPlan),
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.Famille ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.KitRepas (
		numeroKitRepas		VARCHAR(50)		NOT NULL,
		description			VARCHAR(255)	NOT NULL,
		numeroPlan			VARCHAR(50)		NOT NULL,
		PRIMARY KEY (numeroKitRepas),
		FOREIGN KEY (numeroPlan) REFERENCES TP4DB.PlanRepas ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Image (
		numeroImage			VARCHAR(50)		NOT NULL,
		données				VARCHAR(255)	NOT NULL,
		numeroKitRepas		VARCHAR(50)		NOT NULL,
		PRIMARY KEY (numeroImage),
		FOREIGN KEY (numeroKitRepas) REFERENCES TP4DB.KitRepas ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS  TP4DB.Etape (
		numeroKitRepas					VARCHAR(50)		NOT NULL,
		descriptionEtape				VARCHAR(255)	NOT NULL,
		dureeEtape						VARCHAR(255)	NOT NULL,
		numeroKitRepasetrecomposeede	VARCHAR(50)		NOT NULL,
		PRIMARY KEY (numeroKitRepas),
		FOREIGN KEY (numeroKitRepas) REFERENCES TP4DB.KitRepas ON UPDATE CASCADE ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS  TP4DB.Ingredient (
		numeroIngredient			VARCHAR(50)		NOT NULL,
		nomIngredient				VARCHAR(100)	NOT NULL,
		paysIngredient				VARCHAR(100)	NOT NULL,
		PRIMARY KEY (numeroIngredient));
CREATE TABLE IF NOT EXISTS  TP4DB.Contenir (
		numeroKitRepas				VARCHAR(50)		NOT NULL,
		numeroIngredient			VARCHAR(50)		NOT NULL,
		PRIMARY KEY (numeroKitRepas,numeroIngredient),
		FOREIGN KEY (numeroKitRepas) REFERENCES TP4DB.KitRepas ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (numeroIngredient) REFERENCES TP4DB.Ingredient ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO TP4DB.Client VALUES (1, 'El Asri', 'Yassine', 'yassineelasri@outlook.com', 'Rue Raymond', 'Laval', 'H7N 5S5');
INSERT INTO TP4DB.Client VALUES (2, 'Masti', 'Yasmine', 'yasminemasti@outlook.com', 'Rue Chatone', 'Montréal', 'H7X 5M5'); 
INSERT INTO TP4DB.Client VALUES (3, 'Merrachi', 'Nabil', 'nabilmerrachi@outlook.com', 'Rue Marc', 'Laval', 'H7V 9M5'); 
INSERT INTO TP4DB.Client VALUES (4, 'LouLou', 'Branche', 'brancheloulou@outlook.com', 'Rue Lavoisier', 'Laval', 'H7P 9M5'); 
INSERT INTO TP4DB.Client VALUES (5, 'Amine', 'Fahmi', 'aminefahmi@outlook.com', 'Rue Gloc', 'Lorraine', 'H7P 9R5'); 

INSERT INTO TP4DB.Telephone VALUES (1 , '514-912-9335'); 
INSERT INTO TP4DB.Telephone VALUES (3 , '514-998-9234'); 
INSERT INTO TP4DB.Telephone VALUES (5 , '514-515-8072'); 

INSERT INTO TP4DB.Fournisseur VALUES (1 , 'Costco Co.', '328 Boul. Saint-Martin, Laval, QC'); 
INSERT INTO TP4DB.Fournisseur VALUES (2 , 'Walmart Co.', '3299 Boul. Curé-Labelle, Laval, QC'); 
INSERT INTO TP4DB.Fournisseur VALUES (3 , 'AB Transport', '3222 Boul. Curé-Labelle, Laval, QC');
INSERT INTO TP4DB.Fournisseur VALUES (4 , 'Benjamin', 'Laval');
INSERT INTO TP4DB.Fournisseur (numeroFournisseur, adresseFournisseur) VALUES (5, '123 Rue Civic, Laval, QC');
INSERT INTO TP4DB.Fournisseur VALUES (6 , 'Aubut', 'Montréal');

INSERT INTO TP4DB.PlanRepas VALUES (1, 'marocain', 2, 2, 1200, 29.99, 1); 
INSERT INTO TP4DB.PlanRepas VALUES (2, 'haitien',  4, 1, 1100, 17.99, 3); 
INSERT INTO TP4DB.PlanRepas VALUES (3, 'mexicanoss', 8, 3, 800 , 21.00, 2); 
INSERT INTO TP4DB.PlanRepas VALUES (4, 'cétogène', 9, 4, 800 , 21.00, 1); 
INSERT INTO TP4DB.PlanRepas VALUES (5, 'mexicanoss', 10, 2, 1900 , 12600, 6);
INSERT INTO TP4DB.PlanRepas VALUES (6, 'kurdeous', 11, 6, 300, 400, 6); 
INSERT INTO TP4DB.PlanRepas VALUES (7, 'mexicanoss', 7, 9, 1000 , 13000, 2);


INSERT INTO TP4DB.Abonner VALUES (1, 1, '5 semaines'); 
INSERT INTO TP4DB.Abonner VALUES (3, 2, '4 ans'); 

INSERT INTO TP4DB.Famille VALUES (2); 
INSERT INTO TP4DB.Famille VALUES (3); 
INSERT INTO TP4DB.Famille VALUES (4); 

INSERT INTO TP4DB.Vegetarien VALUES (2, 'Pizza aux légumes rouges Haiti'); 
INSERT INTO TP4DB.Vegetarien VALUES (3, 'Salade de chou exotique jaco'); 

INSERT INTO TP4DB.Pescetarien VALUES (1, 'Spaghetti morue de Casablanca'); 
INSERT INTO TP4DB.Pescetarien VALUES (3, 'Sandwich aux fruits de mer Cancun'); 

INSERT INTO TP4DB.Rapide VALUES (2, '30 minutes'); 
INSERT INTO TP4DB.Rapide VALUES (3, '5 minutes'); 

INSERT INTO TP4DB.Facile VALUES (2, 25); 
INSERT INTO TP4DB.Facile VALUES (3, 50); 

INSERT INTO TP4DB.KitRepas VALUES (1, 'Le kit repas du gentil', 2); 
INSERT INTO TP4DB.KitRepas VALUES (2, 'Le kit repas monstrueseuemnt monstureux', 3); 
INSERT INTO TP4DB.KitRepas VALUES (3, 'Le kit de Nabil', 3); 


INSERT INTO TP4DB.Image VALUES (1, 'Image de la grande', 1); 
INSERT INTO TP4DB.Image VALUES (2, 'Image de la petite', 2); 

INSERT INTO TP4DB.Etape VALUES (1, 'Cuir la patte', '12 minutes', 2); 
INSERT INTO TP4DB.Etape VALUES (2, 'Mettre dans le four à 200 degrés celsius', '28 secondes' , 2); 

INSERT INTO TP4DB.Ingredient VALUES (1, 'Tomate', 'Mexique'); 
INSERT INTO TP4DB.Ingredient VALUES (2, 'Oignons NRV', 'Haiti'); 
INSERT INTO TP4DB.Ingredient VALUES (3, 'Carotte', 'Haiti'); 
INSERT INTO TP4DB.Ingredient VALUES (4, 'Piment', 'Haiti'); 
INSERT INTO TP4DB.Ingredient VALUES (5, 'Orange', 'Hongri'); 

INSERT INTO TP4DB.Contenir VALUES (1, 2); 
INSERT INTO TP4DB.Contenir VALUES (2, 1);