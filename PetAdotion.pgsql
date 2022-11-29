--CREATE SCHEMA "pet_shop";

--SET SCHEMA 'pet_shop';

-- Criação das tabelas
CREATE TABLE dono(
	cpf VARCHAR(11) PRIMARY KEY,
	nome VARCHAR(40) NOT NULL,
	bairro VARCHAR(30) NOT NULL,
	rua VARCHAR(35) NOT NULL,
	numero INTEGER NOT NULL,
	complemento VARCHAR(35),
	telefone VARCHAR(11) NOT NULL
);

CREATE TABLE tipo_animal(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(20) NOT NULL
);

CREATE TABLE pet(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	tipo_animal INTEGER NOT NULL,
	disponivel BOOLEAN DEFAULT TRUE,
	FOREIGN KEY(tipo_animal) REFERENCES tipo_animal(id)
);

CREATE TABLE doacao(
	id_doacao SERIAL PRIMARY KEY,
	id_pet INTEGER NOT NULL UNIQUE,
	data_doacao DATE NOT NULL,
	cpf_doador VARCHAR(11) NOT NULL,	
	FOREIGN KEY(id_pet) REFERENCES pet(id),
	FOREIGN KEY (cpf_doador) REFERENCES dono(cpf)
);

CREATE TABLE adocao(
	id_adocao SERIAL PRIMARY KEY,
	id_pet INTEGER NOT NULL UNIQUE,
	data_adocao DATE NOT NULL,
	cpf_adotante VARCHAR(11) NOT NULL,
	FOREIGN KEY(id_pet) REFERENCES pet(id),
	FOREIGN KEY (cpf_adotante) REFERENCES dono(cpf)
);

-- Functions
--  Ao inserir uma adocao atualizar tabela pet
CREATE OR REPLACE FUNCTION verifica_estado_pet()
RETURNS TRIGGER AS
$$
DECLARE
BEGIN
	UPDATE pet
	SET disponivel = false
	WHERE id = NEW.id_pet;
	RETURN NEW;
END
$$
LANGUAGE 'plpgsql';

-- Triggers
CREATE OR REPLACE TRIGGER atualiza_estado_pet
BEFORE INSERT ON adocao
FOR EACH ROW
EXECUTE PROCEDURE verifica_estado_pet();

-- Povoamento das tabelas
INSERT INTO dono VALUES
('11111111111', 'Andre Ferreira Nunes', 'Aerosmith', 'Dude Looks Like a Lady', 111, 'Permanent Vacation', '13-31897621'),
('22222222222', 'Maria Julia dos Santos', 'AC/DC', 'Dirty Deeds Done Dirt Cheap', 222, 'Dirty Deeds Done Dirt Cheap', '81-98481492'),
('33333333333', 'Thiago Wellington de Souza', 'Metallica', 'Fade to Black', 333, 'Ride the Lightning', '22-74630177'),
('44444444444', 'Ana Maria Gomes', 'Black Sabbath', 'Paranoid', 444, 'Paranoid', '62-82379019'),
('55555555555', 'Julio Vieira da Costa', 'Green Day', 'Holiday', 555, 'American Idiot', '89-77182529'),
('66666666666', 'Antonio Renato Oliveira da Silva', 'Slipknot', 'Before I Forget', 666, 'The Subliminal Verses', '13-92602735'),
('77777777777', 'Maria Iris Ferreira', 'Iron Mainden', 'Fear Of The Dark', 777, 'Fear Of The Dark', '85-81400582'),
('88888888888', 'Jose Daniel Matarazzo', 'Elvis Presley', 'Jailhouse Rock', 888, 'Jailhouse Rock', '99-31609147'),
('99999999999', 'Clara Silveira das Dores', 'Linkin Park', 'Castle Of Glass', 999, 'Living Things', '43-59317996'),
('17812894871', 'Livia Andrade Sousa', 'Red Hot Chilli Peppers', 'Scar Tissue', 112, 'Californication', '63-82948026'),
('79632048903', 'João Paulo Silva', 'Bairro Jorge Almeida', 'Rua Daniel Francisco', 981, '', '88-91478536'),
('30679850237', 'Ricardo Almeida de Santos', 'Bairro de Fatima', 'Rua Gilberto Barros', 21, '', '71-73264890'),
('91603478565', 'Francisco Nobre', 'Bairro Novo', 'Rua Coronel Teixeira', 900, 'Bloco 4 Ap 1', '98-88415679'),
('14570098620', 'Pedro Vitor', 'Bairro Pereira Santos', 'Rua Inês Brasil', 213, '', '32-99883147'),
('88847818386', 'Matheus Araujo', 'Bairro Aldeota', 'Rua Borges de Melo', 1204, '', '55-12947632');

