USE [Chamado];
GO
CREATE TABLE [Cliente] (
    [Id] INT IDENTITY(1,1),                    -- Identificador único
    [Nome] NVARCHAR(100) NOT NULL,             -- Nome do cliente
    [CPF] VARCHAR(11) NOT NULL,                   -- CPF com 11 caracteres
    [Email] NVARCHAR(100) NOT NULL,            -- E-mail do cliente
    [Celular] CHAR(11) NOT NULL,               -- Número de celular no formato "99999999999"
    [CEP] CHAR(8) NOT NULL,                    -- Código postal com 8 caracteres
    [Logradouro] NVARCHAR(150) NOT NULL,       -- Rua ou avenida
    [Bairro] NVARCHAR(100) NOT NULL,           -- Bairro
    [Cidade] NVARCHAR(100) NOT NULL,           -- Cidade
    [Estado] VARCHAR(2) NOT NULL,                 -- Estado com 2 caracteres (Ex.: SP, RJ)
    [Numero] NVARCHAR(10) NOT NULL,            -- Número do imóvel
    CONSTRAINT [PK_Cliente] PRIMARY KEY ([Id])  -- Constraint para a chave primária
);
--INSERT TESTE
INSERT INTO [Cliente] ([Nome], [CPF], [Email], [Celular], [CEP], [Logradouro], [Bairro], [Cidade], [Estado], [Numero])
VALUES
('João Silva', '12345678901', 'joao.silva@example.com', '11987654321', '12345678', 'Rua A, 123', 'Centro', 'São Paulo', 'SP', '123'),
('Maria Oliveira', '98765432100', 'maria.oliveira@example.com', '11998765432', '23456789', 'Avenida B, 456', 'Jardim das Flores', 'Rio de Janeiro', 'RJ', '456'),
('Carlos Souza', '11223344556', 'carlos.souza@example.com', '11912345678', '34567890', 'Rua C, 789', 'Vila Nova', 'Belo Horizonte', 'MG', '789'),
('Fernanda Costa', '99887766544', 'fernanda.costa@example.com', '11976543210', '45678901', 'Rua D, 1011', 'Morumbi', 'São Paulo', 'SP', '1011'),
('Rafael Lima', '55443322110', 'rafael.lima@example.com', '11911223344', '56789012', 'Avenida E, 1213', 'Alto da Boa Vista', 'Curitiba', 'PR', '1213');

--------------------------------------------------------

