DROP DATABASE IF EXISTS JadeTear;
CREATE DATABASE JadeTear;
USE JadeTear;

CREATE TABLE Prodotto
(	
	id_prodotto int primary key AUTO_INCREMENT,
	nome varchar(50) not null, 
	categoria ENUM('Necklace', 'Ring', 'Bracelet', 'Earrings') not null,
	pietra ENUM('Jade', 'Amethyst', 'Rose Quarz', 'Quarz', 'Citrine', 'Aquamarine') not null,
	immagine varchar(100) not null,
	disponibilita int not null,
	IVA float not null,
	prezzo float not null,
	descrizione varchar(500) not null,
	materiale ENUM('Gold', 'Silver', 'Rose Gold') not null,
	sconto int not null,
		check (sconto >= 0 and sconto < 100),
	personalizzato boolean not null
);

INSERT INTO Prodotto values (1,"Rose Quarz Gold Ring", "Ring", "Rose Quarz", "anello_quarzorosa_oro.jpg", 10, 22, 60, "Embrace the essence of love and beauty with our exquisite Rose Quartz Gold Ring. The captivating blush-pink Rose Quartz gemstone, renowned for its association with compassion and harmony, takes center stage in this stunning piece. Nestled in a warm, lustrous gold setting, this ring exudes elegance and grace. It's a symbol of affectionate connections and an ideal accessory for both casual and special occasions.", "Gold", 0, false);
INSERT INTO Prodotto values (2, "Quarz Gold Earrings", "Earrings", "Quarz", "orecchini_quarzo_oro2.jpg", 10, 22, 80, "Radiate a timeless allure with our Quartz Gold Earrings. Crafted with care, these earrings feature a pair of enchanting Quartz gemstones known for their clarity and healing properties. The mesmerizing stones are delicately secured in a luxurious gold setting, adding a touch of sophistication to any ensemble. Elevate your style effortlessly and let these earrings be a conversation starter wherever you go.", "Gold", 0, false);
INSERT INTO Prodotto values (3,"Quarz Gold Ring", "Ring", "Quarz", "anello_quarzo_oro.jpg", 10, 22, 50, "Indulge in the mesmerizing charm of our Quartz Gold Ring. The entrancing Quartz gemstone, renowned for its versatility and positive energy, graces this ring in all its splendor. Set in a radiant gold band, the Quartz gem captures the light beautifully, reflecting its inner brilliance. An accessory that effortlessly combines elegance and positivity, making it an excellent addition to your jewelry collection.", "Gold", 0, false);
INSERT INTO Prodotto values (4,"Quarz Silver Ring", "Ring", "Quarz", "anello_quarzo_argento.jpg", 10, 22, 40, "Simplicity meets sophistication with our Quartz Silver Ring. The pure and pristine Quartz gemstone, known for its balancing properties and clarity, is the star of this design. Cradled in a sleek silver setting, the stone's natural beauty shines through, creating a harmonious and understated yet captivating piece. Embrace the calming essence of Quartz with this graceful ring.", "Silver", 0, false);
INSERT INTO Prodotto values (5,"Citrine Gold Ring", "Ring", "Citrine", "anello_citrino_oro2.jpg", 10, 22, 40, "Emanate joy and abundance with our Citrine Gold Ring. The vibrant Citrine gemstone, associated with positivity and success, takes center stage in this luxurious ring. Set in a warm, gleaming gold band, the Citrine gem sparkles with every movement, exuding an aura of optimism and confidence. Make a bold statement and let this Citrine ring illuminate your world.", "Gold", 0, false);
INSERT INTO Prodotto values (6,"Citrine Gold Ring", "Ring", "Citrine", "anello_citrino_oro3.jpg", 10, 22, 60, "Illuminate your world with the radiant glow of our Citrine Gold Ring. The vivacious Citrine gemstone, celebrated for its ability to attract prosperity and joy, takes center stage in this mesmerizing ring. Set in a lustrous gold band, the warm, sunny hues of Citrine beam with positivity, reminding you to embrace life's abundance with a beaming smile. Let this enchanting ring be a constant source of inspiration, encouraging you to chase your dreams fearlessly.", "Gold", 0, false);
INSERT INTO Prodotto values (7, "Jade Gold Necklace", "Necklace", "Jade", "collana_giada_oro.jpg", 10, 22, 150, "Channel the calming energies of nature with our Jade Gold Necklace. The smooth and serene Jade gemstone, revered for its protective and healing properties, is showcased in a delicate gold pendant. With its natural green hue symbolizing renewal and balance, this necklace adds a touch of tranquility to your everyday look, making it a meaningful and stylish accessory.",  "Gold", 0, false);
INSERT INTO Prodotto values (8,"Amethyst Silver Ring", "Ring", "Amethyst", "anello_ame_argento.jpg", 10, 22, 40, "Embrace the enchanting allure of our Amethyst Silver Ring. The captivating Amethyst gemstone, celebrated for its spiritual and calming properties, graces this ring with its rich purple hue. Set in a sleek silver band, the Amethyst gem creates a striking contrast and adds a touch of sophistication to your style. Let this ring be a reflection of your inner peace and elegance.", "Silver", 0, false);
INSERT INTO Prodotto values (9, "Citrine Gold Necklace", "Necklace", "Citrine", "collana_citrino_oro.jpg", 10, 22, 90, "Our Citrine Gold Necklace is a symbol of radiance and prosperity. The dazzling Citrine gemstone, believed to manifest success and good fortune, hangs gracefully from a refined gold chain. Its sunny hue catches the light beautifully, exuding a warm and inviting glow. Elevate your style and embrace the positivity that Citrine gives you with this elegant necklace.", "Gold", 0, false);
INSERT INTO Prodotto values (10, "Quarz Gold Necklace", "Necklace", "Quarz", "collana_quarzo_oro.jpg", 10, 22, 90, "Add a touch of elegance and positivity to your neckline with our Quartz Gold Necklace. The mesmerizing Quartz gemstone, celebrated for its versatility and healing properties, takes center stage in this exquisite pendant. Suspended from a radiant gold chain, the clear and captivating Quartz gem captures the light beautifully, creating a mesmerizing display of brilliance. Embrace the energy of Quartz with this stunning necklace.", "Gold", 0, false);
INSERT INTO Prodotto values (11, "Rose Quarz Gold Necklace", "Necklace", "Rose Quarz", "collana_quarzorosa_oro.jpg", 10, 22, 90, "Radiate love and tenderness with our Rose Quartz Gold Necklace. The gentle and compassionate Rose Quartz gemstone, known for its association with emotional healing, is gracefully encased in a warm gold pendant. The soft pink hues of Rose Quartz symbolize love and understanding, making this necklace a meaningful and heartfelt gift for yourself or someone special.", "Gold", 0, false);
INSERT INTO Prodotto values (12, "Amethyst Gold Necklace", "Necklace", "Amethyst", "collana_ametista_oro.jpg", 10, 22, 100, "Exude an air of mystery and spiritual wisdom with our Amethyst Gold Necklace. The regal Amethyst gemstone, renowned for its transformative and calming properties, takes center stage in this luxurious pendant. Suspended from a gleaming gold chain, the deep purple hues of Amethyst capture the essence of royalty and spirituality. Embrace a touch of elegance and depth with this captivating necklace.", "Gold", 0, false);
INSERT INTO Prodotto values (13, "Amethyst Silver Necklace", "Necklace", "Amethyst", "collana_ame_argento.jpg", 10, 22, 90, "Discover a sense of inner peace and balance with our Amethyst Silver Necklace. The mesmerizing Amethyst gemstone, celebrated for its connection to intuition and inner strength, graces this delicate pendant. Set in a radiant silver chain, the purple gem shines with subtle brilliance, making this necklace a perfect addition to your everyday attire and a thoughtful gift for a loved one.", "Silver", 0, false);
INSERT INTO Prodotto values (14, "Aquamarine Silver Necklace", "Necklace", "Aquamarine", "collana_acqua_argento.jpg", 10, 22, 120, "Dive into a world of serenity with our Aquamarine Silver Necklace. The soothing Aquamarine gemstone, symbolizing tranquility and clarity, hangs delicately from a silver chain. Its gentle blue hue evokes images of calm seas and clear skies, giving a sense of peace and harmony to the wearer. Wear this necklace as a reminder of life's calming moments.", "Silver", 0, false);
INSERT INTO Prodotto values (15, "Aquamarine Silver Earrings", "Earrings", "Aquamarine", "orecchini_acqua_argento.jpg", 10, 22, 100, "Channel the calming energies of water with our Aquamarine Silver Earrings. These elegant earrings feature two sparkling Aquamarine gemstones, carefully set in polished silver. The gentle blue hues of the gemstones complement various skin tones and enhance your natural glow. Elevate your look with the serene and sophisticated allure of these Aquamarine earrings.", "Silver", 0, false);
INSERT INTO Prodotto values (16, "Citrine Gold Earrings", "Earrings", "Citrine", "orecchini_citrino_oro.jpg", 10, 22, 90, "Radiate positivity and joy with our Citrine Gold Earrings. The vibrant Citrine gemstones, believed to bring success and abundance, are carefully crafted into these beautiful earrings. Suspended from a gleaming gold setting, the sunny glow of Citrine adds a cheerful touch to any ensemble. Celebrate life's abundance with these captivating and versatile earrings.", "Gold", 0, false);
INSERT INTO Prodotto values (17, "Citrine Rose Gold Earrings", "Earrings", "Citrine", "orecchini_citrino_ororosa.jpg", 10, 22, 90, "Celebrate the golden moments of life with our Citrine Rose Gold Earrings. The lively Citrine gemstones, known for their association with positivity and prosperity, are elegantly nestled in a warm rose gold setting. The harmonious blend of the vibrant gem and the romantic hue of rose gold creates a charming and stylish pair of earrings for every occasion.", "Rose Gold", 0, false);
INSERT INTO Prodotto values (18, "Quarz Gold Earrings", "Earrings", "Quarz", "orecchini_quarzo_oro.jpg", 10, 22, 70, "Elevate your style with our Quartz Gold Earrings. These elegant earrings feature two dazzling Quartz gemstones, carefully crafted into lustrous gold settings. Known for their versatility and healing properties, Quartz gemstones add a touch of natural brilliance to your look. Embrace the timeless elegance of these earrings and let them become a staple in your jewelry collection.", "Gold", 0, false);
INSERT INTO Prodotto values (19,"Rose Quarz Silver Ring", "Ring", "Rose Quarz", "anello_quarzorosa_argento.jpg", 10, 22, 40, "Wrap your finger in tenderness with our Rose Quartz Silver Ring. The gentle Rose Quartz gemstone, representing love and emotional healing, graces this delicately designed ring. Set in a sleek silver band, the soft pink hues of Rose Quartz evoke feelings of compassion and warmth. Wear this ring as a reminder of the importance of self-love.", "Silver", 0, false);
INSERT INTO Prodotto values (20, "Quarz Silver Bracelet", "Bracelet", "Quarz", "brac_quarzo.jpg", 10, 22, 60, "Embrace simplicity and sophistication with our Quartz Silver Bracelet. The pure and clear Quartz gemstone, symbolizing clarity and balance, is beautifully presented in a sleek silver chain. Its versatility and elegance make it a timeless accessory that effortlessly complements any ensemble. Embrace the understated beauty of this Quartz bracelet in your everyday style.", "Silver", 0, false);
INSERT INTO Prodotto values (21, "Quarz Silver Bracelet", "Bracelet", "Quarz", "brac_quarzo2.jpg", 10, 22, 50, "Embrace the pure essence of clarity and harmony with our Quartz Silver Bracelet. The mesmerizing Quartz gemstone, renowned for its balancing properties and versatile energies, gracefully adorns this delicate bracelet. Set in a gleaming silver chain, the translucent beauty of Quartz reflects the light with captivating brilliance. A symbol of simplicity and elegance, this bracelet reminds you to find serenity in life's everyday moments and cherish the beauty of the present.", "Silver", 0, false);
INSERT INTO Prodotto values (22, "Rose Quarz Silver Bracelet", "Bracelet", "Rose Quarz", "brac_quarzorosa2.jpg", 10, 22, 60, "Wrap your wrist in elegance with our Rose Quartz Silver Bracelet. The tender and loving Rose Quartz gemstone, associated with compassion and emotional healing, is showcased in this dainty bracelet. Set in a silver chain, the Rose Quartz exudes a soft and feminine charm, making it a delightful addition to any outfit.", "Silver", 0, false);
INSERT INTO Prodotto values (23, "Rose Quarz Rose Gold Bracelet", "Bracelet", "Rose Quarz", "brac_quarzorosa.jpg", 10, 22, 70, "Radiate love and affection with our Rose Quartz Rose Gold Bracelet. The tender Rose Quartz gemstone, celebrated for its associations with compassion and healing, is nestled in a luxurious rose gold chain. The romantic combination of rose gold and soft pink hues embodies the essence of love, making this bracelet a heartfelt gift for yourself or a cherished someone.", "Rose Gold", 0, false);
INSERT INTO Prodotto values (24, "Aquamarine Rose Gold Bracelet", "Bracelet", "Aquamarine", "brac_acqua.jpg", 10, 22, 80, "Bask in the allure of the sea with our Aquamarine Rose Gold Bracelet. The serene Aquamarine gemstone, reflecting the soothing qualities of water, is embraced by a luxurious rose gold chain. The delicate balance between the gentle blue gem and the warm rose gold setting creates a captivating piece that complements both casual and formal looks.", "Rose Gold", 0, false);
INSERT INTO Prodotto values (25, "Amethyst Gold Bracelet", "Bracelet", "Amethyst", "brac_ametista_oro.jpg", 10, 22, 80, "Embrace the spiritual essence of our Amethyst Gold Bracelet. The captivating Amethyst gemstone, revered for its ability to enhance intuition and spiritual growth, takes center stage in this charming bracelet. Set in a gleaming gold chain, the regal purple gem captures attention and adds a touch of enchantment to your style.", "Gold", 0, false);
INSERT INTO Prodotto values (26, "Jade Rose Gold Bracelet", "Bracelet", "Jade", "brac_giada.jpg", 10, 22, 120, "Experience the harmony of nature with our Jade Rose Gold Bracelet. The serene Jade gemstone, symbolizing balance and protection, is elegantly encased in a warm rose gold chain. The tranquil green hues of Jade harmonize beautifully with the rose gold, creating an accessory that radiates elegance and positivity.", "Rose Gold", 0, false);
INSERT INTO Prodotto values (27, "Jade Silver Earrings", "Earrings", "Jade", "orecchini_giada_argento.jpg", 10, 22, 120, "Embrace the grounding energies of nature with our Jade Silver Earrings. The soothing Jade gemstones, known for their association with balance and wisdom, are carefully set in polished silver. The organic green tones of the gemstones add a touch of freshness and serenity to your look, making these earrings a lovely choice for any nature enthusiast.",  "Silver", 0, false);
INSERT INTO Prodotto values (28,"Aquamarine Rose Gold Ring", "Ring", "Aquamarine", "anello_acqua_ororosa.jpg", 10, 22, 70, "Capture the essence of the sea with our Aquamarine Rose Gold Ring. The serene Aquamarine gemstone, celebrated for its calming and clarifying properties, graces this exquisite ring. Set in a lustrous rose gold band, the delicate blue hues of Aquamarine blend seamlessly with the romantic rose gold setting, creating a captivating and sophisticated piece.", "Rose Gold", 0, false);


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

