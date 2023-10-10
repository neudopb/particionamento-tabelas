package particionamento.tabela.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import particionamento.tabela.model.Vendas;

public interface VendasRepository extends JpaRepository<Vendas, Long> {
}