----------------------------------------------------------
CREATE TABLE [Operador] (
    [Id] INT IDENTITY(1,1),                    -- Identificador único
    [Nome] NVARCHAR(100) NOT NULL,              -- Nome do operador
    [Email] NVARCHAR(100) NOT NULL,             -- E-mail do operador
    [Senha] NVARCHAR(255) NOT NULL,             -- Senha criptografada
    [TipoId] INT NOT NULL,                      -- Chave estrangeira para a tabela Tipo (referencia Id_Tipo)
    [StatusId] INT NOT NULL,                    -- Chave estrangeira para a tabela Status (referencia Id_Status)
    [DataCadastro] DATETIME NOT NULL DEFAULT GETDATE(),  -- Data de cadastro
    CONSTRAINT [PK_Operador] PRIMARY KEY ([Id]),  -- Constraint para a chave primária
    CONSTRAINT [FK_Operador_Tipo] FOREIGN KEY ([TipoId]) REFERENCES [Tipo]([Id_Tipo]),  -- Relacionamento com Tipo
    CONSTRAINT [FK_Operador_Status] FOREIGN KEY ([StatusId]) REFERENCES [Status]([Id_Status]) -- Relacionamento com Status
);
--INSERT TESTE
INSERT INTO [Operador] ([Nome], [Email], [Senha], [TipoId], [StatusId])
VALUES
('Ana Souza', 'ana.souza@example.com', 'senha123', 0, 1),  -- TipoId 1 (Administrador), StatusId 1 (Ativo)
('Lucas Pereira', 'lucas.pereira@example.com', 'senha456', 0, 1),  -- TipoId 2 (Operador), StatusId 2 (Inativo)
('Fernanda Oliveira', 'fernanda.oliveira@example.com', 'senha789', 1, 1),  -- TipoId 1 (Administrador), StatusId 1 (Ativo)
('Carlos Silva', 'carlos.silva@example.com', 'senha321', 1, 0),  -- TipoId 2 (Operador), StatusId 1 (Ativo)
('Roberta Costa', 'roberta.costa@example.com', 'senha654', 1, 0);  -- TipoId 2 (Operador), StatusId 2 (Inativo)
-------------------------------------------------------------
CREATE TABLE [Tipo] (
    [Id] INT IDENTITY(1,1),                    -- Identificador único
    [Id_Tipo] INT NOT NULL,                     -- Novo campo adicional PK
    [Descricao] NVARCHAR(50) NOT NULL,          -- Descrição do tipo (ex.: Administrador, Operador)
    CONSTRAINT [PK_Tipo] PRIMARY KEY ([Id_Tipo])     -- Constraint para a chave primária
);
--INSERT TESTE
INSERT INTO [Tipo] ([Id_Tipo], [Descricao])
VALUES
(0, 'Administrador'),
(1, 'Operador');
----------------------------------------------------------
--INSERT TESTE
CREATE TABLE [Status] (
    [Id] INT IDENTITY(1,1),                    -- Identificador único
    [Id_Status] INT NOT NULL,                   -- Novo campo adicional PK
    [Descricao] NVARCHAR(50) NOT NULL,          -- Descrição do status (ex.: Ativo, Inativo)
    CONSTRAINT [PK_Status] PRIMARY KEY ([Id_Status])   -- Constraint para a chave primária
);
--INSERT TESTE
INSERT INTO [Status] ([Id_Status], [Descricao])
VALUES
(0, 'Ativo'),
(1, 'Inativo');
-------------------------------------------------------------

CREATE TABLE [StatusChamado] (
    [Id] INT IDENTITY(1,1),                    -- Identificador único
    [Id_Status_Chamado] INT NOT NULL,          -- Chave primária do status do chamado
    [Descricao] NVARCHAR(100) NOT NULL,        -- Descrição do status do chamado (ex.: Aberto, Fechado)
    CONSTRAINT [PK_StatusChamado] PRIMARY KEY ([Id_Status_Chamado])  -- Definição da chave primária
);
--INSERT TESTE
INSERT INTO [StatusChamado] ([Id_Status_Chamado], [Descricao])
VALUES
(0, 'Aberto'),
(1, 'Em Atendimento'),
(2, 'Fechado'),
(3, 'Cancelado');
------------------------------------------------------------
CREATE TABLE [Tecnico] (
    [Id] INT IDENTITY(1,1),                    -- Identificador único
    [Nome] NVARCHAR(100) NOT NULL,              -- Nome do técnico
    [Email] NVARCHAR(100) NOT NULL,             -- E-mail do técnico
    [Telefone] CHAR(11) NOT NULL,               -- Telefone do técnico no formato "99999999999"
    [Especialidade] NVARCHAR(100) NOT NULL,     -- Especialidade ou área de atuação do técnico
    [Senha] NVARCHAR(255) NOT NULL,             -- Senha criptografada do técnico
    [StatusId] INT NOT NULL,                    -- Chave estrangeira para a tabela Status (Ativo/Inativo)
    [DataCadastro] DATETIME NOT NULL DEFAULT GETDATE(),  -- Data de cadastro do técnico
    CONSTRAINT [PK_Tecnico] PRIMARY KEY ([Id]),  -- Constraint para a chave primária
    CONSTRAINT [FK_Tecnico_Status] FOREIGN KEY ([StatusId]) REFERENCES [Status]([Id_Status]) -- Relacionamento com Status
);
--INSERT TESTE
INSERT INTO [Tecnico] ([Nome], [Email], [Telefone], [Especialidade], [Senha], [StatusId]) 
VALUES 
('Carlos Silva', 'carlos@exemplo.com', '11987654321', 'Suporte Técnico', 'senhaCriptografadaAqui', 1),  
('Fernanda Souza', 'fernanda@exemplo.com', '11987654322', 'Redes', 'senhaCriptografadaAqui', 1);         
--------------------------------------------------------------
CREATE TABLE [Chamado] (
    [Id] INT IDENTITY(1,1),                     -- Identificador único do chamado
    [ClienteId] INT NOT NULL,                   -- FK para a tabela Cliente
    [OperadorId] INT NOT NULL,                  -- FK para a tabela Operador (quem abriu o chamado)
    [TecnicoId] INT NOT NULL,                   -- FK para a tabela Tecnico (quem vai atender o chamado)
    [StatusChamadoId] INT NOT NULL,             -- FK para a tabela StatusChamado
    [Descricao] NVARCHAR(MAX) NOT NULL,         -- Descrição do problema
    [DataAbertura] DATETIME NOT NULL DEFAULT GETDATE(),  -- Data e hora de abertura do chamado
    [DataFechamento] DATETIME NULL,             -- Data e hora de fechamento do chamado
    CONSTRAINT [PK_Chamado] PRIMARY KEY ([Id]), -- Chave primária
    CONSTRAINT [FK_Chamado_Cliente] FOREIGN KEY ([ClienteId]) REFERENCES [Cliente]([Id]), -- FK Cliente
    CONSTRAINT [FK_Chamado_Operador] FOREIGN KEY ([OperadorId]) REFERENCES [Operador]([Id]), -- FK Operador
    CONSTRAINT [FK_Chamado_Tecnico] FOREIGN KEY ([TecnicoId]) REFERENCES [Tecnico]([Id]), -- FK Tecnico
    CONSTRAINT [FK_Chamado_StatusChamado] FOREIGN KEY ([StatusChamadoId]) REFERENCES [StatusChamado]([Id_Status_Chamado]) -- FK StatusChamado
);
--CRIAÇÃO DE INDICE PARA INDEXAR FUTURAS PESQUISAS PELO CLIENTE
CREATE NONCLUSTERED INDEX [IX_Chamado_ClienteId]
ON [Chamado] ([ClienteId]);

