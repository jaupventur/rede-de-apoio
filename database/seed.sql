-- Rede de Apoio - Dados de teste
-- Todos os dados são fictícios. CPFs e CNPJs têm só o formato correto
-- (os dígitos verificadores não são válidos).

INSERT INTO doadores (id, nome, email, cpf) VALUES
  ('a0000000-0000-0000-0000-000000000001', 'Ana Souza',    'ana@teste.com',    '11111111111'),
  ('a0000000-0000-0000-0000-000000000002', 'Bruno Lima',   'bruno@teste.com',  '22222222222'),
  ('a0000000-0000-0000-0000-000000000003', 'Carla Mendes', 'carla@teste.com',  '33333333333');

INSERT INTO instituicoes (id, razao_social, cnpj, email, chave_pix, status) VALUES
  ('b0000000-0000-0000-0000-000000000001', 'Associação Mãos Amigas',   '11111111000111', 'contato@maosamigas.teste',   'contato@maosamigas.teste',   'aprovada'),
  ('b0000000-0000-0000-0000-000000000002', 'Instituto Novo Amanhecer', '22222222000122', 'contato@novoamanhecer.teste', '22222222000122',              'aprovada'),
  ('b0000000-0000-0000-0000-000000000003', 'ONG Em Análise',           '33333333000133', 'contato@emanalise.teste',    'contato@emanalise.teste',    'pendente');

INSERT INTO causas (id, instituicao_id, titulo, descricao, meta_valor, status) VALUES
  ('c0000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001',
   'Cestas básicas para o inverno', 'Arrecadação para montar 200 cestas básicas para famílias da comunidade.', 10000.00, 'ativa'),
  ('c0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001',
   'Reforma do espaço de acolhimento', 'Reforma do telhado e da cozinha da sede.', 25000.00, 'ativa'),
  ('c0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000002',
   'Material escolar 2026', 'Kits de material escolar para crianças atendidas pelo instituto.', 5000.00, 'ativa'),
  ('c0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000002',
   'Campanha do agasalho 2025', 'Campanha já finalizada.', 3000.00, 'encerrada');

INSERT INTO doacoes (doador_id, causa_id, valor, status) VALUES
  ('a0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000001', 50.00,  'confirmada'),
  ('a0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000003', 100.00, 'declarada'),
  ('a0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000001', 200.00, 'confirmada'),
  ('a0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000002', 75.50,  'declarada'),
  ('a0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000004', 30.00,  'cancelada');