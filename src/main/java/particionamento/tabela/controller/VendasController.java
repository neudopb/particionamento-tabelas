package particionamento.tabela.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import particionamento.tabela.model.Vendas;
import particionamento.tabela.repository.VendasRepository;

import java.util.List;

@RestController
@RequestMapping("vendas")
public class VendasController {

    @Autowired
    private VendasRepository vendasRepository;

    @GetMapping
    public List<Vendas> findAll() {
        return vendasRepository.findAll();
    }

    @PostMapping
    @Transactional
    public Vendas save(@RequestBody Vendas vendas) {
        return vendasRepository.save(vendas);
    }

}
