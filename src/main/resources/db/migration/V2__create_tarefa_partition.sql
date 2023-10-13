-- Particionamento declarativo - LIST
CREATE TABLE tarefa (
    id SERIAL,
    descricao VARCHAR(255),
    status VARCHAR(50),

    PRIMARY KEY(id, status)
) PARTITION BY LIST(status);

CREATE INDEX idx_tarefa ON tarefa (status);

CREATE TABLE tarefa_start PARTITION OF tarefa
	FOR VALUES IN ('START');

CREATE TABLE tarefa_progress PARTITION OF tarefa
	FOR VALUES IN ('IN_PROGRESS');

CREATE TABLE tarefa_done PARTITION OF tarefa
	FOR VALUES IN ('DONE');


INSERT INTO public.tarefa(descricao, status)
VALUES ('Tarefa 1', 'START'),
	('Tarefa 2', 'IN_PROGRESS'),
	('Tarefa 3', 'DONE'),
	('Tarefa 4', 'START'),
	('Tarefa 5', 'IN_PROGRESS'),
	('Tarefa 6', 'DONE'),
	('Tarefa 7', 'DONE');