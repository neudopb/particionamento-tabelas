package particionamento.tabela.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import particionamento.tabela.model.Tarefa;

public interface TarefaRepository extends JpaRepository<Tarefa, Long> {
}
