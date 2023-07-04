-- 1 forma normal --
-- Criação da nova tabela "usuarios" conforme a 1ª forma normal
CREATE TABLE usuarios (
  id INT,
  nome VARCHAR(255) NOT NULL,
  rua VARCHAR(255) NOT NULL,
  numero INT NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  pais VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

-- Copia os dados da tabela original para a nova tabela
INSERT INTO usuarios (id, nome, rua, numero, cidade, estado, pais)
SELECT id, nome, SUBSTRING_INDEX(endereco, ',', 1) AS rua,
       SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 2), ' ', -1) AS numero,
       SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', -2), ' ', -1) AS cidade,
       SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', -1), ' ', -1) AS estado,
       SUBSTRING_INDEX(endereco, ',', -1) AS pais
FROM usuarios;

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
