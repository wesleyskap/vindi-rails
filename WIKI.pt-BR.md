# Wiki do SDK Vindi

[Read in English (WIKI.md)](./WIKI.md)

Bem-vindo à Wiki do SDK `vindi-rails`. Este documento detalha todos os recursos mapeados, operações suportadas e guias de uso.

---

## 1. Design & Arquitetura do SDK

O SDK utiliza o `RestClient` internamente para se comunicar com a API da Vindi.
Os recursos são representados como objetos Ruby que herdam de `Vindi::Resource`. Os atributos retornados pela API são acessíveis através de métodos getter dinâmicos nas instâncias.

### Tratamento de Erros

O SDK lança exceções específicas de acordo com os códigos de status HTTP retornados. Todos os erros herdam de `Vindi::Error`:

- `Vindi::UnauthorizedError` (401)
- `Vindi::ForbiddenError` (403)
- `Vindi::NotFoundError` (404)
- `Vindi::UnprocessableEntityError` (422)
- `Vindi::RateLimitError` (429)
- `Vindi::InternalServerError` (500+)
- `Vindi::APIError` (Tratamento genérico para outros códigos HTTP)

---

## 2. Mapeamento de Recursos e Operações CRUD

A tabela abaixo lista todos os recursos mapeados e suas operações disponíveis:

| Classe do Recurso | Endpoint | Operações CRUD Habilitadas |
| :--- | :--- | :--- |
| `Vindi::Customer` | `customers` | `list`, `create`, `update`, `delete` |
| `Vindi::PaymentProfile` | `payment_profiles` | `list`, `create`, `delete` |
| `Vindi::Subscription` | `subscriptions` | `list`, `create`, `update`, `delete` |
| `Vindi::Charge` | `charges` | `list`, `create`, `update` |
| `Vindi::Plan` | `plans` | `list`, `create`, `update`, `delete` |
| `Vindi::Product` | `products` | `list`, `create`, `update`, `delete` |
| `Vindi::ProductItem` | `product_items` | `list`, `create`, `update`, `delete` |
| `Vindi::Discount` | `discounts` | `list`, `create`, `delete` |
| `Vindi::Bill` | `bills` | `list`, `create`, `update`, `delete` |
| `Vindi::BillItem` | `bill_items` | `list` |
| `Vindi::Period` | `periods` | `list` |
| `Vindi::Transaction` | `transactions` | `list`, `create` |
| `Vindi::Usage` | `usages` | `list`, `create`, `delete` |
| `Vindi::Invoice` | `invoices` | `list` |
| `Vindi::Movement` | `movements` | `list` |
| `Vindi::Message` | `messages` | `list` |
| `Vindi::ExportBatch` | `export_batches` | `list`, `create` |
| `Vindi::ImportBatch` | `import_batches` | `list`, `create` |
| `Vindi::Issue` | `issues` | `list`, `update` |
| `Vindi::Notification` | `notifications` | `list` |
| `Vindi::Merchant` | `merchants` | `list` |
| `Vindi::MerchantUser` | `merchant_users` | `list` |
| `Vindi::Role` | `roles` | `list` |
| `Vindi::User` | `users` | `list` |
| `Vindi::Public` | `public` | Nenhuma (Configuração Estática) |
| `Vindi::Affiliate` | `affiliates` | `list` |
| `Vindi::Partner` | `partner` | `list` |

---

## 3. Exemplos de Uso

### Clientes (`Vindi::Customer`)

```ruby
# Criar um cliente
cliente = Vindi::Customer.create(
  name: "João Silva",
  email: "joao@exemplo.com"
)

# Acessar atributos do retorno
puts cliente.id
puts cliente.name

# Atualizar cliente
atualizado = Vindi::Customer.update(cliente.id, email: "joao.novo@exemplo.com")

# Excluir cliente
Vindi::Customer.delete(cliente.id)
```

### Perfis de Pagamento (`Vindi::PaymentProfile`)

```ruby
# Criar perfil de pagamento com cartão
perfil = Vindi::PaymentProfile.create(
  customer_id: 12345,
  payment_company_code: "visa",
  holder_name: "JOAO SILVA",
  card_number: "4111111111111111",
  card_expiration_date: "12/2030",
  card_cvv: "123"
)

# Excluir perfil de pagamento
Vindi::PaymentProfile.delete(perfil.id)
```

### Assinaturas (`Vindi::Subscription`)

```ruby
# Criar assinatura
assinatura = Vindi::Subscription.create(
  customer_id: cliente.id,
  plan_id: plano.id,
  payment_method_code: "credit_card"
)

# Cancelar/Excluir assinatura
Vindi::Subscription.delete(assinatura.id)
```

### Cobranças (`Vindi::Charge`)

```ruby
# Listar cobranças pendentes
cobrancas = Vindi::Charge.list(status: "pending")

# Obter valor da primeira cobrança
puts cobrancas.first.amount
```

### Planos (`Vindi::Plan`)

