# Rede de Apoio

Marketplace solidário que conecta causas, instituições e pessoas que precisam de ajuda a doadores, em um ambiente centralizado, seguro e transparente.

## Objetivo do MVP

- Cadastro de instituições com validação de CNPJ e fluxo de aprovação
- Validação de CPF no cadastro de doadores
- Perfil unificado do doador, com acompanhamento do impacto das doações
- Vitrine de causas com redirecionamento direto para a doação (ex.: PIX da instituição)

## Premissa

O projeto usa apenas tecnologias com plano gratuito, para validar a ideia sem custo inicial.

## Plano de desenvolvimento

1. **Banco de dados:** PostgreSQL (Supabase), com tabelas de doadores, instituições, causas e doações
2. **Backend:** API com validação de CPF e consulta de CNPJ via Brasil API
3. **Frontend:** Vue.js, Tailwind CSS
4. **Deploy:** front na Vercel, back no Render ou AWS Free Tier, com publicação automática

## Estrutura

database/ schema e dados de teste
backend/ API
frontend/ interface web


## Como rodar

1. Copie `.env.example` para `.env` e preencha as variáveis
2. Execute `database/schema.sql` no banco
3. As instruções de backend e frontend serão adicionadas nas próximas fases

## Roadmap pós-MVP

- Taxas administrativas e "Empresas Madrinhas" patrocinadoras
- Gateway de pagamento com cartão, assinaturas recorrentes e split
- Doação de tempo, materiais e serviços
- Gamificação do doador (selos e níveis)
- KYC com biometria para causas de pessoas físicas

## Status

Em desenvolvimento: Fase 1 (banco de dados).