# Sistema de Gerenciamento de Loja de Discos

Este repositório contém a implementação de um sistema de gerenciamento para loja de discos utilizando o paradigma declarativo de programação com SQL. O projeto foi desenvolvido como trabalho para a disciplina de Paradigmas de Linguagens de Programação do curso de Ciência da Computação do Centro Universitário do Estado do Pará (CESUPA).

## Autores

- Giovanni Braga Soares Vasconcelos
- Antônio Heitor Gomes Azevedo
- Cauã Maia de Souza Nara

## Sobre o Projeto

Este sistema demonstra como o paradigma declarativo pode ser aplicado para solucionar problemas reais de gestão de informação comercial, onde o foco está em "o que" deve ser feito e não em "como" deve ser executado. O sistema permite gerenciar artistas, discos, clientes e vendas, possibilitando consultas eficientes e manipulação de dados de forma declarativa.

## Estrutura do Banco de Dados

O esquema relacional inclui as seguintes tabelas:

- **Artistas**: Armazena informações sobre os artistas musicais
- **Gêneros**: Contém os gêneros musicais para classificação dos discos
- **Discos**: Armazena informações sobre os discos, incluindo título, artista, gênero, preço e quantidade em estoque
- **Clientes**: Mantém dados sobre os clientes da loja
- **Vendas**: Registra as vendas realizadas, incluindo informações sobre cliente e valor total
- **Itens Venda**: Relaciona vendas e discos, registrando quantidade e preço unitário de cada item vendido

## Funcionalidades Implementadas

- Gestão de discos: Cadastro, atualização e consulta de informações sobre discos
- Gestão de clientes: Cadastro e manutenção de dados dos clientes da loja
- Controle de vendas: Registro de vendas e atualização automática de estoque
- Consultas e relatórios avançados:
  - Discos disponíveis em estoque
  - Total de vendas por cliente
  - Discos mais vendidos
  - Vendas por período
  - Vendas por gênero musical

## Arquivos do Repositório

- `sistema-biblioteca-sql.sql`: Contém todos os comandos SQL para criação do banco de dados, inserção de dados de exemplo e consultas implementadas
- `paradigmas_article_final.pdf`: Artigo completo explicando a fundamentação teórica, metodologia e resultados do trabalho

## Como Utilizar

1. Clone este repositório:
   ```
   git clone https://github.com/giovannibragasv/trabalho-paradigmas.git
   ```

2. Importe o arquivo SQL em um sistema gerenciador de banco de dados compatível com SQL padrão (MySQL, PostgreSQL, SQL Server, etc.)

3. Execute as consultas de exemplo ou desenvolva suas próprias consultas para explorar as funcionalidades do sistema

## Paradigma Declarativo e SQL

Este projeto demonstra as vantagens do paradigma declarativo:

- Foco no "o que" em vez do "como"
- Código conciso e legível
- Otimização automática pelo SGBD
- Expressão de operações complexas de forma simples
- Abstração de alto nível para operações em bancos de dados

## Referências

- DATE, C. J. Introdução a Sistemas de Bancos de Dados. 8ª ed. Rio de Janeiro: Elsevier, 2004.
- ELMASRI, R.; NAVATHE, S. B. Sistemas de Banco de Dados. 7ª ed. São Paulo: Pearson, 2018.
- GARCIA-MOLINA, H.; ULLMAN, J. D.; WIDOM, J. Database Systems: The Complete Book. 2ª ed. Upper Saddle River: Pearson, 2008.
- RAMAKRISHNAN, R.; GEHRKE, J. Database Management Systems. 3ª ed. New York: McGraw-Hill, 2003.
- SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. Sistema de Banco de Dados. 6ª ed. Rio de Janeiro: Elsevier, 2012.
- VAN ROY, P.; HARIDI, S. Concepts, Techniques, and Models of Computer Programming. Cambridge: MIT Press, 2004.
