-- =====================================================================
-- Script de Carga de Dados - Banco me-gusta
-- Baseado na estrutura do arquivo megustaV05.sql
-- =====================================================================

USE megusta;

-- Desabilitar checagem de FK temporariamente para carga em massa
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;
START TRANSACTION;

-- =====================================================================
-- 1. UNIDADE DE MEDIDA
-- =====================================================================
INSERT INTO unidade_medida (unidade) VALUES
('Saco'),
('Fardo'),
('Unidade'),
('Caixa');

-- =====================================================================
-- 2. TIPO STATUS
-- =====================================================================
INSERT INTO tipo_status (nome) VALUES
('OK'),
('ATENÇÃO'),
('CRÍTICO');

-- =====================================================================
-- 3. MOTIVO
-- =====================================================================
INSERT INTO motivo (nome) VALUES
('Vencimento'),
('Quebra de estoque'),
('Avaria / Perda'),
('Produção fogazza'),
('Ajuste de inventário'),
('Devolução'),
('Uso interno');

-- =====================================================================
-- 4. CATEGORIA INSUMO
-- =====================================================================
INSERT INTO categoria_insumo (nome) VALUES
('Farinha e derivados'),
('Laticínios'),
('Carnes e embutidos'),
('Vegetais e hortifruti'),
('Temperos e condimentos'),
('Embalagens'),
('Bebidas'),
('Limpeza e higiene');

-- =====================================================================
-- 5. CATEGORIA FOGAZZA
-- =====================================================================
INSERT INTO categoria_fogazza (nome) VALUES
('Fogazza Tradicional'),
('Fogazza Doce'),
('Fogazza Salgada Premium'),
('Fogazza Vegana'),
('Fogazza Especial');

-- =====================================================================
-- 6. FORNECEDORES (válidos, conhecidos e reais)
-- =====================================================================
INSERT INTO fornecedor (nome, cnpj, telefone, ativo) VALUES
('Tio João Alimentos LTDA', '33099456000157', '1134567800', TRUE),
('Camil Alimentos S/A', '64904286000115', '1133334400', TRUE),
('Italac - Indústria de Laticínios Ltda', '02581005000144', '1933321100', TRUE),
('Nestlé Brasil LTDA', '61065199000166', '1131485600', TRUE),
('Sadia S/A', '20730099000195', '1138222000', TRUE),
('Seara Alimentos S/A', '03878217000110', '1137777700', TRUE),
('Friboi - JBS S/A', '02916265000166', '1131441500', TRUE),
('Bunge Alimentos S/A', '84046068000119', '1133221100', TRUE),
('Vigor Alimentos S/A', '50388701000190', '1122334400', TRUE),
('Ypióca / Casa Dias (Bebidas)', '12345678000195', '8533336600', TRUE),
('Bombril S/A', '50543903000117', '1122211999', TRUE),
('Araújo Distribuidora', '11222333000144', '3140028922', TRUE),
('Atacadão S/A', '75315333000109', '1121444000', TRUE);

-- =====================================================================
-- 7. FOGAZZA (Produtos do cardápio)
-- =====================================================================
INSERT INTO fogazza (nome, preco, fk_categoria_fogazza) VALUES
('Fogazza Mussarela', 12.50, 1),
('Fogazza Calabresa', 13.00, 1),
('Fogazza Frango c/ Catupiry', 15.50, 1),
('Fogazza Portuguesa', 16.00, 1),
('Fogazza Margherita', 14.50, 1),
('Fogazza Quatro Queijos', 17.00, 3),
('Fogazza Brigadeiro', 12.00, 2),
('Fogazza Doce de Leite', 12.00, 2),
('Fogazza Banana c/ Canela', 11.50, 2),
('Fogazza Romeu e Julieta', 13.50, 2),
('Fogazza Cogumelos (Vegana)', 16.50, 4),
('Fogazza Palmito (Vegana)', 15.00, 4),
('Fogazza Camarão', 22.00, 5),
('Fogazza Filé Mignon c/ Cheddar', 24.50, 5),
('Fogazza Pepperoni', 18.50, 3);

