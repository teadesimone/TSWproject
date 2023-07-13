DROP DATABASE IF EXISTS JadeTear;
CREATE DATABASE JadeTear;
USE JadeTear;

CREATE TABLE Prodotto
(	
	id_prodotto int primary key AUTO_INCREMENT,
	nome varchar(50) not null, 
	categoria ENUM('Necklace', 'Ring', 'Bracelet', 'Earrings') not null,
	pietra ENUM('Jade', 'Amethyst', 'Rose Quarz', 'Ruby', 'Emerald', 'Aquamarine') not null,
	immagine varchar(100) not null,
	disponibilita int not null,
	IVA float not null,
	prezzo float not null,
	descrizione varchar(100) not null,
	materiale ENUM('Gold', 'Silver', 'Rose Gold') not null,
	sconto int not null,
		check (sconto >= 0 and sconto < 100),
	personalizzato boolean not null
);

INSERT INTO Prodotto values (1,"Anello di Rugiada", "Ring", "Jade", "AnelloRugiada.jpeg", 10, 22, 80, "Anello di Rugiada - Anello la cui pietra &egrave assimilabile ad una goccia di rugiada", "Silver", 0, false);
INSERT INTO Prodotto values (2, "Collana del Cristallo dell Ira", "Necklace", "Ruby", "collanadira.jpg", 10, 22, 140, "Collana del Cristallo dell Ira - Collana uscita da un libro fantasy, per essere pi&ugrave chic", "Silver", 0, false);

CREATE TABLE Cliente
(
	username varchar(20) primary key,
	psw varchar(50) not null, 
    cf varchar(16) not null, 
    nome varchar(30) not null,
    cognome varchar(30) not null,
    via varchar(50) not null,
    citta varchar(40) not null,
    provincia varchar(40) not null,
    cap varchar(8) not null,
    telefono varchar(12) not null,
    email varchar(30) unique not null
);

INSERT INTO Cliente values("JadeTear", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "TREJDA97H59D615D", "Jade", "Tear", "via Roma 69", "Fisciano", "SA", "84084", "391234567890", "JadeTear@gmail.com");
INSERT INTO Cliente values("Ciro05", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "OOOOOOOOOO", "Ciro", "Esposito", "via Rome 69", "Ottaviano", "NA", "00000", "0000000000", "prova@gmail.com");
INSERT INTO Cliente values("Cira05", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "OOOOOOOOOO", "Cira", "Esposito", "via Gennaro 69", "Ottaviano", "NA", "00000", "0000000000", "prova2@gmail.com");

CREATE TABLE Indirizzo
(
	id int AUTO_INCREMENT not null PRIMARY KEY,
    via varchar(50) not null,
    citta varchar(40) not null,
    cap varchar(8) not null,
    username varchar(20) not null,
    foreign key(username) references Cliente(username)
		on update cascade
		on delete restrict
);

INSERT INTO Indirizzo values(1, "via Roma 69", "Ottaviano", "80044", "Ciro05");
INSERT INTO Indirizzo values(2, "via Ciro 27", "Napoli", "00000", "Ciro05");

CREATE TABLE Metodo_di_pagamento
(
	id int primary key AUTO_INCREMENT,
    numero_carta varchar(30) not null,
    cvv varchar(4) not null,
    data_scadenza varchar(15) not null,
    circuito varchar(20) not null,
    username varchar(20) not null,
    foreign key(username) references Cliente(username)
		on update cascade
		on delete restrict
);
   
   INSERT INTO Metodo_di_pagamento values(1, "123456789", "123", "2027-01-01", "mastercard", "Ciro05");
   INSERT INTO Metodo_di_pagamento values(2, "987654321", "321", "2067-01-01", "visa", "Ciro05");

CREATE TABLE Ordine
(
	id int primary key,
    username varchar(20) not null,
    prezzo_totale float not null,
    destinatario varchar(50) not null,
    metodo_di_pagamento varchar(20) not null,
    circuito varchar(20)not null,
    numero_carta varchar(30) not null,
    indirizzo_di_spedizione varchar(50) not null,
    numero_di_tracking varchar(40) not null,
    note varchar(100),
    data date not null,
    metodo_di_spedizione ENUM('Standard','Economic', 'Express') not null,
    confezione_regalo boolean not null,
    foreign key(username) references Cliente(username)
		on update cascade
		on delete restrict
);


CREATE TABLE Fattura
(
	sdi varchar(8) primary key,
    importo float not null,
    data_scadenza varchar(15) not null,
    data_emissione varchar(15) not null,
    stato_del_pagamento varchar(15),
    check (stato_del_pagamento = 'Paid' or stato_del_pagamento = 'Pending'),
    IVA float not null,
    id int unique not null,
    foreign key(id) references Ordine(id)
		on update cascade
		on delete restrict
);

CREATE TABLE Valutazione
(
	id int primary key AUTO_INCREMENT,
    username varchar(20) not null,
    voto int not null,
    check (voto > 0 and voto <=5),
    descrizione varchar(100),
    id_prodotto int not null,
    foreign key(username) references Cliente(username)
		on update cascade
		on delete restrict,
	foreign key(id_prodotto) references Prodotto(id_prodotto)
		on update cascade
		on delete cascade
);

CREATE TABLE Composizione
(
	id int not null,
    id_prodotto int not null,
    prezzo float not null,
    quantita int not null,
    IVA float not null,
    primary key(id, id_prodotto),
    foreign key(id) references Ordine(id)
		on update cascade
		on delete cascade,
	foreign key(id_prodotto) references Prodotto(id_prodotto)
		on update cascade
		on delete restrict
);


CREATE TABLE Wishlist
(
	username varchar(20) primary key,
    foreign key(username) references Cliente(username)
		on update cascade
		on delete cascade
);

CREATE TABLE Aggiunta
(
	username varchar(20) not null,
    id_prodotto int not null,
    note varchar(100),
    primary key(username, id_prodotto),
    foreign key(username) references Cliente(username)
		on update cascade
		on delete cascade,
	foreign key(id_prodotto) references Prodotto(id_prodotto)
		on update cascade
		on delete cascade
);