INSERT INTO Cliente values("JadeTear", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "TREJDA97H59D615D", "Jade", "Tear", "via Roma 69", "Fisciano", "Salerno", "84084", "391234567812", "JadeTear@gmail.com");
INSERT INTO Cliente values("user1", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "MLRJMS92H17Z100C", "James", "Miller", "Maple Street 27", "Asheville", "North Carolina", "27516", "512345678912", "james.miller@gmail.com");
INSERT INTO Cliente values("user2", "416b61d91f7a4396f43939f1b6dcdf84073ad190", "WLSEMY88C47Z001D", "Emily", "Wilson", "Elmwood Avenue 33", "Sedona", "Arizona", "85001", "389123456712", "emily.wilson@gmail.com");

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

INSERT INTO Indirizzo values(1, "Maple Street 27", "Asheville", "27516", "user1");
INSERT INTO Indirizzo values(2, "Oak Avenue", "Charleston", "27516", "user1");
INSERT INTO Indirizzo values(3, "Elmwood Avenue 33", "Sedona", "85001", "user2");

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

   INSERT INTO Metodo_di_pagamento values(1, "123456789", "123", "2027-01-01", "mastercard", "user1");
   INSERT INTO Metodo_di_pagamento values(2, "987654321", "321", "2067-01-01", "visa", "user1");

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

