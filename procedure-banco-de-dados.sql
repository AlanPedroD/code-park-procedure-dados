CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE compras (
    id SERIAL PRIMARY KEY,
    id_produto INT,
    quantidade INT,
    data_compra DATE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

CREATE OR REPLACE PROCEDURE gerar_relatorio_compras_diarias()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Seleciona a quantidade de cada produto comprado por dia
    SELECT
        p.nome AS produto,
        c.data_compra,
        SUM(c.quantidade) AS total_comprado
    FROM
        compras c
    JOIN
        produtos p ON c.id_produto = p.id
    GROUP BY
        p.nome, c.data_compra
    ORDER BY
        c.data_compra;
END;
$$;
