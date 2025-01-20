===============================================================================

TSQL - Sql para criação de Banco de Dados para Proposta de Projeto que será
desenvolvido 

- Objetivo do projeto é simular o setor de suporte de uma empresa. O sistema
possibilitará o gerenciamento de chamados feitos por clientes.

- Arquitetura Web MVC - linguagem C# 

===============================================================================

# Relacionamento entre Tabelas do Banco de Dados `Chamado`

Este documento descreve os relacionamentos entre as tabelas do banco de dados `Chamado`.

## Estrutura e Relacionamentos

### Tabelas principais e seus relacionamentos:

1. **Cliente**
   - **PK**: `Id`
   - Relacionamentos:
     - `Chamado` (1:N) - Um cliente pode ter múltiplos chamados registrados.

2. **Operador**
   - **PK**: `Id`
   - Relacionamentos:
     - `Tipo` (N:1) - Um operador pertence a um tipo (ex.: Administrador ou Operador).
     - `Status` (N:1) - Define o status do operador (Ativo ou Inativo).
     - `Chamado` (1:N) - Um operador pode abrir múltiplos chamados.

3. **Tipo**
   - **PK**: `Id_Tipo`
   - Relacionamentos:
     - `Operador` (1:N) - Um tipo pode estar associado a múltiplos operadores.

4. **Status**
   - **PK**: `Id_Status`
   - Relacionamentos:
     - `Operador` (1:N) - Define o status de múltiplos operadores.
     - `Técnico` (1:N) - Define o status de múltiplos técnicos.

5. **StatusChamado**
   - **PK**: `Id_Status_Chamado`
   - Relacionamentos:
     - `Chamado` (1:N) - Um status de chamado (Aberto, Fechado, etc.) pode ser associado a múltiplos chamados.

6. **Técnico**
   - **PK**: `Id`
   - Relacionamentos:
     - `Status` (N:1) - Define o status do técnico (Ativo ou Inativo).
     - `Chamado` (1:N) - Um técnico pode atender múltiplos chamados.

7. **Chamado**
   - **PK**: `Id`
   - Relacionamentos:
     - `Cliente` (N:1) - Um chamado pertence a um cliente.
     - `Operador` (N:1) - Um chamado é aberto por um operador.
     - `Técnico` (N:1) - Um chamado é atendido por um técnico.
     - `StatusChamado` (N:1) - Um chamado possui um status associado (Aberto, Em Atendimento, Fechado, etc.).

## Índices Criados
- Índice na tabela `Chamado` para o campo `ClienteId`, visando otimizar buscas relacionadas aos clientes:
  ```sql
  CREATE NONCLUSTERED INDEX [IX_Chamado_ClienteId]
  ON [Chamado] ([ClienteId]);

===============================================================================


