# Histórico de Alterações

Todas as alterações notáveis neste projeto serão documentadas neste arquivo.

---

## [0.3.0] - 13-06-2026

### Adicionado
- **Suporte a Chave de Idempotência**: Suporte ao cabeçalho `Idempotency-Key` em ações de POST/PUT através de parâmetro opcional `opts` nas operações `.create` e `.update`.
- **Melhoria no Cache do Docker**: Cópia do `Gemfile.lock` durante o passo de caching das dependências no `Dockerfile` para prevenir erros de incompatibilidade de versão de gemas em runtime.

## [0.2.1] - 12-06-2026

### Alterado
- **Documentação**: Atualizados o README e WIKI (tanto EN quanto PT-BR) para documentar os novos recursos de handlers de webhook modulares fornecidos pela gem complementar `vindi-rails-integrations`.

## [0.2.0] - 10-06-2026

### Adicionado
- **Gerador Rails**: Adicionado o comando `rails generate vindi:install` para inicializar facilmente as configurações de chaves.

---

## [0.1.0] - 10-06-2026

### Adicionado
- **Core SDK**: Versão inicial do SDK Rails da Vindi utilizando `RestClient` como adaptador HTTP padrão.
- **Recursos**: Mapeamento de todos os 28 recursos da API, com operações CRUD completas e cobertura Minitest implementada para todos eles, incluindo faturamento core, catálogo (planos/produtos), cobranças/transações, e lotes/administração.
- **Dockerização**: Configuração do Dockerfile e docker-compose.yml para rodar a suíte de testes de forma isolada.
- **Testes**: Suíte de testes unitários utilizando Minitest e WebMock (23 execuções de teste, 44 asserções).
- **Documentação**: Guias detalhados de configuração e uso na WIKI (EN / PT-BR) e README bilíngue.
