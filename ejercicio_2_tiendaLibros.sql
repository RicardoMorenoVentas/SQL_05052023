CREATE SEQUENCE IF NOT EXISTS id_provincia_seq INCREMENT 1 START 1;
CREATE SEQUENCE IF NOT EXISTS id_poblacion_seq INCREMENT 1 START 1;
CREATE SEQUENCE IF NOT EXISTS id_socio_seq INCREMENT 1 START 1;
CREATE SEQUENCE IF NOT EXISTS id_pedido_seq INCREMENT 1 START 1;
CREATE SEQUENCE IF NOT EXISTS id_almacen_seq INCREMENT 1 START 1;
CREATE SEQUENCE IF NOT EXISTS id_coleccion_seq INCREMENT 1 START 1;

CREATE TABLE IF NOT EXISTS public."Coleccion"(
	id INT PRIMARY KEY,
	volumen INT UNIQUE
);

CREATE TABLE IF NOT EXISTS public."Libro"(
	ISBN VARCHAR PRIMARY KEY,
	idColeccion INT,
	titulo VARCHAR UNIQUE NOT NULL,
	autor VARCHAR NOT NULL,
	editorial VARCHAR NOT NULL,
	CONSTRAINT libro_coleccion_fk FOREIGN KEY (idColeccion) REFERENCES public."Coleccion"(id)
);

CREATE TABLE IF NOT EXISTS public."Provincia"(
	id INT PRIMARY KEY,
	nombre VARCHAR UNIQUE NOT NULL,
	terreno NUMERIC NOT NULL,
	idAlmacen INT
);

CREATE TABLE IF NOT EXISTS public."Almacen"(
	id INT PRIMARY KEY,
	idProvincia INT NOT NULL,
	direccion VARCHAR NOT NULL,
	fapertura DATE NOT NULL,
	CONSTRAINT almacen_prov_fk FOREIGN KEY (idProvincia) REFERENCES public."Provincia"(id)
);

ALTER TABLE public."Provincia" ADD CONSTRAINT prov_almacen_fk FOREIGN KEY (idAlmacen) REFERENCES public."Almacen"(id);

CREATE TABLE IF NOT EXISTS public."Poblacion"(
	id INT PRIMARY KEY,
	idProvincia INT NOT NULL,
	habitantes INT NOT NULL,
	nombre VARCHAR NOT NULL,
	CONSTRAINT pob_prov_fk FOREIGN KEY (idProvincia) REFERENCES public."Provincia"(id)
);

CREATE TABLE IF NOT EXISTS public."Socio"(
	id INT PRIMARY KEY,
	idSocioAvalador INT,
	idPoblacion INT NOT NULL,	
	DNI VARCHAR UNIQUE NOT NULL,
	nombre VARCHAR NOT NULL,
	apellidos VARCHAR NOT NULL,
	telefono INT NOT NULL,
	CONSTRAINT socio_aval_fk FOREIGN KEY (idSocioAvalador) REFERENCES public."Socio"(id),
	CONSTRAINT socio_pob_fk FOREIGN KEY (idPoblacion) REFERENCES public."Poblacion"(id)
);

CREATE TABLE IF NOT EXISTS public."Pedido"(
	id INT NOT NULL,
	idSocio INT NOT NULL,
	fEnvio VARCHAR NOT NULL,
	fPago VARCHAR NOT NULL,
	CONSTRAINT pedido_pk PRIMARY KEY (id, idSocio),
	CONSTRAINT pedido_socio_fk FOREIGN KEY (idSocio) REFERENCES public."Socio"(id)
);

CREATE TABLE IF NOT EXISTS public."DetallePedido"(
	id INT NOT NULL,
	idSocio INT NOT NULL,
	ISBN VARCHAR NOT NULL,
	cantidad INT NOT NULL,
	CONSTRAINT detalle_pk PRIMARY KEY (id, idSocio),
	CONSTRAINT detalle_pedido_fk FOREIGN KEY (id, idSocio) REFERENCES public."Pedido"(id, idSocio),
	CONSTRAINT detalle_libro_fk FOREIGN KEY (ISBN) REFERENCES public."Libro"(ISBN)
);

CREATE TABLE IF NOT EXISTS public."Stock"(
	id INT PRIMARY KEY,
	ISBN VARCHAR NOT NULL,
	cantidad INT NOT NULL,
	CONSTRAINT stock_almacen_fk FOREIGN KEY (id) REFERENCES public."Almacen"(id),
	CONSTRAINT stock_libro_fk FOREIGN KEY (ISBN) REFERENCES public."Libro"(ISBN)
);

INSERT INTO public."Coleccion" VALUES (nextval('id_coleccion_seq'),1515);
INSERT INTO public."Coleccion" VALUES (nextval('id_coleccion_seq'),1823);

SELECT * FROM public."Coleccion";

INSERT INTO public."Libro" VALUES ('QWERTY',1,'Cuando fue 1 + 1','El Fantástico Ralph','Anaya');
INSERT INTO public."Libro" VALUES ('ASDFGH',1,'Que fue de aquellas tardes','El Fantástico Ralph','Anaya');
INSERT INTO public."Libro" VALUES ('ZXCVBN',1,'Mi aliento huele a comida de gato','El Fantástico Ralph','Anaya');

-- SELECT * FROM public."Libro";

INSERT INTO public."Provincia" VALUES (nextval('id_provincia_seq'),'Murcia','12345');

-- SELECT * FROM public."Provincia";

INSERT INTO public."Almacen" VALUES (nextval('id_almacen_seq'),1,'C/ De los pies Ardientes','10/04/2003');

-- SELECT * FROM public."Almacen";

UPDATE public."Provincia" SET idAlmacen = 1 WHERE id = 1;

INSERT INTO public."Poblacion" VALUES (nextval('id_poblacion_seq'),1,1000,'Murcia');

INSERT INTO public."Socio" VALUES (nextval('id_socio_seq'),null,1,'1234Z','Pepito','Belmonte',123456789);

INSERT INTO public."Pedido" VALUES (nextval('id_pedido_seq'),1,'En burro','En Durums');

INSERT INTO public."DetallePedido" VALUES (1,1,'QWERTY',50);

INSERT INTO public."Stock" VALUES (1,'QWERTY',150);
 

