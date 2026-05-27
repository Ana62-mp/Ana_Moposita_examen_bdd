package com.krakedev.examen.vuelos.services;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.krakedev.examen.vuelos.entities.Vuelo;
import com.krakedev.examen.vuelos.repositories.VueloRepository;

@Service
public class VueloService {

    private final VueloRepository vueloRepository;

    public VueloService(VueloRepository vueloRepository) {
        super();
        this.vueloRepository = vueloRepository;
    }

    public Vuelo crear(Vuelo vuelo) {
        return vueloRepository.save(vuelo);
    }

    public List<Vuelo> listarTodos() {
        return vueloRepository.findAll();
    }

    public Vuelo buscarPorId(Long id) {
        Optional<Vuelo> vuelo = vueloRepository.findById(id);

        if (vuelo.isPresent()) {
            return vuelo.get();
        }

        return null;
    }

    public Vuelo actualizar(Long id, Vuelo vuelo) {
        Vuelo vueloExistente = buscarPorId(id);

        if (vueloExistente != null) {
            vueloExistente.setCodigo(vuelo.getCodigo());
            vueloExistente.setPrecioBoleto(vuelo.getPrecioBoleto());
            vueloExistente.setAsientosDisponibles(vuelo.getAsientosDisponibles());

            return vueloRepository.save(vueloExistente);
        }

        return null;
    }

    public boolean eliminar(Long id) {
        Vuelo vuelo = buscarPorId(id);

        if (vuelo != null) {
            vueloRepository.delete(vuelo);
            return true;
        }

        return false;
    }

    public List<Vuelo> buscarPorPrecioMenor(BigDecimal precio) {
        return vueloRepository.findByPrecioBoletoLessThan(precio);
    }
}