-- =====================================================================
-- 8. INSUMO (qtd_atual = 0 por regra de negócio)
--    Status distribuídos: OK, ATENÇÃO, CRÍTICO
-- =====================================================================
INSERT INTO insumo (fk_categoria_insumo, fk_unidade_medida, fk_status, nome, codigo_insumo, estoque_minimo, qtd_atual, ativo, dt_cadastro) VALUES
-- Farinha e derivados
(1, 1, 1, 'Farinha de Trigo Tipo 1', 'FAR-001', 10.00, 0, TRUE, NOW()),
(1, 2, 1, 'Açúcar Refinado', 'ACU-001', 5.00, 0, TRUE, NOW()),
(1, 2, 2, 'Sal Refinado', 'SAL-001', 3.00, 0, TRUE, NOW()),
(1, 2, 1, 'Fermento Biológico Fresco', 'FER-001', 2.00, 0, TRUE, NOW()),
(1, 1, 1, 'Farinha de Milho', 'FAR-002', 4.00, 0, TRUE, NOW()),

-- Laticínios (sensíveis - misturam OK e ATENÇÃO conforme validade)
(2, 3, 1, 'Queijo Mussarela', 'QUE-001', 8.00, 0, TRUE, NOW()),
(2, 3, 2, 'Queijo Parmesão Ralado', 'QUE-002', 2.00, 0, TRUE, NOW()),
(2, 3, 1, 'Queijo Catupiry', 'QUE-003', 4.00, 0, TRUE, NOW()),
(2, 3, 2, 'Queijo Provolone', 'QUE-004', 3.00, 0, TRUE, NOW()),
(2, 4, 1, 'Leite Integral', 'LEI-001', 15.00, 0, TRUE, NOW()),
(2, 3, 1, 'Manteiga sem Sal', 'MAN-001', 5.00, 0, TRUE, NOW()),
(2, 2, 2, 'Creme de Leite', 'CRE-001', 6.00, 0, TRUE, NOW()),

-- Carnes e embutidos (muito sensíveis - vários ATENÇÃO)
(3, 4, 2, 'Linguiça Calabresa', 'LIN-001', 5.00, 0, TRUE, NOW()),
(3, 4, 1, 'Frango Desfiado', 'FRA-001', 6.00, 0, TRUE, NOW()),
(3, 4, 2, 'Peperoni Fatiado', 'PEP-001', 3.00, 0, TRUE, TRUE, NOW()),
(3, 4, 3, 'Filé Mignon', 'FIL-001', 4.00, 0, TRUE, NOW()),
(3, 4, 2, 'Camarão Limpo', 'CAM-001', 3.00, 0, TRUE, NOW()),
(3, 4, 1, 'Presunto', 'PRE-001', 4.00, 0, TRUE, NOW()),

-- Vegetais (muito sensíveis - vários CRÍTICO por curta validade)
(4, 3, 2, 'Tomate', 'TOM-001', 10.00, 0, TRUE, NOW()),
(4, 3, 1, 'Cebola', 'CEB-001', 8.00, 0, TRUE, NOW()),
(4, 3, 3, 'Manjericão Fresco', 'MAN-002', 1.50, 0, TRUE, NOW()),
(4, 3, 1, 'Alho', 'ALH-001', 3.00, 0, TRUE, NOW()),
(4, 4, 2, 'Palmito', 'PAL-001', 4.00, 0, TRUE, NOW()),
(4, 4, 1, 'Cogumelo Champignon', 'COG-001', 3.00, 0, TRUE, NOW()),
(4, 3, 3, 'Ovo de Galinha', 'OVO-001', 12.00, 0, TRUE, NOW()),

-- Temperos
(5, 2, 1, 'Orégano', 'ORE-001', 0.50, 0, TRUE, NOW()),
(5, 3, 2, 'Pimenta Calabresa', 'PIM-001', 0.30, 0, TRUE, NOW()),
(5, 2, 1, 'Canela em Pó', 'CAN-001', 0.40, 0, TRUE, NOW()),
(5, 2, 1, 'Azeite de Oliva Extra Virgem', 'AZE-001', 3.00, 0, TRUE, NOW()),
(5, 2, 1, 'Vinagre', 'VIN-001', 2.00, 0, TRUE, NOW()),

-- Embalagens
(6, 4, 1, 'Caixa de Papelão P', 'EMB-001', 20.00, 0, TRUE, NOW()),
(6, 4, 1, 'Caixa de Papelão M', 'EMB-002', 20.00, 0, TRUE, NOW()),
(6, 4, 1, 'Caixa de Papelão G', 'EMB-003', 15.00, 0, TRUE, NOW()),
(6, 2, 2, 'Saco Plástico PP', 'EMB-004', 30.00, 0, TRUE, NOW()),

