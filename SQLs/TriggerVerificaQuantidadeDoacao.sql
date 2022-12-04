CREATE OR REPLACE FUNCTION verifica_quantidade_doacao()
RETURNS TRIGGER AS
$$
DECLARE
	qtddoacaodono integer;
BEGIN
	SELECT qtddoacao INTO qtddoacaodono
	FROM doacaopordono as dpd
	WHERE dpd.cpf = NEW.cpf_doador;
	IF qtddoacaodono = 4 THEN
		RAISE EXCEPTION 'Dono nao pode mais doar';
	END IF;
	RETURN NEW;
END
$$
LANGUAGE 'plpgsql';

CREATE OR REPLACE TRIGGER verifica_quantidade_doacao
BEFORE INSERT ON doacao
FOR EACH ROW
EXECUTE PROCEDURE verifica_quantidade_doacao();

DROP TRIGGER verifica_quantidade_doacao ON doacao;
DROP FUNCTION verifica_quantidade_doacao;

SELECT * FROM dono;
SELECT * FROM doacao;
SELECT * FROM pet;

INSERT INTO doacao(id_pet, data_doacao, cpf_doador) VALUES
(14, '23-12-2022', '11111111111');