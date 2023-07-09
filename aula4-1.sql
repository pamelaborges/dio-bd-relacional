-- 1 forma normal --
-- Adição das colunas para os componentes do endereço
ALTER TABLE usuarios
ADD COLUMN rua VARCHAR(255) NOT NULL,
ADD COLUMN numero INT NOT NULL,
ADD COLUMN cidade VARCHAR(255) NOT NULL,
ADD COLUMN estado VARCHAR(255) NOT NULL;

-- Copia os dados da tabela original para a nova tabela
UPDATE usuarios
SET rua = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 1), ',', -1),
    numero = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 2), ',', -1),
    cidade = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 3), ',', -1),
    estado = SUBSTRING_INDEX(endereco, ',', -1);

-- Exclusão da coluna "endereco" da tabela original
ALTER TABLE usuarios
DROP COLUMN endereco;


--2 Forma normal --

-- Criar a tabela "enderecos"
CREATE TABLE enderecos (
  id INT PRIMARY KEY,
  id_usuario INT,
  rua VARCHAR(255) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  estado VARCHAR(100) NOT NULL,
  pais VARCHAR(100) NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Inserir os dados de endereço na tabela "enderecos"
INSERT INTO enderecos (id, id_usuario, rua, numero, cidade, estado, pais)
SELECT id, id, rua, numero, cidade, estado, pais
FROM usuarios;

-- Remover os atributos de endereço da tabela "usuarios"
ALTER TABLE usuarios
DROP COLUMN rua,
DROP COLUMN numero,
DROP COLUMN cidade,
DROP COLUMN estado,
DROP COLUMN pais;