-- Bebidas
(7, 4, 1, 'Refrigerante Cola 2L', 'BEB-001', 6.00, 0, TRUE, NOW()),
(7, 4, 1, 'Água Mineral 500ml', 'BEB-002', 24.00, 0, TRUE, NOW()),
(7, 3, 2, 'Suco de Laranja Natural', 'BEB-003', 10.00, 0, TRUE, NOW()),

-- Limpeza
(8, 3, 1, 'Detergente Líquido', 'LIM-001', 5.00, 0, TRUE, NOW()),
(8, 2, 1, 'Sabão em Pó', 'LIM-002', 4.00, 0, TRUE, NOW()),
(8, 3, 1, 'Álcool 70%', 'LIM-003', 3.00, 0, TRUE, NOW()),
(8, 3, 2, 'Desinfetante', 'LIM-004', 3.00, 0, TRUE, NOW());

-- =====================================================================
-- 9. ENTRADA DE ESTOQUE
--    Variação de datas de validade para testes, todas a partir de 27/08/2026:
--    - Validade HOJE / próxima (até 7 dias)  -> Status CRÍTICO
--    - Validade MÉDIA (8 a 60 dias)          -> Status ATENÇÃO
--    - Validade LONGA (>60 dias)             -> Status OK
--    - Validade FUTURA MUITO DISTANTE        -> Status OK
--
--    Regra de status aplicada ao fk_tipo_status da entrada:
--      CRÍTICO  = proximidade do vencimento (curta validade)
--      ATENÇÃO  = janela intermediária de vencimento
--      OK       = validade confortável / longa
--
--    OBS: NÃO foi feita carga em 'usuario', então a FK fk_usuario
--    depende de quais IDs existem no banco de destino.
-- =====================================================================

-- Como não temos carga de usuários, os inserts abaixo usam os IDs de insumo,
-- fornecedor e status gerados pelos inserts acima.
-- OBS: Como este script roda do zero, os IDs auto-increment começam em 1.
-- Caso seu banco já tenha dados, ajuste o fk_usuario para um usuário válido.

-- Entradas com validade PRÓXIMA (próximos 7 dias a partir de 2026-08-27) - Status CRÍTICO
INSERT INTO entrada_estoque (fk_insumo, fk_usuario, fk_fornecedor, fk_tipo_status, fk_unidade_medida, quantidade_relativa, dt_entrada, lote, dt_validade, dt_pedido, vl_total, quantidade_absoluta) VALUES
(2,  1, 1, 3, 2, 1.00, '2026-08-27 09:30:00', 'LT-ACU-2608-A', '2026-08-30', '2026-08-25',  45.00, 25.00),
(4,  1, 8, 3, 2, 1.00, '2026-08-27 10:15:00', 'LT-FER-2608-A', '2026-08-29', '2026-08-25',  60.00,  5.00),
(20, 1, 6, 3, 3, 2.00, '2026-08-27 11:00:00', 'LT-TOM-2608-A', '2026-08-31', '2026-08-25',  40.00, 12.00),
(23, 1, 6, 3, 3, 2.00, '2026-08-27 08:45:00', 'LT-MAN-2608-A', '2026-09-02', '2026-08-26',  18.00,  4.00),
(7,  1, 3, 3, 3, 1.00, '2026-08-27 09:00:00', 'LT-QUE-2608-A', '2026-09-01', '2026-08-26',  55.00,  4.00);

-- Entradas com validade MÉDIA (entre 8 e 60 dias) - Status ATENÇÃO
INSERT INTO entrada_estoque (fk_insumo, fk_usuario, fk_fornecedor, fk_tipo_status, fk_unidade_medida, quantidade_relativa, dt_entrada, lote, dt_validade, dt_pedido, vl_total, quantidade_absoluta) VALUES
(8,  1, 3, 2, 3, 2.00, '2026-08-27 10:00:00', 'LT-QUE-2608-B', '2026-09-20', '2026-08-25', 160.00,  8.00),
(10, 1, 4, 2, 4, 3.00, '2026-08-27 11:00:00', 'LT-LEI-2608-A', '2026-09-30', '2026-08-25', 105.00, 36.00),
(14, 1, 5, 2, 4, 4.00, '2026-08-27 09:30:00', 'LT-FRA-2608-A', '2026-10-05', '2026-08-26', 180.00, 20.00),
(18, 1, 6, 2, 3, 5.00, '2026-08-27 10:30:00', 'LT-CEB-2608-A', '2026-09-25', '2026-08-26',  40.00, 25.00),
(33, 1, 4, 2, 4, 2.00, '2026-08-27 11:30:00', 'LT-EMB-2608-A', '2026-09-30', '2026-08-26',  70.00, 40.00),
(37, 1, 7, 2, 4, 3.00, '2026-08-27 14:00:00', 'LT-LIM-2608-A', '2026-10-10', '2026-08-26',  60.00, 15.00);

