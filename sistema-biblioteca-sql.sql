-- Sistema de Gerenciamento de Loja de Discos
-- Autor: [Nomes dos Integrantes]
-- Data: [Data]

-- Criação das tabelas

-- Tabela de Artistas
CREATE TABLE Artistas (
    ArtistaID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Nacionalidade VARCHAR(50),
    DataFormacao DATE
);

-- Tabela de Generos
CREATE TABLE Generos (
    GeneroID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descricao VARCHAR(200)
);

-- Tabela de Discos
CREATE TABLE Discos (
    DiscoID INT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    ArtistaID INT,
    GeneroID INT,
    AnoLancamento INT,
    Gravadora VARCHAR(100),
    QuantidadeEstoque INT DEFAULT 0,
    PrecoVenda DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ArtistaID) REFERENCES Artistas(ArtistaID),
    FOREIGN KEY (GeneroID) REFERENCES Generos(GeneroID)
);

-- Tabela de Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Telefone VARCHAR(20),
    DataCadastro DATE DEFAULT CURRENT_DATE
);

-- Tabela de Vendas
CREATE TABLE Vendas (
    VendaID INT PRIMARY KEY,
    ClienteID INT,
    DataVenda DATE DEFAULT CURRENT_DATE,
    ValorTotal DECIMAL(10,2),
    FormaPagamento VARCHAR(50),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabela de ItensVenda (para relação N:N entre Vendas e Discos)
CREATE TABLE ItensVenda (
    ItemVendaID INT PRIMARY KEY,
    VendaID INT,
    DiscoID INT,
    Quantidade INT DEFAULT 1,
    PrecoUnitario DECIMAL(10,2),
    FOREIGN KEY (VendaID) REFERENCES Vendas(VendaID),
    FOREIGN KEY (DiscoID) REFERENCES Discos(DiscoID)
);

-- Inserção de dados de exemplo

-- Inserir Artistas
INSERT INTO Artistas (ArtistaID, Nome, Nacionalidade, DataFormacao) VALUES
(1, 'Pink Floyd', 'Britânica', '1965-01-01'),
(2, 'Metallica', 'Americana', '1981-10-28'),
(3, 'João Gilberto', 'Brasileira', '1950-01-01'),
(4, 'The Beatles', 'Britânica', '1960-08-01');

-- Inserir Generos
INSERT INTO Generos (GeneroID, Nome, Descricao) VALUES
(1, 'Rock Progressivo', 'Subgênero do rock que surgiu no final dos anos 1960'),
(2, 'Heavy Metal', 'Gênero do rock caracterizado por guitarras distorcidas e ritmos pesados'),
(3, 'Bossa Nova', 'Estilo musical brasileiro derivado do samba'),
(4, 'Rock Clássico', 'Rock tradicional das décadas de 1960 e 1970');

-- Inserir Discos
INSERT INTO Discos (DiscoID, Titulo, ArtistaID, GeneroID, AnoLancamento, Gravadora, QuantidadeEstoque, PrecoVenda) VALUES
(1, 'The Dark Side of the Moon', 1, 1, 1973, 'Harvest Records', 15, 89.90),
(2, 'Master of Puppets', 2, 2, 1986, 'Elektra Records', 8, 79.90),
(3, 'Chega de Saudade', 3, 3, 1959, 'Odeon', 5, 69.90),
(4, 'Abbey Road', 4, 4, 1969, 'Apple Records', 12, 99.90);

-- Inserir Clientes
INSERT INTO Clientes (ClienteID, Nome, Email, Telefone) VALUES
(1, 'Maria Silva', 'maria.silva@email.com', '(11) 98765-4321'),
(2, 'João Santos', 'joao.santos@email.com', '(11) 91234-5678'),
(3, 'Ana Oliveira', 'ana.oliveira@email.com', '(11) 99876-5432');

-- Inserir Vendas
INSERT INTO Vendas (VendaID, ClienteID, DataVenda, ValorTotal, FormaPagamento) VALUES
(1, 1, CURRENT_DATE, 89.90, 'Cartão de Crédito'),
(2, 2, CURRENT_DATE, 149.80, 'PIX');

-- Inserir ItensVenda
INSERT INTO ItensVenda (ItemVendaID, VendaID, DiscoID, Quantidade, PrecoUnitario) VALUES
(1, 1, 1, 1, 89.90),
(2, 2, 2, 1, 79.90),
(3, 2, 3, 1, 69.90);

-- Consultas de exemplo

-- 1. Listar todos os discos disponíveis em estoque
SELECT D.DiscoID, D.Titulo, A.Nome AS Artista, G.Nome AS Genero, D.AnoLancamento, D.PrecoVenda, D.QuantidadeEstoque
FROM Discos D
JOIN Artistas A ON D.ArtistaID = A.ArtistaID
JOIN Generos G ON D.GeneroID = G.GeneroID
WHERE D.QuantidadeEstoque > 0
ORDER BY D.Titulo;

-- 2. Total de vendas por cliente
SELECT C.Nome AS Cliente, COUNT(V.VendaID) AS NumeroCompras, SUM(V.ValorTotal) AS ValorTotal
FROM Vendas V
JOIN Clientes C ON V.ClienteID = C.ClienteID
GROUP BY C.ClienteID
ORDER BY ValorTotal DESC;

-- 3. Discos mais vendidos
SELECT D.Titulo, A.Nome AS Artista, SUM(IV.Quantidade) AS QuantidadeVendida, 
       SUM(IV.Quantidade * IV.PrecoUnitario) AS ValorTotal
FROM ItensVenda IV
JOIN Discos D ON IV.DiscoID = D.DiscoID
JOIN Artistas A ON D.ArtistaID = A.ArtistaID
GROUP BY D.DiscoID
ORDER BY QuantidadeVendida DESC;

-- 4. Vendas por período
SELECT 
    YEAR(V.DataVenda) AS Ano, 
    MONTH(V.DataVenda) AS Mes, 
    COUNT(V.VendaID) AS NumeroVendas, 
    SUM(V.ValorTotal) AS ValorTotal
FROM Vendas V
GROUP BY YEAR(V.DataVenda), MONTH(V.DataVenda)
ORDER BY Ano, Mes;

-- 5. Vendas por gênero musical
SELECT G.Nome AS Genero, COUNT(IV.ItemVendaID) AS QuantidadeVendida, 
       SUM(IV.Quantidade * IV.PrecoUnitario) AS ValorTotal
FROM ItensVenda IV
JOIN Discos D ON IV.DiscoID = D.DiscoID
JOIN Generos G ON D.GeneroID = G.GeneroID
GROUP BY G.GeneroID
ORDER BY ValorTotal DESC;

-- 6. Atualização de estoque após venda
UPDATE Discos
SET QuantidadeEstoque = QuantidadeEstoque - (
    SELECT Quantidade 
    FROM ItensVenda 
    WHERE VendaID = 1 AND DiscoID = Discos.DiscoID
)
WHERE DiscoID IN (SELECT DiscoID FROM ItensVenda WHERE VendaID = 1);

-- 7. Visão para análise de estoque e vendas
CREATE VIEW vw_AnaliseDisco AS
SELECT 
    D.DiscoID, 
    D.Titulo, 
    A.Nome AS Artista, 
    G.Nome AS Genero,
    D.AnoLancamento,
    D.Gravadora,
    D.QuantidadeEstoque,
    D.PrecoVenda,
    (SELECT SUM(Quantidade) FROM ItensVenda IV WHERE IV.DiscoID = D.DiscoID) AS QuantidadeVendida,
    (SELECT SUM(Quantidade * PrecoUnitario) FROM ItensVenda IV WHERE IV.DiscoID = D.DiscoID) AS ValorTotalVendas
FROM Discos D
JOIN Artistas A ON D.ArtistaID = A.ArtistaID
JOIN Generos G ON D.GeneroID = G.GeneroID;

-- Consultar a visão de análise de discos
SELECT * FROM vw_AnaliseDisco ORDER BY QuantidadeVendida DESC, Titulo;