```ruby
# Criar um plano
plano = Vindi::Plan.create(
  name: "Plano Ouro Premium",
  code: "gold_premium",
  interval: "months",
  interval_count: 1
)

# Listar planos
planos = Vindi::Plan.list
```

### Produtos & Itens de Produto (`Vindi::Product` & `Vindi::ProductItem`)

```ruby
# Criar um produto
produto = Vindi::Product.create(
  name: "Serviço de Hospedagem",
  code: "hosting"
)

# Associar um produto a um plano/assinatura
item_produto = Vindi::ProductItem.create(
  product_id: produto.id,
  plan_id: plano.id
)
```

### Descontos (`Vindi::Discount`)

```ruby
# Criar/aplicar um desconto
desconto = Vindi::Discount.create(
  amount: 15.00,
  discount_type: "percentage",
  percentage: 10
)
```

### Faturas & Itens de Fatura (`Vindi::Bill` & `Vindi::BillItem`)

```ruby
# Criar uma fatura manualmente
fatura = Vindi::Bill.create(
  customer_id: cliente.id,
  payment_method_code: "credit_card",
  bill_items: [
    { product_id: produto.id, amount: 99.90 }
  ]
)

# Listar itens de uma fatura
itens = Vindi::BillItem.list(bill_id: fatura.id)
```

### Períodos (`Vindi::Period`)

```ruby
# Listar períodos de uma assinatura
periodos = Vindi::Period.list(subscription_id: assinatura.id)
```

### Transações (`Vindi::Transaction`)

```ruby
# Criar uma transação manual (captura de cobrança)
transacao = Vindi::Transaction.create(
  charge_id: cobranca.id,
  amount: 99.90
)

# Listar transações
transacoes = Vindi::Transaction.list
```

### Consumos/Usos (`Vindi::Usage`)

```ruby
# Informar consumo de uso de uma assinatura
uso = Vindi::Usage.create(
  subscription_id: assinatura.id,
  quantity: 50,
  description: "Chamadas de API consumidas"
)

# Listar consumos informados
usos = Vindi::Usage.list(subscription_id: assinatura.id)
```

### Notas Fiscais (`Vindi::Invoice`)

```ruby
# Listar notas fiscais emitidas
notas_fiscais = Vindi::Invoice.list(status: "issued")
```

### Problemas/Pendências (`Vindi::Issue`)

```ruby
# Atualizar status de uma pendência (ex: marcar como resolvida)
pendencia = Vindi::Issue.update(issue_id, status: "resolved")
```

### Lotes de Importação/Exportação (`Vindi::ImportBatch` & `Vindi::ExportBatch`)

```ruby
# Iniciar lote para importação de clientes/assinaturas
lote_importacao = Vindi::ImportBatch.create(
  batch_type: "customer",
  file_url: "https://exemplo.com/importacao.csv"
)

# Solicitar lote de exportação de dados
lote_exportacao = Vindi::ExportBatch.create(
  batch_type: "bill"
)
```

---

## 4. Gems de Extensão Adicionais

Para manter a biblioteca core leve e livre de dependências acopladas, as features específicas do Rails são distribuídas por meio de gems complementares.

### 4.1 Integrações de Backend ([`vindi-rails-integrations`](https://github.com/wesleyskap/vindi-rails-integrations))

Fornece sincronização automática de modelos do ActiveRecord, endpoints de webhook, jobs de processamento assíncrono e tarefas administrativas via Rake.

#### Instalação
Adicione a gem ao seu Gemfile:
```ruby
gem 'vindi-rails-integrations'
```

#### Configuração de Webhooks
Gere o controller de webhook e o manipulador correspondente na sua aplicação Rails:
```bash
bundle exec rails generate vindi:webhook
```

##### 1. Webhooks Controller (`app/controllers/vindi/webhooks_controller.rb`)
Valida as notificações via POST enviadas pela Vindi comparando um token de segurança recebido via parâmetros.
- **Endpoint**: `POST /vindi/webhooks?token=SEU_TOKEN_SEGURO`
- **Resposta do Controller**: Retorna `{ "status": "received" }` com status `200 OK` em caso de sucesso, ou `{ "error": "Unauthorized access token" }` (`401 Unauthorized`) / `{ "error": "Invalid payload" }` (`400 Bad Request`).

##### 2. Processamento Assíncrono (`app/jobs/vindi/webhook_job.rb`)
Processa os eventos em background. Inclui regras de segurança recomendadas, como a validação de idempotência.

###### Exemplo de Payload de Webhook Vindi (Evento)
```json
{
  "event": {
    "id": 1928374,
    "type": "bill_paid",
    "created_at": "2026-06-10T15:00:00.000-03:00",
    "data": {
      "bill": {
        "id": 887766,
        "amount": "150.00",
        "status": "paid",
        "customer": {
          "id": 112233,
          "name": "Jane Doe",
          "email": "jane.doe@example.com",
          "code": "user_42"
        }
      }
    }
  }
}
```

#### Sincronização de ActiveRecord
Associe qualquer modelo ActiveRecord (ex: `User`, `Account`) para ser sincronizado automaticamente com os Clientes da Vindi.

