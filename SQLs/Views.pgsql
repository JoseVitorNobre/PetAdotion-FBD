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

-- Droppers
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