-- Entradas com validade LONGA (mais de 60 dias) - Status OK
INSERT INTO entrada_estoque (fk_insumo, fk_usuario, fk_fornecedor, fk_tipo_status, fk_unidade_medida, quantidade_relativa, dt_entrada, lote, dt_validade, dt_pedido, vl_total, quantidade_absoluta) VALUES
(1,  1, 1, 1, 1, 5.00, '2026-08-27 09:00:00', 'LT-FAR-2608-B', '2027-01-15', '2026-08-25', 540.00, 125.00),
(3,  1, 2, 1, 2, 2.00, '2026-08-27 10:00:00', 'LT-SAL-2608-A', '2028-02-10', '2026-08-25',  60.00, 60.00),
(5,  1, 1, 1, 1, 3.00, '2026-08-27 09:30:00', 'LT-FAR-2608-C', '2027-04-20', '2026-08-26', 165.00, 75.00),
(31, 1, 2, 1, 4, 4.00, '2026-08-27 11:00:00', 'LT-ACU-2608-B', '2027-08-01', '2026-08-26', 200.00, 100.00),
(35, 1, 7, 1, 4, 6.00, '2026-08-27 14:00:00', 'LT-LIM-2608-B', '2027-06-30', '2026-08-26', 120.00, 30.00);

-- Entradas com validade FUTURA MUITO DISTANTE (testes de longo prazo) - Status OK
INSERT INTO entrada_estoque (fk_insumo, fk_usuario, fk_fornecedor, fk_tipo_status, fk_unidade_medida, quantidade_relativa, dt_entrada, lote, dt_validade, dt_pedido, vl_total, quantidade_absoluta) VALUES
(2,  1, 1, 1, 2, 3.00, '2026-08-27 09:00:00', 'LT-ACU-2608-C', '2028-01-20', '2026-08-25', 135.00, 75.00),
(9,  1, 3, 1, 3, 2.00, '2026-08-27 10:00:00', 'LT-QUE-2608-D', '2026-12-15', '2026-08-25',  90.00,  8.00),
(28, 1, 2, 1, 2, 1.50, '2026-08-27 11:30:00', 'LT-CAN-2608-B', '2028-08-01', '2026-08-26',  45.00, 15.00);

-- Entradas com validade HOJE (teste de borda - 2026-08-27) - Status CRÍTICO
INSERT INTO entrada_estoque (fk_insumo, fk_usuario, fk_fornecedor, fk_tipo_status, fk_unidade_medida, quantidade_relativa, dt_entrada, lote, dt_validade, dt_pedido, vl_total, quantidade_absoluta) VALUES
(11, 1, 3, 3, 3, 1.00, '2026-08-27 08:00:00', 'LT-MAN-2608-B', '2026-08-27', '2026-08-26',  35.00,  5.00),
(26, 1, 4, 3, 2, 1.00, '2026-08-27 09:00:00', 'LT-OVO-2608-A', '2026-08-27', '2026-08-26',  24.00, 12.00);

