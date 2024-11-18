
## Descrição do Projeto

Este projeto foi desenvolvido como parte do **Projeto Integrador (PI)** do curso de **Engenharia da Computação da UNIVESP (Universidade Virtual do Estado de São Paulo)**. O objetivo do trabalho é realizar uma análise de dados da empresa **LIGHT S.A.**, utilizando ferramentas modernas de visualização e manipulação de dados.

A aplicação foi construída para explorar e apresentar informações financeiras e operacionais da empresa com base nos dados históricos disponíveis, promovendo uma compreensão mais profunda sobre o desempenho da LIGHT ao longo dos anos.

----------

## Tecnologias Utilizadas

-   **Ruby on Rails**: Framework principal para desenvolvimento da aplicação.
-   **Tailwind CSS**: Estilo moderno e responsivo para o frontend.
-   **Highcharts**: Geração de gráficos interativos para visualização de dados.
-   **Roo**: Biblioteca para leitura de arquivos Excel.
-   **PostgreSQL**: Banco de dados utilizado para armazenamento, caso necessário.
-   **Turbo**: Reatividade para melhorar a experiência do usuário.

----------

## Funcionalidades

-   Upload de arquivos Excel com dados financeiros.
-   Análise estatística de métricas.
-   Geração de gráficos interativos:
    -   Valores ao longo dos anos.
    -   Comparação entre ativo e passivo.
    -   Receita versus custo de bens vendidos.
-   Visualização detalhada dos dados extraídos.

----------

## Configuração e Uso

### Pré-requisitos

-   **Ruby**: Versão `3.3.5` ou superior.
-   **Rails**: Versão `8.0.0` ou superior.
-   **Bundler**: Gerenciador de dependências para Ruby.
-   **Node.js** e **Yarn**: Necessários para o frontend.

### Instalação

1.  Clone este repositório:
    
    bash
    
    Copiar código
    
    `git clone https://github.com/seu-usuario/seu-repositorio.git
    cd seu-repositorio` 
    
2.  Instale as dependências:
    
    bash
    
    Copiar código
    
    `bundle install
    yarn install` 
    
3.  Configure o banco de dados:
    
    bash
    
    Copiar código
    
    `rails db:setup` 
    
4.  Inicie o servidor:
    
    bash
    
    Copiar código
    
    `rails server` 
    
5.  Acesse a aplicação em http://localhost:3000.
    

----------

## Estrutura do Projeto

-   **Controllers**: Processam a lógica de upload e análise de dados.
-   **Views**: Renderizam a interface do usuário com gráficos e tabelas.
-   **Assets**: Contém os arquivos estáticos como o logotipo e os estilos do Tailwind CSS.
-   **Scripts**: Automatizam tarefas específicas como carregamento de dados.

----------

## Sobre a Empresa Analisada - LIGHT S.A.

A **LIGHT S.A.** é uma empresa do setor de energia elétrica. Este projeto foca em explorar dados financeiros e operacionais da empresa para apresentar insights importantes e avaliar o desempenho ao longo dos anos.

----------

## Contribuições e Melhorias

Por ser parte de um trabalho acadêmico, contribuições externas não são esperadas. No entanto, sugestões para melhorias e refinamentos são bem-vindas.

----------

## Licença

Este projeto é de uso acadêmico e não está licenciado para fins comerciais.