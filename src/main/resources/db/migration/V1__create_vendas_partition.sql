-- Particionamento com Herança - RANGE
CREATE TABLE vendas (
    id serial,
    produto VARCHAR(255),
    valor NUMERIC,
    created_at DATE,
	PRIMARY KEY (id)
);

CREATE SEQUENCE IF NOT EXISTS public.vendas_seq;

CREATE INDEX idx_vendas ON vendas (created_at);

CREATE OR REPLACE FUNCTION generate_partition_name(date)
RETURNS text AS $$
BEGIN
    RETURN 'vendas_' || to_char($1, 'YYYY_MM');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_partition_for_date(date)
RETURNS void AS $$
DECLARE
    partition_name text;
	start_month text;
	start_next_month text;
BEGIN
    partition_name = generate_partition_name($1);
	start_month = to_char($1, 'YYYY-MM') || '-01';
    start_next_month = to_char(($1 + interval '1 month'), 'YYYY-MM') || '-01';

    IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = partition_name) THEN
        EXECUTE 'CREATE TABLE ' || partition_name || ' (CHECK (created_at >= DATE ''' || start_month || ''' AND created_at < DATE ''' || start_next_month || ''')) INHERITS (vendas)';
		EXECUTE 'CREATE INDEX idx_' || partition_name || ' ON ' || partition_name || '(created_at)';
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_vendas_trigger()
RETURNS TRIGGER AS $$
DECLARE
	new_id integer;
BEGIN
    PERFORM create_partition_for_date(NEW.created_at);
	SELECT nextval('vendas_seq') INTO new_id;
    EXECUTE 'INSERT INTO ' || generate_partition_name(NEW.created_at) || '(id, produto, valor, created_at) VALUES ($1, $2, $3, $4)' USING new_id, NEW.produto, NEW.valor, NEW.created_at;
    NEW.id=new_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_vendas_trigger
BEFORE INSERT ON vendas
FOR EACH ROW
EXECUTE FUNCTION insert_vendas_trigger();


INSERT INTO vendas (produto, valor, created_at)
    VALUES
    ('Celular', 1300, '2023-01-15'),
    ('Notebook', 3000, '2023-02-20'),
    ('Tablet', 600, '2023-01-01'),
    ('Tela', 900, '2023-01-22'),
    ('Teclado', 100, '2023-03-05'),
    ('Mouse', 50, '2023-03-10');