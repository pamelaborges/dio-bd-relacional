INSERT INTO usuarios (nome, email, data_nascimento, rua, numero, cidade, estado) VALUES ('Usuario sem reservas', 'semreservar@teste.com', '1990-10-10', 'Rua','123','cidade','estado');

-- Traz apenas os usuario com reservas
SELECT * FROM usuarios us
INNER JOIN reservas rs
	ON us.id = rs.id_usuario;

-- Traz todos os usuario e suas reservas se tiver
SELECT * FROM usuarios us
INNER JOIN reservas rs
	ON us.id = rs.id_usuario;

INSERT INTO viagens.destinos ( nome, descricao) VALUES 
('Deestino sem reserva', 'Uma bela praia com areias brancas e mar cristalino')

-- Tras todos os destinos e as reservas se tiverem -- 
SELECT * FROM reservas rs
RIGHT JOIN destinos des
	ON des.id = rs.id_destino;

-- Produz o mesmo resultado que a anterior
SELECT * FROM destinos des
LEFT JOIN reservas rs
	ON des.id = rs.id_destino;

-- SUb consultas

-- Usuários que não fizeram nenhuma reserva
SELECT nome
FROM usuarios
WHERE id NOT IN (SELECT id_usuario FROM reservas);

-- Subconsulta para encontrar os destinos menos populares (com menos reservas):

SELECT nome
FROM destinos
WHERE id NOT IN (SELECT id_destino FROM reservas)
ORDER BY id;

-- contagem de reservas por usuario

SELECT nome, (SELECT COUNT(*) FROM reservas WHERE id_usuario = usuarios.id) AS total_reservas
FROM usuarios;
