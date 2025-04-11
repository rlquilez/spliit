[<img alt="Spliit" height="60" src="https://github.com/spliit-app/spliit/blob/main/public/logo-with-text.png?raw=true" />](https://spliit.app)

[![Licença MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg)](./LICENSE)
[![Status do Build](https://img.shields.io/github/actions/workflow/status/spliit-app/spliit/main.yml?branch=main)](https://github.com/spliit-app/spliit/actions)

O Spliit é uma alternativa gratuita e open source ao Splitwise. Você pode:

- Usar a instância oficial em [Spliit.app](https://spliit.app)
- Ou implantar sua própria instância:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fspliit-app%2Fspliit&project-name=my-spliit-instance&repository-name=my-spliit-instance&stores=%5B%7B%22type%22%3A%22postgres%22%7D%5D&)

## 🚀 Funcionalidades

### Principais
- [x] Criar grupos e compartilhar com amigos
- [x] Registrar despesas com descrição
- [x] Visualizar saldos do grupo
- [x] Criar reembolsos
- [x] Aplicativo Web Progressivo (PWA)

### Avançadas
- [x] Selecionar todos/nenhum participante
- [x] Divisão desigual de despesas [(#6)](https://github.com/spliit-app/spliit/issues/6)
- [x] Favoritar grupos [(#29)](https://github.com/spliit-app/spliit/issues/29)
- [x] Identificar-se ao abrir um grupo [(#7)](https://github.com/spliit-app/spliit/issues/7)
- [x] Categorizar despesas [(#35)](https://github.com/spliit-app/spliit/issues/35)
- [x] Buscar despesas [(#51)](https://github.com/spliit-app/spliit/issues/51)
- [x] Anexar imagens às despesas [(#63)](https://github.com/spliit-app/spliit/issues/63)
- [x] Criar despesas escaneando recibos [(#23)](https://github.com/spliit-app/spliit/issues/23)

### Em desenvolvimento
- [ ] Despesas recorrentes [(#5)](https://github.com/spliit-app/spliit/issues/5)
- [ ] Importar do Splitwise [(#22)](https://github.com/spliit-app/spliit/issues/22)

## 🛠️ Tecnologias Utilizadas

- **Frontend**:  
  [Next.js](https://nextjs.org/) - Framework React para aplicação web  
  [TailwindCSS](https://tailwindcss.com/) - Estilização  
  [shadcn/UI](https://ui.shadcn.com/) - Componentes UI  

- **Backend**:  
  [Prisma](https://prisma.io) - ORM para acesso ao banco de dados  

- **Hospedagem**:  
  [Vercel](https://vercel.com/) - Plataforma de deploy (aplicação e banco de dados)

## 🤝 Como Contribuir

O projeto é aberto para contribuições! Você pode:

- Reportar bugs ou sugerir melhorias [abrindo uma issue](https://github.com/spliit-app/spliit/issues)
- Enviar um [pull request](https://github.com/spliit-app/spliit/pulls) com suas melhorias
- Ajudar a traduzir o aplicativo

### Apoio Financeiro

Para ajudar a manter o projeto gratuito e sem anúncios:

- 💜 [Seja um patrocinário](https://github.com/sponsors/scastiel) (Sebastien)
- 💙 [Faça uma doação única](https://donate.stripe.com/28o3eh96G7hH8k89Ba)

## Run locally

### Pré-requisitos
- Node.js 18+
- PostgreSQL
- npm ou yarn

### Passo a Passo

1. **Clonar o repositório**:
   ```bash
   git clone https://github.com/spliit-app/spliit.git
   cd spliit
   ```

2. **Configurar banco de dados**:
   ```bash
   ./scripts/start-local-db.sh  # Cria um container Docker com PostgreSQL
   ```

3. **Configurar ambiente**:
   ```bash
   cp .env.example .env
   
   ```

4. **Instalar dependências**:
   ```bash
   npm install
   ```

5. **Iniciar aplicação**:
   ```bash
   npm run dev
   ```

Acesse: http://localhost:3000

## Run in a container

1. **Construir a imagem Docker**:
   ```bash
   npm run build-image
   ```

2. **Configurar variáveis de ambiente**:
   ```bash
   cp container.env.example container.env
   ```

3. **Iniciar os containers**:
   ```bash
   npm run start-container  # Inicia PostgreSQL e a aplicação Spliit
   ```

4. **Acessar a aplicação**:
   http://localhost:3000

## Opt-in features

### Expense documents

Spliit offers users to upload images (to an AWS S3 bucket) and attach them to expenses. To enable this feature:

- Follow the instructions in the _S3 bucket_ and _IAM user_ sections of [next-s3-upload](https://next-s3-upload.codingvalue.com/setup#s3-bucket) to create and set up an S3 bucket where images will be stored.
- Update your environments variables with appropriate values:

```.env
NEXT_PUBLIC_ENABLE_EXPENSE_DOCUMENTS=true
S3_UPLOAD_KEY=AAAAAAAAAAAAAAAAAAAA
S3_UPLOAD_SECRET=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
S3_UPLOAD_BUCKET=name-of-s3-bucket
S3_UPLOAD_REGION=us-east-1
```

You can also use other S3 providers by providing a custom endpoint:

```.env
S3_UPLOAD_ENDPOINT=http://localhost:9000
```

### Create expense from receipt

You can offer users to create expense by uploading a receipt. This feature relies on [OpenAI GPT-4 with Vision](https://platform.openai.com/docs/guides/vision) and a public S3 storage endpoint.

To enable the feature:

- You must enable expense documents feature as well (see section above). That might change in the future, but for now we need to store images to make receipt scanning work.
- Subscribe to OpenAI API and get access to GPT 4 with Vision (you might need to buy credits in advance).
- Update your environment variables with appropriate values:

```.env
NEXT_PUBLIC_ENABLE_RECEIPT_EXTRACT=true
OPENAI_API_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

### Deduce category from title

You can offer users to automatically deduce the expense category from the title. Since this feature relies on a OpenAI subscription, follow the signup instructions above and configure the following environment variables:

```.env
NEXT_PUBLIC_ENABLE_CATEGORY_EXTRACT=true
OPENAI_API_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## License

MIT, see [LICENSE](./LICENSE)
