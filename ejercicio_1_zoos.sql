CREATE SEQUENCE IF NOT EXISTS id_lugar_seq AS INT INCREMENT 1 START 1;

CREATE TABLE IF NOT EXISTS public."Lugar"(
	id INT PRIMARY KEY,
	ciudad VARCHAR UNIQUE NOT NULL,
	pais VARCHAR NOT NULL,
	continente VARCHAR NOT NULL	
);

CREATE SEQUENCE IF NOT EXISTS id_zoo_seq AS INT INCREMENT 1 START 1;

CREATE TABLE IF NOT EXISTS public."Zoo"(
	id INT PRIMARY KEY,
	lugar_id INT NOT NULL,
	nombre VARCHAR UNIQUE NOT NULL,
	tamano NUMERIC NOT NULL,
	presupuesto NUMERIC NOT NULL,
	CONSTRAINT zoo_lugar_fk FOREIGN KEY (lugar_id) REFERENCES public."Lugar"(id)
);

CREATE SEQUENCE IF NOT EXISTS id_animal_seq AS INT INCREMENT 1 START 1;

CREATE TABLE IF NOT EXISTS public."Animal"(
	id INT PRIMARY KEY,
	id_zoo INT NOT NULL,
	CONSTRAINT animal_zoo_fk FOREIGN KEY (id_zoo) REFERENCES public."Zoo"(id)
);

CREATE SEQUENCE IF NOT EXISTS id_especie_seq AS INT INCREMENT 1 START 1;

CREATE TABLE IF NOT EXISTS public."Especie"(
	id INT PRIMARY KEY,
	nom_vulgar VARCHAR UNIQUE NOT NULL,
	nom_cient VARCHAR UNIQUE NOT NULL,
	familia VARCHAR NOT NULL,
	peligro_ext BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS public."DetalleAnimal"(
	id_animal INT NOT NULL,
	id_lugar INT NOT NULL,
	id_especie INT NOT NULL,
	ano_nacimiento DATE,
	CONSTRAINT detalle_animal_fk FOREIGN KEY (id_animal) REFERENCES public."Animal"(id),
	CONSTRAINT detalle_lugar_fk FOREIGN KEY (id_lugar) REFERENCES public."Lugar"(id),
	CONSTRAINT detalle_especie_fk FOREIGN KEY (id_especie) REFERENCES public."Especie"(id),
	CONSTRAINT detalle_pk PRIMARY KEY (id_animal)
);

-- INSERT INTO public."Lugar" VALUES (nextval('id_lugar_seq'),'Madrid','España','Europa');
-- INSERT INTO public."Lugar" VALUES (nextval('id_lugar_seq'),'Nueva York','EEUU','América');
-- INSERT INTO public."Lugar" VALUES (nextval('id_lugar_seq'),'Logroño','España','Europa');
-- INSERT INTO public."Lugar" VALUES (nextval('id_lugar_seq'),'Lafia','Nigeria','Africa');
-- INSERT INTO public."Lugar" VALUES (nextval('id_lugar_seq'),'Antananarivo','Madagascar','Africa');

-- SELECT * FROM public."Lugar";

-- INSERT INTO public."Zoo" VALUES (nextval('id_zoo_seq'),1,'Zoo Madrid',12345,12345);
-- INSERT INTO public."Zoo" VALUES (nextval('id_zoo_seq'),2,'Central Park Zoo',54321,54321);
-- INSERT INTO public."Zoo" VALUES (nextval('id_zoo_seq'),3,'LogroZoo',333333,333333);

-- SELECT * FROM public."Zoo";

-- INSERT INTO public."Animal" VALUES (nextval('id_animal_seq'),3);

-- SELECT * FROM public."Animal"; -- Tenemos 9 animales

-- INSERT INTO public."Especie" VALUES (nextval('id_especie_seq'),'Rinoceronte negro','Diceros Bicornis','Rhinocerontidae',True);
-- INSERT INTO public."Especie" VALUES (nextval('id_especie_seq'),'Lemur marrón ratón','Microcebus rufus','Cheirogaleidae',True);
-- INSERT INTO public."Especie" VALUES (nextval('id_especie_seq'),'Flamenco común','Phoenicopterus roseus','Phoenicopteridae',False);

-- SELECT * FROM public."Especie";  -- Tenemos 3 especies

-- 3 Lemures en Madrid
-- INSERT INTO public."DetalleAnimal" VALUES (1,1,2,'10/03/2023');
-- INSERT INTO public."DetalleAnimal" VALUES (2,1,2,'13/03/2023');
-- INSERT INTO public."DetalleAnimal" VALUES (3,1,2,'16/03/2023');

-- 3 Rinos en Nueva York
-- INSERT INTO public."DetalleAnimal" VALUES (4,2,1,'10/02/2023');
-- INSERT INTO public."DetalleAnimal" VALUES (5,2,1,'13/02/2023');
-- INSERT INTO public."DetalleAnimal" VALUES (6,2,1,'16/02/2023');

-- 3 Flamencos en Logroño
-- INSERT INTO public."DetalleAnimal" VALUES (7,3,3,'10/01/2023');
-- INSERT INTO public."DetalleAnimal" VALUES (8,3,3,'13/01/2023');
-- INSERT INTO public."DetalleAnimal" VALUES (9,3,3,'16/01/2023');

SELECT * FROM public."DetalleAnimal"