-- =====================================================================
-- 10. FOGAZZA_INSUMO (receitas)
-- =====================================================================
INSERT INTO fogazza_insumo (fk_fogazza, fk_insumo, quantidade_insumo) VALUES
-- Fogazza Mussarela (1)
(1, 1, 0.250), (1, 6, 0.200), (1, 28, 0.005), (1, 31, 0.010), (1, 33, 1.000),
-- Fogazza Calabresa (2)
(2, 1, 0.250), (2, 13, 0.200), (2, 31, 0.010), (2, 33, 1.000),
-- Fogazza Frango c/ Catupiry (3)
(3, 1, 0.250), (3, 8, 0.150), (3, 14, 0.250), (3, 33, 1.000),
-- Fogazza Portuguesa (4)
(4, 1, 0.250), (4, 6, 0.150), (4, 13, 0.100), (4, 17, 0.100), (4, 18, 0.050), (4, 20, 0.050), (4, 26, 0.500), (4, 33, 1.000),
-- Fogazza Margherita (5)
(5, 1, 0.250), (5, 6, 0.200), (5, 18, 0.080), (5, 22, 0.020), (5, 31, 0.015), (5, 33, 1.000),
-- Fogazza Quatro Queijos (6)
(6, 1, 0.250), (6, 6, 0.100), (6, 7, 0.080), (6, 9, 0.080), (6, 8, 0.080), (6, 33, 1.000),
-- Fogazza Brigadeiro (7)
(7, 1, 0.200), (7, 2, 0.080), (7, 31, 0.040), (7, 12, 0.030), (7, 33, 1.000),
-- Fogazza Doce de Leite (8)
(8, 1, 0.200), (8, 2, 0.050), (8, 12, 0.080), (8, 33, 1.000),
-- Fogazza Banana c/ Canela (9)
(9, 1, 0.200), (9, 2, 0.050), (9, 28, 0.010), (9, 33, 1.000),
-- Fogazza Romeu e Julieta (10)
(10, 1, 0.250), (10, 6, 0.200), (10, 31, 0.050), (10, 33, 1.000),
-- Fogazza Cogumelos (Vegana) (11)
(11, 1, 0.250), (11, 24, 0.150), (11, 23, 0.050), (11, 31, 0.020), (11, 33, 1.000),
-- Fogazza Palmito (Vegana) (12)
(12, 1, 0.250), (12, 23, 0.200), (12, 31, 0.020), (12, 33, 1.000),
-- Fogazza Camarão (13)
(13, 1, 0.250), (13, 16, 0.300), (13, 31, 0.020), (13, 33, 1.000),
-- Fogazza Filé Mignon (14)
(14, 1, 0.250), (14, 17, 0.250), (14, 8, 0.120), (14, 31, 0.020), (14, 33, 1.000),
-- Fogazza Pepperoni (15)
(15, 1, 0.250), (15, 15, 0.150), (15, 6, 0.150), (15, 33, 1.000);

-- =====================================================================
-- 11. SAÍDA DE ESTOQUE (amostras para testes de histórico)
--     OBS: depende da existência de fk_usuario válido no banco destino.
-- =====================================================================
INSERT INTO saida_estoque (fk_insumo, fk_usuario, quantidade, dt_saida, fk_motivo) VALUES
(1,  1, 2.00, '2026-08-15 14:00:00', 4),
(6,  1, 1.00, '2026-08-15 14:30:00', 4),
(13, 1, 1.00, '2026-08-15 15:00:00', 4),
(1,  1, 0.50, '2026-08-16 10:00:00', 3),
(2,  1, 0.20, '2026-08-16 10:30:00', 1),
(26, 1, 4.00, '2026-08-20 11:00:00', 4),
(31, 1, 0.05, '2026-08-22 15:00:00', 4),
(11, 1, 0.30, '2026-08-25 09:00:00', 1),
(28, 1, 0.10, '2026-08-25 09:15:00', 1);

-- =====================================================================
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
SET AUTOCOMMIT = 1;

-- =====================================================================
-- CONSULTAS DE VERIFICAÇÃO ÚTEIS PARA TESTES
-- =====================================================================
-- Insumos com estoque crítico (status CRÍTICO):
-- SELECT i.nome, ts.nome AS status, i.estoque_minimo
-- FROM insumo i JOIN tipo_status ts ON i.fk_status = ts.id
-- WHERE ts.nome = 'CRÍTICO';

-- Entradas por faixa de validade (próximas a vencer):
-- SELECT es.id, i.nome AS insumo, es.dt_validade,
--        DATEDIFF(es.dt_validade, CURDATE()) AS dias_para_vencer
-- FROM entrada_estoque es
-- JOIN insumo i ON es.fk_insumo = i.id
-- WHERE es.dt_validade >= CURDATE()
-- ORDER BY es.dt_validade ASC;

-- Entradas já vencidas:
-- SELECT es.id, i.nome AS insumo, es.lote, es.dt_validade
-- FROM entrada_estoque es
-- JOIN insumo i ON es.fk_insumo = i.id
-- WHERE es.dt_validade < CURDATE();

-- =====================================================================
-- FIM DO SCRIPT DE CARGA
-- =====================================================================
