# Teste Prático Flutter - Edusoft

Aplicação desenvolvida em Flutter como parte do processo seletivo para desenvolvedores Flutter na Edusoft. O projeto consome a API pública do IBGE (Censo de Nomes), apresentando o ranking de frequência e os detalhes históricos por década de cada nome.

---

## 📱 Funcionalidades

- **Listagem de Nomes / Ranking**: Consumo do endpoint REST do Censo IBGE e exibição dos dados formatados em cards Material Design responsivos.
- **Navegação & Detalhes**: Ao clicar em um item, o usuário é direcionado via sistema de rotas nomeadas para a tela de detalhes com informações históricas por período/década.
- **Gerenciamento de Estado**: Implementado com o padrão **BLoC** (Business Logic Component), garantindo separação clara entre eventos, estados e UI.
- **Arquitetura em Camadas**: Separação organizada entre camadas de Dados (`Data`), Regra de Negócio (`Logic`) e Apresentação (`Presentation`).

---

## 🛠️ Tecnologias e Pacotes Utilizados

- **Flutter / Dart** (Flutter 3.16.4+)
- **flutter_bloc**: Gerenciamento de estado previsível e desacoplado
- **http**: Cliente HTTP para requisições REST
- **Material Design**: Componentes visuais adaptáveis ao layout do dispositivo

---

## 🌐 Endpoints Consumidos

1. **Ranking Geral**: `https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking`
2. **Detalhes do Nome**: `https://servicodados.ibge.gov.br/api/v2/censos/nomes/{nome}`

---

## ⏱️ Tempo de Desenvolvimento e Dificuldades

- **Tempo gasto**: Aproximadamente **5-6 horas**.
- **Dificuldades encontradas**:
  - **Gerenciamento de Estado com BLoC**: Por ter sido o primeiro projeto utilizando essa biblioteca, a curva inicial de aprendizado para a separação precisa de Eventos, Estados e fluxo de Streams exigiu maior dedicação e estudo conceitual durante o desenvolvimento.
  - **Interpretação da Paginação**: O endpoint público do IBGE não disponibiliza parâmetros para paginação no lado do servidor (como `limit` ou `offset`). Para contornar essa restrição e atender aos requisitos de paginação, a solução foi desenvolver uma **paginação local em memória no BLoC**, dividindo a resposta em blocos de 10 em 10 itens e permitindo a navegação instantânea entre páginas sem chamadas extras de rede.

---

## 🚀 Como Executar o Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/gabrieldickmannschneider/teste_edusoft.git
   ```

2. Acesse a pasta do projeto:
   ```bash
   cd teste_edusoft
   ```

3. Obtenha as dependências:
   ```bash
   flutter pub get
   ```

4. Execute o projeto no emulador ou dispositivo conectado:
   ```bash
   flutter run
   ```
