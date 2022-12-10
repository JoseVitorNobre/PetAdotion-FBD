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

INSERT INTO doacao(id_pet, cpf_doador) VALUES
(1, '11111111111'),
(2, '22222222222'),
(3, '33333333333'),
(4, '44444444444'),
(5, '55555555555'),
(6, '55555555555'),
(7, '33333333333'),
(8, '33333333333'),
(9, '33333333333'),
(10, '22222222222'),
(11, '11111111111'),
(12, '44444444444'),
(13, '33333333333'),
(14, '11111111111'),
(15, '44444444444'),
(16, '55555555555'),
(17, '44444444444'),
(18, '22222222222'),
(19, '22222222222'),
(20, '22222222222');

INSERT INTO adocao(cpf_adotante, id_pet) VALUES
('99999999999', 1),
('88888888888', 2),
('77777777777', 3),
('66666666666', 4),
('17812894871', 5),
('17812894871', 6),
('88888888888', 7),
('99999999999', 8),
('17812894871', 9),
('77777777777', 10),
('77777777777', 11),
('77777777777', 12),
('99999999999', 13);

-- Selects
SELECT * FROM dono;
SELECT * FROM tipo_animal;
SELECT * FROM adocao;
SELECT * FROM doacao;
SELECT * FROM pet;