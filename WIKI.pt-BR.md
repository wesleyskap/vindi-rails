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