--INSERT TESTE
INSERT INTO [Chamado] 
([ClienteId], [OperadorId], [TecnicoId], [StatusChamadoId], [Descricao], [DataFechamento])
VALUES
(3, 3, 1, 0, 'Problema no acesso ao sistema.', NULL),  -- Chamado aberto
(4, 4, 2, 1, 'Instalação de novo software.', NULL),   -- Chamado em atendimento
(5, 5, 1, 2, 'Atualização de hardware concluída.', '2025-01-15'); -- Chamado fechado

-----------------------------------------------------------

--TESTE DE SELECTS

SELECT * FROM [Operador]
SELECT * FROM [Tecnico]
SELECT * FROM [Cliente]
SELECT * FROM [Tipo]
SELECT * FROM [Status]
SELECT * FROM [StatusChamado]
SELECT * FROM [Chamado]

SELECT 
    C.[Id] AS ChamadoId,
    CL.[Nome] AS ClienteNome,
    CL.[Email] AS ClienteEmail,
    O.[Nome] AS OperadorNome,
    O.[Email] AS OperadorEmail,
    T.[Nome] AS TecnicoNome,
    T.[Email] AS TecnicoEmail,
    SC.[Descricao] AS StatusDescricao,
    C.[Descricao] AS ChamadoDescricao,
    C.[DataAbertura],
    C.[DataFechamento]
FROM 
    [Chamado] C
INNER JOIN [Cliente] CL ON C.[ClienteId] = CL.[Id] -- JOIN NA TAB Clinente NO CAMPO ClienteId da TAB Chamado
INNER JOIN [Operador] O ON C.[OperadorId] = O.[Id] -- JOIN NA TAB Operador NO CAMPO OperadorId da TAB Chamado
INNER JOIN [Tecnico] T ON C.[TecnicoId] = T.[Id]   -- JOIN NA TAB Tecnico NO CAMPO TecnicoId da TAB Chamado
INNER JOIN [StatusChamado] SC ON C.[StatusChamadoId] = SC.[Id_Status_Chamado]; -- JOIN NA TAB StatusChamado NO CAMPO StatusChamadoId da TAB Chamado
---------------------------------------------------------
