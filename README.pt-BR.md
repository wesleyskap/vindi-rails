# Vindi Rails SDK

[Read in English (README.md)](./README.md)

SDK de integração Ruby/Rails para a API v1 da Vindi (plataforma de cobranças recorrentes).

## Instalação

Adicione esta linha ao Gemfile da sua aplicação:

```ruby
gem 'vindi-rails'
```

E então execute:

```bash
$ bundle install
```

## Configuração

Configure o SDK. Em aplicações Rails, você pode rodar o gerador de instalação para criar o template de inicializador:

```bash
$ rails generate vindi:install
```

Isso criará o arquivo `config/initializers/vindi.rb` onde você poderá configurar suas chaves:

```ruby
Vindi.configure do |config|
  config.api_key = 'sua_chave_privada_da_api'
  # Opcional: Define a URL base (padrão é o Sandbox da Vindi)
  # config.api_url = 'https://gp.vindi.com.br/api/v1'
end
```

## Utilização

Os recursos são mapeados diretamente sob o namespace `Vindi`.

### Clientes

```ruby
# Listar clientes
clientes = Vindi::Customer.list(page: 1, per_page: 20)

# Criar cliente
cliente = Vindi::Customer.create(
  name: 'João Silva',
  email: 'joao.silva@exemplo.com',
  registry_code: '12345678909' # CPF/CNPJ
)

# Atualizar cliente
Vindi::Customer.update(cliente.id, name: 'João Silva Alterado')

# Excluir cliente
Vindi::Customer.delete(cliente.id)
```

## Integrações & Engines Rails Extensíveis

Para manter o SDK base leve e sem dependências rígidas de frameworks, as integrações específicas para o Rails foram separadas em Gems extensíveis:

### 1. Integrações de Backend ([`vindi-rails-integrations`](https://github.com/wesleyskap/vindi-rails-integrations))
Lida com webhooks, jobs em segundo plano e sincronização do ActiveRecord:
- **`rails generate vindi:webhook`**: Cria a infraestrutura para recebimento de webhooks com validação de assinaturas e tratamento em background.
- **`rails generate vindi:webhook_handler [NomeDoEvento]`**: Cria uma classe de serviço modular especializada para processar um evento específico (ex: `subscription_canceled`), que é automaticamente despachada pelo `WebhookJob` principal.
- **`rails generate vindi:sync [Model]`**: Cria migrações e concerns no modelo (ex: `User`) para sincronização automática com a Vindi.
- **`rails vindi:status`**: Rake task de diagnóstico para checar com segurança credenciais da API Vindi, ambiente ativo e validar conectividade.

### 2. Componentes Front-End ([`vindi-rails-engines`](https://github.com/wesleyskap/vindi-rails-engines))
Uma Rails Engine contendo Views e componentes prontos de criptografia e captura de cartão de crédito no navegador:
- **`rails generate vindi:checkout`**: Copia templates de formulário HTML/ERB e Stimulus JS integrando a criptografia de chave pública da Vindi.

Para guias e detalhes de integração, consulte a [WIKI.pt-BR.md](./WIKI.pt-BR.md).

## Rodando os Testes com Docker Compose

Para construir e executar a suíte de testes Minitest dentro do Docker:

```bash
docker compose build
docker compose run --rm test
```

## Documentação Detalhada

Para ver a lista completa de recursos mapeados e instruções de uso detalhadas, confira a [WIKI.pt-BR.md](./WIKI.pt-BR.md).
