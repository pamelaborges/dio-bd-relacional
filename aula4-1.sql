-- Adicionar colunas de endereço à tabela "Usuarios"
ALTER TABLE Usuarios
ADD rua VARCHAR(100),
ADD numero VARCHAR(10),
ADD cidade VARCHAR(50),
ADD estado VARCHAR(50);

-- Atualizar os registros existentes com os valores de endereço separados nas colunas correspondentes
UPDATE Usuarios
SET rua = SUBSTRING_INDEX(endereco, ',', 1),
numero = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 2), ' ', -1),
cidade = SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 3), ',', -1),
estado = SUBSTRING_INDEX(endereco, ',', -1);

-- Criar a tabela "Enderecos"
CREATE TABLE Enderecos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT,
  rua VARCHAR(100),
  numero VARCHAR(10),
  cidade VARCHAR(50),
  estado VARCHAR(50),
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Remover as colunas de endereço da tabela "Usuarios"
ALTER TABLE Usuarios
DROP COLUMN rua,
DROP COLUMN numero,
DROP COLUMN cidade,
DROP COLUMN estado;
