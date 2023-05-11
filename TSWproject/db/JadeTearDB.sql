DROP DATABASE IF EXISTS JadeTear;
CREATE DATABASE JadeTear;
USE JadeTear;

CREATE TABLE Prodotto
(	
	id_prodotto int primary key AUTO_INCREMENT,
	nome varchar(50) not null, 
	categoria varchar(20) not null,
	pietra varchar(20) not null,
	immagine varchar(100) not null,
	disponibilita int not null,
	IVA float not null,
	prezzo float not null,
	descrizione varchar(100) not null,
	materiale varchar(20) not null,
	sconto int not null,
		check (sconto >= 0 and sconto < 100),
	personalizzato boolean not null
);

INSERT INTO Prodotto values (1,"Anello di Rugiada", "Anello", "Giada", "AnelloRugiada.jpeg", 3, 22, 80, "Anello la cui pietra &egrave assimilabile ad una goccia di rugiada", "Argento", 0, false);
INSERT INTO Prodotto values (2, "Collana del Cristallo dell'Ira", "Collana", "Rubino", "collanadira.jpg", 1, 22, 140, "Collana uscita da un libro fantasy, per essere pi&ugrave chic", "Argento", 0, false);

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
    cap varchar(5) not null,
    telefono varchar(12) not null,
    email varchar(30) unique not null
);

INSERT INTO Cliente values("JadeTear", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "TREJDA97H59D615D", "Jade", "Tear", "via Roma 69", "Fisciano", "SA", "84084", "391234567890", "JadeTear@gmail.com");

CREATE TABLE Ordine
(
	id int primary key AUTO_INCREMENT,
    username varchar(20) not null,
    prezzo_totale float not null,
    destinatario varchar(50) not null,
    metodo_di_pagamento varchar(20),
    indirizzo_di_spedizione varchar(50) not null,
    numero_di_tracking varchar(40) not null,
    note varchar(100),
    data date not null,
    sconto int not null, 
    check (sconto >= 0 and sconto < 100),
    metodo_di_spedizione varchar(20) not null,
    confezione_regalo boolean not null,
    foreign key(username) references Cliente(username)
		on update cascade
		on delete restrict
);

CREATE TABLE Fattura
(
	sdi varchar(8) primary key,
    importo float not null,
    data_scadenza date not null,
    data_emissione date not null,
    stato_del_pagamento varchar(15),
    check (stato_del_pagamento = 'pagato' or stato_del_pagamento = 'non pagato'),
    IVA float not null,
    id int not null,
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
	id int not null AUTO_INCREMENT,
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
