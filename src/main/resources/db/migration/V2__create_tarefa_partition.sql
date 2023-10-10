CREATE TABLE tarefa (
    id SERIAL,
    descricao VARCHAR(255),
    status VARCHAR(50),

    PRIMARY KEY(id)
);
CREATE TABLE tarefa_start (
    CHECK (status = 'START')
) INHERITS (tarefa);

CREATE TABLE tarefa_progress (
    CHECK (status = 'IN_PROGRESS')
) INHERITS (tarefa);

CREATE TABLE tarefa_done (
    CHECK (status = 'DONE')
) INHERITS (tarefa);

CREATE OR REPLACE FUNCTION tarefa_function()
RETURNS TRIGGER AS $$
DECLARE
    new_id BIGINT;
BEGIN
    IF NEW.status = 'START' THEN
        INSERT INTO tarefa_start (descricao, status) VALUES (NEW.descricao, NEW.status) RETURNING id INTO new_id;
    ELSIF NEW.status = 'IN_PROGRESS' THEN
        INSERT INTO tarefa_progress (descricao, status) VALUES (NEW.descricao, NEW.status) RETURNING id INTO new_id;
    ELSIF NEW.status = 'DONE' THEN
        INSERT INTO tarefa_done (descricao, status) VALUES (NEW.descricao, NEW.status) RETURNING id INTO new_id;
    ELSE
        RAISE EXCEPTION 'Status desconhecido';
    END IF;

    NEW.id = new_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tarefa_trigger
BEFORE INSERT ON tarefa
FOR EACH ROW
EXECUTE FUNCTION tarefa_function();