INSERT INTO tipo_animal(nome) VALUES
('Cachorro'),
('Gato'),
('Hamster'),
('Porquinho-da-india'),
('Passaro'),
('Tartaruga'),
('Coelho'),
('Peixe'),
('Ponei'),
('Lagarto');

INSERT INTO pet(nome, tipo_animal) VALUES
('Iggy', 1), ('Chaninho', 2),
('Fifo', 3), ('Chumbinho', 4),
('Arnoldo', 5), ('Marta', 6),
('Floco de neve', 7), ('Theo', 8),
('Pe de pano', 9), ('Sr. Escamas', 10),
('Hug', 1), ('Felix', 2), 
('Spoky', 3), ('Spike', 4),
('Vite', 5), ('Malot', 6),
('Kami', 7), ('Nemo', 8),
('Juan', 9), ('Bryan', 10);

INSERT INTO doacao(id_pet, data_doacao, cpf_doador) VALUES
(1, '03-10-2021', '11111111111'),
(2, '17-10-2021', '22222222222'),
(3, '04-10-2021', '33333333333'),
(4, '21-11-2021', '44444444444'),
(5, '26-11-2021', '55555555555'),
(6, '30-11-2021', '55555555555'),
(7, '02-12-2021', '33333333333'),
(8, '11-12-2021', '33333333333'),
(9, '19-12-2021', '33333333333'),
(10, '24-12-2021', '22222222222'),
(11, '05-01-2022', '11111111111'),
(12, '05-01-2022', '44444444444'),
(13, '12-01-2022', '33333333333'),
(14, '18-01-2022', '11111111111'),
(15, '20-01-2022', '44444444444'),
(16, '22-01-2022', '55555555555'),
(17, '27-01-2022', '44444444444'),
(18, '05-02-2022', '22222222222'),
(19, '09-02-2022', '22222222222'),
(20, '16-02-2022', '22222222222');

INSERT INTO adocao(data_adocao, cpf_adotante, id_pet) VALUES
('28-12-2021', '99999999999', 1),
('29-12-2021', '88888888888', 2),
('31-12-2021', '77777777777', 3),
('07-01-2022', '66666666666', 4),
('12-02-2022', '17812894871', 5),
('04-03-2022', '17812894871', 6),
('16-04-2022', '88888888888', 7),
('21-04-2022', '99999999999', 8),
('12-05-2022', '17812894871', 9),
('16-06-2022', '77777777777', 10),
('16-06-2022', '77777777777', 11),
('16-06-2022', '77777777777', 12),
('16-06-2022', '99999999999', 13);

-- Selects
SELECT * FROM dono;
SELECT * FROM tipo_animal;
SELECT * FROM adocao;
SELECT * FROM doacao;
SELECT * FROM pet;

-- Droppers
DROP TABLE adocao;
DROP TABLE doacao;
DROP TABLE pet;
DROP TABLE dono;
DROP TABLE tipo_animal;
DROP TRIGGER atualiza_estado_pet ON adocao;
DROP FUNCTION verifica_estado_pet;
-- Consultas que respondem as perguntas feitas e suas visões
-- Quais pessoas realizaram uma doação de pet?
CREATE OR REPLACE VIEW doadoresPet AS
    SELECT DISTINCT DON.cpf, DON.nome
    FROM dono DON JOIN doacao DOA ON
        DON.cpf = DOA.cpf_doador;

SELECT * FROM doadoresPet;

-- Quais pets possuem dono e quem são seus donos?
CREATE OR REPLACE VIEW petsComDono AS
    SELECT P.id, P.nome nomePet, 
           D.cpf, D.nome nomeDono
    FROM pet P JOIN adocao A ON
        P.id = A.id_pet JOIN dono D ON
        A.cpf_adotante = D.cpf;

SELECT * FROM petsComDono;

-- Quantos pets de cada tipo estão cadastrados no sistema?
CREATE OR REPLACE VIEW qtdPets AS
    SELECT TP.id, TP.nome, 
           COUNT(P.tipo_animal) qtdPets
    FROM tipo_animal TP JOIN pet P ON
        TP.id = P.tipo_animal
    GROUP BY TP.id, TP.nome
    ORDER BY TP.id;

