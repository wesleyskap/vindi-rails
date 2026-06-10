# Vindi Rails SDK

[Read in English (README.md)](./README.md)

SDK de integração Ruby/Rails para a API v1 da Vindi (plataforma de cobranças recorrentes).

## Instalação

Adicione esta linha ao Gemfile da sua aplicação:

```ruby
gem 'vindi-rails', path: 'c:/Users/User/develop/estudo/vindi-rails'
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

## Rodando os Testes com Docker Compose

Para construir e executar a suíte de testes Minitest dentro do Docker:

```bash
docker compose build
docker compose run --rm test
```

## Documentação Detalhada

Para ver a lista completa de recursos mapeados e instruções de uso detalhadas, confira a [WIKI.pt-BR.md](./WIKI.pt-BR.md).
