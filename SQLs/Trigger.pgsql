-- Triggers
-- Ao inserir na tabela adoção executa a funtion verifica_estado_pet()
CREATE OR REPLACE TRIGGER atualiza_estado_pet
BEFORE INSERT ON adocao
FOR EACH ROW
EXECUTE PROCEDURE verifica_estado_pet();

-- Ao inserir na tabela doação executa a funtion verifica_quantidade_adocao()
CREATE OR REPLACE TRIGGER verifica_quantidade_adocao
BEFORE INSERT ON adocao
FOR EACH ROW
EXECUTE PROCEDURE verifica_quantidade_adocao();

-- Ao inserir na tabela doação executa a funtion verifica_quantidade_doacao()
CREATE OR REPLACE TRIGGER verifica_quantidade_doacao
BEFORE INSERT ON doacao
FOR EACH ROW
EXECUTE PROCEDURE verifica_quantidade_doacao();

-- Droppers
DROP TRIGGER atualiza_estado_pet ON adocao;
DROP TRIGGER verifica_quantidade_adocao ON adocao;
DROP TRIGGER verifica_quantidade_doacao ON doacao;