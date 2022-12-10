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

CREATE OR REPLACE TRIGGER verifica_quantidade_adocao
BEFORE INSERT ON adocao
FOR EACH ROW
EXECUTE PROCEDURE verifica_quantidade_adocao();

DROP TRIGGER verifica_quantidade_adocao ON adocao;
DROP FUNCTION verifica_quantidade_adoca;

SELECT * FROM dono;
SELECT * FROM adocao;
SELECT * FROM pet;

INSERT INTO adocao(id_pet, data_adocao, cpf_adotante) VALUES
(14, '19-11-2022', '88888888888')