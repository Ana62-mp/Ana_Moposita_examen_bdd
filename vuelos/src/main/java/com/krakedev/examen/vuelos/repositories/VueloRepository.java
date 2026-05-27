package com.krakedev.examen.vuelos.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.krakedev.examen.vuelos.entities.Vuelo;

public interface VueloRepository extends JpaRepository<Vuelo, Long> {

	List<Vuelo> findByPrecioBoletoLessThan(BigDecimal precio);
}