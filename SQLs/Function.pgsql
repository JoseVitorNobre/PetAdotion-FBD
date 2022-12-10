-- Functions
-- Atualiza a tabela pet, definindo o valor disponivel como falso
-- onde o valor do id é igual ao da id da nova tupla
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

-- Verifica quantos pets o dono ja adotou se a quantidade
-- for maior que 4 ele não realiza a adoção
CREATE OR REPLACE FUNCTION verifica_quantidade_adocao()
RETURNS TRIGGER AS
$$
DECLARE
	qtd_adocao_dono integer;
BEGIN
	SELECT qtdadocao INTO qtd_adocao_dono
	FROM adocoespordono as apd
	WHERE apd.cpf = NEW.cpf_adotante;
	IF qtd_adocao_dono = 4 THEN
		RAISE EXCEPTION 'Dono nao pode mais adotar pets';
	END IF;
	RETURN NEW;
END
$$
LANGUAGE 'plpgsql';

-- Verifica quantos pets o dono ja doou se a quantidade
-- for maior que 4 ele não realiza a doação
CREATE OR REPLACE FUNCTION verifica_quantidade_doacao()
RETURNS TRIGGER AS
$$
DECLARE
	qtddoacaodono integer;
BEGIN
	SELECT qtddoacao INTO qtddoacaodono
	FROM doacaopordono as dpd
	WHERE dpd.cpf = NEW.cpf_doador;
	IF qtddoacaodono = 10 THEN
		RAISE EXCEPTION 'Dono nao pode mais doar';
	END IF;
	RETURN NEW;
END
$$
LANGUAGE 'plpgsql';

-- Droppers
DROP FUNCTION verifica_estado_pet;
DROP FUNCTION verifica_quantidade_adocao;
DROP FUNCTION verifica_quantidade_doacao;