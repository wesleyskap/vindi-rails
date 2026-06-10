# Histórico de Alterações

Todas as alterações notáveis neste projeto serão documentadas neste arquivo.

---

## [0.1.0] - 10-06-2026

### Adicionado
- **Core SDK**: Versão inicial do SDK Rails da Vindi utilizando `RestClient` como adaptador HTTP padrão.
- **Recursos**: Mapeamento de todos os 28 recursos da API, com operações CRUD completas e cobertura Minitest implementada para todos eles, incluindo faturamento core, catálogo (planos/produtos), cobranças/transações, e lotes/administração.
- **Dockerização**: Configuração do Dockerfile e docker-compose.yml para rodar a suíte de testes de forma isolada.
- **Testes**: Suíte de testes unitários utilizando Minitest e WebMock (24 execuções de teste, 44 asserções).
- **Gerador Rails**: Adicionado o comando `rails generate vindi:install` para inicializar facilmente as configurações de chaves.
- **Documentação**: Guias detalhados de configuração e uso na WIKI (EN / PT-BR) e README bilíngue.
