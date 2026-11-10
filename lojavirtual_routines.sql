-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: lojavirtual
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'lojavirtual'
--
/*!50003 DROP PROCEDURE IF EXISTS `adicionar_saldo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adicionar_saldo`(IN p_id INT, IN p_valor DECIMAL(10,2))
BEGIN
DECLARE v_existe INT;
START TRANSACTION;
SELECT id INTO v_existe FROM clientes WHERE id = p_id;
IF v_existe > 0 AND p_valor > 0 THEN	
UPDATE clientes SET saldo = saldo + p_valor WHERE id = p_id;   
COMMIT;
ELSE
	ROLLBACK;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_categorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_categorias`()
BEGIN
SELECT * FROM categorias;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_clientes`()
BEGIN
SELECT c.id,c.nome,c.email,c.saldo FROM clientes c;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_historico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_historico`()
BEGIN 
SELECT h.id,c.nome as "Nome do cliente",p.nome as "Nome do produto do pedido",pe.id as "ID Do pedido",pa.valor_total as "Valor total do pedido",h.status,h.data_status,h.id_pedidos FROM historico_pedidos h  
JOIN pedidos pe ON (pe.id = h.id_pedidos) 
JOIN clientes c ON (c.id = pe.id_clientes) 
JOIN itens_pedido i ON (i.id_pedidos = pe.id) 
JOIN produtos p ON (p.id = i.id_produtos) 
JOIN pagamentos pa ON (pe.id = pa.id_pedidos); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_historico_de_um_pedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_historico_de_um_pedido`(IN p_id INT)
BEGIN 
SELECT h.id,c.nome as "Nome do cliente",p.nome as "Nome do produto do pedido",pe.id as "ID Do pedido",pa.valor_total as "Valor total do pedido",h.status,h.data_status,h.id_pedidos FROM historico_pedidos h  
JOIN pedidos pe ON (pe.id = h.id_pedidos) 
JOIN clientes c ON (c.id = pe.id_clientes) 
JOIN itens_pedido i ON (i.id_pedidos = pe.id) 
JOIN produtos p ON (p.id = i.id_produtos) 
JOIN pagamentos pa ON (pe.id = pa.id_pedidos)
WHERE h.id_pedidos = p_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_todos_os_produtos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_todos_os_produtos`()
BEGIN 
SELECT p.id,p.nome as "Nome do produto",p.preco as "Preço do produto",c.nome as "Categoria do produto",p.estoque as "Estoque",p.descricao as "Descrição",p.empresa,p.data_lancamento as "Data de lançamento" FROM produtos p
 JOIN categorias c ON (p.id_categorias = c.id); 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_uma_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_uma_categoria`(IN p_id INT)
BEGIN
SELECT * FROM categorias WHERE id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_um_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_um_cliente`(IN p_id INT)
BEGIN
SELECT * FROM clientes WHERE id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancelar_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelar_compra`(IN p_id_pedido INT,IN p_id_cliente INT)
BEGIN
DECLARE v_existe INT DEFAULT 0;
DECLARE v_valor_total DECIMAL(10,2) DEFAULT 0;
DECLARE v_pagamento_encontrado BOOLEAN DEFAULT TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
DECLARE CONTINUE HANDLER FOR NOT FOUND
SET v_pagamento_encontrado = FALSE;
START TRANSACTION;
SELECT COUNT(*) INTO v_existe FROM pedidos WHERE id = p_id_pedido AND id_clientes = p_id_cliente AND status = "Pedido Confirmado";
IF v_existe > 0 THEN
	SELECT pa.valor_total INTO v_valor_total FROM pagamentos pa
    JOIN pedidos pe ON (pa.id_pedidos = pe.id)
    WHERE pa.id_pedidos = p_id_pedido AND pa.status = "Pagamento Realizado";
    IF v_valor_total > 0 AND v_pagamento_encontrado = TRUE THEN
		UPDATE clientes c SET c.saldo = saldo + v_valor_total WHERE c.id = p_id_cliente;
        UPDATE pedidos p SET p.status = "Pedido Cancelado" WHERE p.id = p_id_pedido;
        UPDATE pagamentos pa SET pa.status = "Pagamento Cancelado" WHERE pa.id_pedidos = p_id_pedido;
        UPDATE produtos p JOIN itens_pedido i ON (p.id = i.id_produtos) 
        SET estoque = estoque + 1 WHERE i.id_pedidos = p_id_pedido;
        COMMIT;
	ELSE 
		ROLLBACK;
        END IF;
	ELSE 
		ROLLBACK;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `carrinho_produto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `carrinho_produto`(IN p_id_pedido INT,IN p_id_produto INT)
BEGIN
DECLARE v_existe_pedido INT DEFAULT 0;
DECLARE v_existe_produto INT DEFAULT 0;
START TRANSACTION;
SELECT id INTO v_existe_pedido FROM pedidos WHERE id = p_id_pedido;
IF v_existe_pedido > 0 THEN
	SELECT id INTO v_existe_produto FROM produtos WHERE id = p_id_produto;
    IF v_existe_produto > 0 THEN
		INSERT INTO itens_pedido (id_produtos,id_pedidos) VALUES (p_id_produto,p_id_pedido);
        COMMIT;
	ELSE 
		ROLLBACK;
        END IF;
ELSE
	ROLLBACK;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fazer_pedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fazer_pedido`(IN p_id_clientes INT)
BEGIN 
DECLARE v_existe_cliente INT DEFAULT 0;
DECLARE v_saldo DECIMAL(10,2) DEFAULT 0;
START TRANSACTION;
SELECT id,saldo INTO v_existe_cliente,v_saldo FROM clientes WHERE id = p_id_clientes;
IF v_existe_cliente > 0 AND v_saldo > 0 THEN 
	INSERT INTO pedidos(id_clientes,status) VALUES(p_id_clientes,"Pedido Realizado, Aguardando os produtos no carrinho e confirmação do pagamento");   
    COMMIT; 
ELSE 
	ROLLBACK; 
END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `realizar_pagamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `realizar_pagamento`(IN p_id_pedido INT,IN p_forma_pagamento VARCHAR(100))
BEGIN
DECLARE v_existe_pedido INT DEFAULT 0;
DECLARE v_existe_cliente INT DEFAULT 0;
DECLARE v_existe_saldo DECIMAL(10,2) DEFAULT 0;
DECLARE v_somar_preco DECIMAL(10,2) DEFAULT 0;
DECLARE v_status VARCHAR(100);
DECLARE v_estoque INT DEFAULT 0;
DECLARE v_pedidos INT DEFAULT 0;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT id,status INTO v_existe_pedido,v_status FROM pedidos WHERE id = p_id_pedido AND status = 'Pedido Realizado, Aguardando os produtos no carrinho e confirmação do pagamento';
IF v_existe_pedido > 0 THEN
SELECT c.id INTO v_existe_cliente FROM clientes c
JOIN pedidos p ON (p.id_clientes = c.id)
WHERE p.id = p_id_pedido;
IF v_existe_cliente > 0 THEN
SELECT saldo INTO v_existe_saldo FROM clientes WHERE id = v_existe_cliente;
SELECT SUM(p.preco) INTO v_somar_preco FROM itens_pedido i
JOIN produtos p ON (i.id_produtos = p.id)
WHERE i.id_pedidos = p_id_pedido;
SELECT COUNT(id_pedidos) INTO v_pedidos FROM itens_pedido i
JOIN pedidos p ON (p.id = i.id_pedidos)
WHERE i.id_pedidos = p_id_pedido AND p.status = 'Pedido Realizado, Aguardando os produtos no carrinho e confirmação do pagamento';
SELECT COUNT(p.estoque) INTO v_estoque FROM produtos p
JOIN itens_pedido i ON (i.id_produtos = p.id)
JOIN pedidos pe ON (pe.id = i.id_pedidos)
WHERE p.estoque > 0 AND i.id_pedidos = p_id_pedido AND pe.status = 'Pedido Realizado, Aguardando os produtos no carrinho e confirmação do pagamento';
SELECT
    v_somar_preco AS total_compra,
    v_existe_saldo AS saldo_cliente,
    v_estoque AS produtos_disponiveis,
    v_pedidos AS total_itens;
IF v_somar_preco <= v_existe_saldo AND v_estoque = v_pedidos AND v_somar_preco IS NOT NULL AND v_pedidos > 0 THEN
INSERT INTO pagamentos(id_pedidos,forma_pagamento,valor_total,data_pagamento,status) VALUES(p_id_pedido,p_forma_pagamento,v_somar_preco,NOW(),"Pagamento Realizado");
UPDATE clientes c JOIN pedidos p ON (c.id = p.id_clientes)
SET saldo = saldo - v_somar_preco
WHERE c.id = v_existe_cliente AND p.status = 'Pedido Realizado, Aguardando os produtos no carrinho e confirmação do pagamento';
UPDATE pedidos SET status = "Pedido Confirmado" WHERE id = p_id_pedido;
UPDATE produtos p  JOIN itens_pedido i ON (i.id_produtos = p.id)
JOIN pedidos pe ON (pe.id = i.id_pedidos)
SET estoque = estoque - 1
WHERE i.id_pedidos = p_id_pedido AND pe.status = "Pedido Confirmado";
COMMIT;
ELSE
ROLLBACK;
END IF;
ELSE
ROLLBACK;
END IF;
ELSE
ROLLBACK;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-10  1:23:12
