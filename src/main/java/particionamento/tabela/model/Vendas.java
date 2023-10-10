package particionamento.tabela.model;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Data
public class Vendas {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "vendas_generator")
    @SequenceGenerator(name = "vendas_generator", sequenceName = "vendas_seq")
    private Long id;
    private String produto;
    private BigDecimal valor;
    private LocalDate data;
}