##### 1. Configuração do Gerador
Execute o gerador de sincronização para o seu modelo:
```bash
bundle exec rails generate vindi:sync User
```
Isso criará uma migração para adicionar a coluna `vindi_customer_id` (String) à tabela correspondente e incluirá o módulo `Vindi::Synchronizable`.

##### 2. Uso & Sobrescrita de Atributos
Inclua o Concern `Vindi::Synchronizable` e customize o mapeamento de atributos se necessário:
```ruby
class User < ApplicationRecord
  include Vindi::Synchronizable

  # Opcional: Personalizar os atributos enviados à Vindi
  def vindi_customer_attributes
    {
      name: "#{first_name} #{last_name}",
      email: email,
      registry_code: cpf_ou_cnpj, # Se aplicável
      code: "user_#{id}"
    }
  end
end
```

Quando um registro do modelo for salvo, os seguintes gatilhos serão acionados:
- **Ao Criar**: Chama `Vindi::Customer.create` e salva o `vindi_customer_id` retornado diretamente no seu banco local.
- **Ao Atualizar**: Verifica se `name` ou `email` mudaram e chama `Vindi::Customer.update` para sincronizar os dados na Vindi.

#### Tarefas Rake (Rake Tasks)
A gem disponibiliza ferramentas para auditoria e teste de integração local:

##### 1. Auditoria de Sincronização (`vindi:audit`)
Compara a base local do seu modelo com o cadastro de clientes da API da Vindi:
```bash
bundle exec rake vindi:audit model=User
```
**Exemplo de log de saída da auditoria:**
```text
Analyzing User database...
[Audit] Checking User ID: 42 (Vindi ID: 112233) - Match found.
[Audit] Checking User ID: 43 (Vindi ID: nil) - Missing in Vindi!
[Audit Warning] User ID 43 created in Vindi with customer ID 112234.
Reconciliation complete. 1 missing records synchronized.
```

##### 2. Simulador de Webhook (`vindi:test_webhook`)
Envia uma requisição POST de teste simulando um evento da Vindi diretamente para o seu endpoint local:
```bash
bundle exec rake vindi:test_webhook event=bill_paid url=http://localhost:3000/vindi/webhooks token=SEU_TOKEN_SEGURO
```
**Exemplo de requisição enviada:**
```text
Sending POST to http://localhost:3000/vindi/webhooks?token=SEU_TOKEN_SEGURO...
Payload: {"event":{"id":9999,"type":"bill_paid","data":{...}}}
Response Code: 200 OK
Response Body: {"status":"received"}
```

---

### 4.2 Componentes Front-End ([`vindi-rails-engines`](https://github.com/wesleyskap/vindi-rails-engines))

Assets e templates prontos para captura de dados de pagamento seguros no navegador em conformidade com as regras PCI.

#### Instalação
Adicione a gem ao seu Gemfile:
```ruby
gem 'vindi-rails-engines'
```

#### Configuração do Checkout
Inicialize os templates HTML e controladores Stimulus JS:
```bash
bundle exec rails generate vindi:checkout
```

##### 1. Controlador Stimulus JS (`app/javascript/controllers/vindi_checkout_controller.js`)
Intercepta a submissão do formulário, serializa os dados do cartão, comunica-se com o tokenizador JS da Vindi e injeta o token gerado em um campo oculto antes de enviar os dados ao Rails:
```javascript
// Connects to data-controller="vindi-checkout"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "publicKey", "holderName", "cardNumber", "expiry", "cvv", "tokenInput" ]

  tokenizeCard(event) {
    event.preventDefault()
    const vindi = new Vindi(this.publicKeyTarget.value)
    
    vindi.createToken({
      holder_name: this.holderNameTarget.value,
      card_number: this.cardNumberTarget.value.replace(/\s+/g, ''),
      card_expiration: this.expiryTarget.value,
      card_cvv: this.cvvTarget.value
    }).then((response) => {
      // response: { token: "tok_abc123XYZ", created_at: "2026-06-10..." }
      this.tokenInputTarget.value = response.token
      this.element.submit()
    }).catch((error) => {
      alert("Erro de Tokenização: " + error.message)
    })
  }
}
```

##### 2. Exemplo de Resposta de Chave Pública da Vindi
Ao chamar `vindi.createToken(...)` com os dados do cartão, o SDK Javascript da Vindi retorna o token de perfil de pagamento:
```json
{
  "token": "tok_3278918239abc",
  "created_at": "2026-06-10T16:50:00.000-03:00"
}
```

Utilize este token (`payment_profile_token`) no seu controller Rails no backend para criar assinaturas ou transações com segurança:
```ruby
# Exemplo de Controller processando o token do checkout
def charge
  Vindi::Charge.create(
    payment_method_code: "credit_card",
    payment_profile: {
      token: params[:payment_profile_token]
    },
    amount: "150.00",
    customer_id: current_user.vindi_customer_id
  )
end
```
