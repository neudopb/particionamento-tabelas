package particionamento.tabela.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import particionamento.tabela.model.Tarefa;
import particionamento.tabela.repository.TarefaRepository;

import java.util.List;

@RestController
@RequestMapping("tarefas")
public class TarefaController {

    @Autowired
    private TarefaRepository tarefaRepository;

    @GetMapping
    public List<Tarefa> findAll() {
        return tarefaRepository.findAll();
    }

    @PostMapping
    @Transactional
    public Tarefa save(@RequestBody Tarefa tarefa) {
        return tarefaRepository.save(tarefa);
    }

}
