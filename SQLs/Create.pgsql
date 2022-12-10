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
	nome VARCHAR(20) NOT NULL UNIQUE
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
	data_doacao DATE NOT NULL DEFAULT CURRENT_DATE,
	cpf_doador VARCHAR(11) NOT NULL,	
	FOREIGN KEY(id_pet) REFERENCES pet(id),
	FOREIGN KEY (cpf_doador) REFERENCES dono(cpf)
);

CREATE TABLE adocao(
	id_adocao SERIAL PRIMARY KEY,
	id_pet INTEGER NOT NULL UNIQUE,
	data_adocao DATE NOT NULL DEFAULT CURRENT_DATE,
	cpf_adotante VARCHAR(11) NOT NULL,
	FOREIGN KEY(id_pet) REFERENCES pet(id),
	FOREIGN KEY (cpf_adotante) REFERENCES dono(cpf)
);

-- Droppers
DROP TABLE adocao;
DROP TABLE doacao;
DROP TABLE pet;
DROP TABLE dono;
DROP TABLE tipo_animal;