SELECT * FROM qtdPets;

-- Quantos pets de cada tipo já foram adotados?
CREATE OR REPLACE VIEW qtdPetsAdotados AS
    SELECT TP.id, TP.nome, 
           COUNT(P.tipo_animal) qtdPets
    FROM tipo_animal TP JOIN pet P ON
        TP.id = P.tipo_animal JOIN adocao A 
        ON P.id = A.id_pet
    GROUP BY TP.id, TP.nome
    ORDER BY TP.id;

SELECT * FROM qtdPetsAdotados;

-- Quantos pets de cada tipo ainda estão disponíveis para adoção?
CREATE OR REPLACE VIEW qtdPetsDisponiveis AS
    SELECT TP.id, TP.nome, 
        SUM(CASE WHEN A.id_adocao IS NULL THEN 1 ELSE 0 END) qtdPets
    FROM tipo_animal TP JOIN pet P ON
        TP.id = P.tipo_animal LEFT OUTER 
        JOIN adocao A ON P.id = A.id_pet
    GROUP BY TP.id, TP.nome
    ORDER BY TP.id;

SELECT * FROM qtdPetsDisponiveis;

-- Qual o dono que mais adotou pets?
CREATE OR REPLACE VIEW donoQueMaisAdotou AS
    SELECT *
    FROM dono D
    WHERE(
        SELECT COUNT(cpf_adotante)
        FROM adocao A
        WHERE A.cpf_adotante = D.cpf
        GROUP BY cpf_adotante
    ) >= ALL(
        SELECT COUNT(cpf_adotante)
        FROM adocao
        GROUP BY cpf_adotante
    );

SELECT * FROM donoQueMaisAdotou;

-- Quantas doações cada dono fez?
CREATE OR REPLACE VIEW doacaoPorDono AS
    SELECT DON.cpf, DON.nome, 
           COUNT(DOA.cpf_doador) qtdDoacao
    FROM dono DON LEFT OUTER JOIN doacao DOA ON
        DON.cpf = DOA.cpf_doador
    GROUP BY DON.cpf, DON.nome;

SELECT * FROM doacaoPorDono;

-- Quantas adoções cada dono fez?
CREATE OR REPLACE VIEW adocoesPorDono AS
    SELECT D.cpf, D.nome, 
          COUNT(A.cpf_adotante) qtdAdocao
    FROM dono D LEFT OUTER JOIN adocao A ON
        D.cpf = A.cpf_adotante
    GROUP BY D.cpf, D.nome;

SELECT * FROM adocoesPorDono;

-- Quais tipo de pet foram os mais adotados?
CREATE OR REPLACE VIEW petMaisAdotado AS 
    SELECT *
    FROM tipo_animal T
    WHERE(
        SELECT COUNT(tipo_animal)
        FROM pet P JOIN adocao A ON
            P.id = A.id_pet 
        WHERE P.tipo_animal = T.id
        GROUP BY tipo_animal
    ) >= ALL(
        SELECT COUNT(tipo_animal)
        FROM pet P JOIN adocao A ON
            P.id = A.id_pet 
        GROUP BY tipo_animal
    );

SELECT * FROM petMaisAdotado;

-- Quais tipo de pet foram os menos adotados?
CREATE OR REPLACE VIEW petMenosAdotado AS
    SELECT *
    FROM tipo_animal T
    WHERE(
        SELECT COUNT(tipo_animal)
        FROM pet P JOIN adocao A ON
            P.id = A.id_pet 
        WHERE P.tipo_animal = T.id
        GROUP BY tipo_animal
    ) <= ALL(
        SELECT COUNT(tipo_animal)
        FROM pet P JOIN adocao A ON
            P.id = A.id_pet 
        GROUP BY tipo_animal
    );

SELECT * FROM petMenosAdotado;

-- Droppers View
DROP VIEW doadoresPet;
DROP VIEW petsComDono;
DROP VIEW qtdPets;
DROP VIEW qtdPetsAdotados;
DROP VIEW qtdPetsDisponiveis;
DROP VIEW donoQueMaisAdotou;
DROP VIEW doacaoPorDono;
DROP VIEW adocoesPorDono;
DROP VIEW petMaisAdotado;
DROP VIEW petMenosAdotado;