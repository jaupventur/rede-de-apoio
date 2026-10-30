
-- Tipos enumerados
CREATE TYPE status_instituicao AS ENUM ('pendente', 'aprovada', 'rejeitada');
CREATE TYPE status_causa       AS ENUM ('ativa', 'encerrada');
CREATE TYPE status_doacao      AS ENUM ('declarada', 'confirmada', 'cancelada');

-- funcao para manter atualizado_em
CREATE OR REPLACE FUNCTION set_atualizado_em()
RETURNS TRIGGER AS $$
BEGIN
    NEW.atualizado_em = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- doadores
CREATE TABLE doadores (
    id  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    nome    text NOT NULL,
    email   text NOT NULL UNIQUE,
    cpf     char(11) NOT NULL UNIQUE CHECK (cpf ~'^[0-9]{11}$'),
    criado_em timestamp NOT NULL DEFAULT now(),
    atualizado_em   timestamp NOT NULL DEFAULT now()
);

-- instituicoes
CREATE TABLE instituicoes (
    id  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    razao_social    text NOT NULL,
    cnpj    char(14) NOT NULL UNIQUE CHECK (cnpj ~ '^[0-9]{14}$'),
    email   text NOT NULL UNIQUE,
    chave_pix   text NOT NULL,
    status status_instituicao NOT NULL DEFAULT 'pendente',
    criado_em   timestamp NOT NULL DEFAULT now(),
    atualizado_em   timestamp NOT NULL DEFAULT now()
);

-- causas
CREATE TABLE causas (
    id  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    instituicao_id  uuid NOT NULL REFERENCES instituicoes(id) ON DELETE RESTRICT,
    titulo  text NOT NULL,
    descricao text NOT NULL,
    meta_valor numeric(12,2) CHECK (meta_valor > 0),
    status  status_causa NOT NULL DEFAULT 'ativa',
    criado_em timestamp NOT NULL DEFAULT now(),
    atualizado_em   timestamp NOT NULL DEFAULT now()
);

-- doacoes (no MVP, registro de doacao declarada via pix externo)
CREATE TABLE doacoes (
    id  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    doador_id   uuid NOT NULL REFERENCES doadores(id) ON DELETE RESTRICT,
    causa_id    uuid NOT NULL REFERENCES causas(id) ON DELETE RESTRICT,
    valor   numeric(12,2) NOT NULL CHECK (valor > 0),
    status  status_doacao NOT NULL DEFAULT 'declarada',
    criado_em   timestamp NOT NULL DEFAULT now()
);

-- indices
CREATE INDEX idx_instituicoes_status ON instituicoes(status);
CREATE INDEX idx_causas_instituicao ON causas(instituicao_id);
CREATE INDEX idx_causas_status  ON causas(status);
CREATE INDEX idx_doacoes_doador ON doacoes(doador_id);
CREATE INDEX idx_doacoes_causa  ON doacoes(causa_id);

-- triggers de atualizado_em
CREATE TRIGGER trg_doadores_upd BEFORE UPDATE ON doadores
    FOR EACH ROW EXECUTE FUNCTION set_atualizado_em();
CREATE TRIGGER trg_instituicoes_upd BEFORE UPDATE ON instituicoes
    FOR EACH ROW EXECUTE FUNCTION set_atualizado_em();
CREATE TRIGGER trg_causas_upd   BEFORE UPDATE ON causas
    FOR EACH ROW EXECUTE FUNCTION set_atualizado_em();

-- seguranca: rls ligado e sem politicas = a API publica do Supabase
-- nao acessa nada, so backend, conectando direto no banco, le e escreve.
ALTER TABLE doadores    ENABLE ROW LEVEL SECURITY;
ALTER TABLE instituicoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE causas  ENABLE ROW LEVEL SECURITY;
ALTER TABLE doacoes ENABLE ROW LEVEL SECURITY;
