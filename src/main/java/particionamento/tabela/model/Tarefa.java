package particionamento.tabela.model;

import jakarta.persistence.*;
import lombok.Data;
import particionamento.tabela.enums.StatusEnum;

@Entity
@Data
public class Tarefa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String descricao;
    @Enumerated(EnumType.STRING)
    private StatusEnum status;
}
