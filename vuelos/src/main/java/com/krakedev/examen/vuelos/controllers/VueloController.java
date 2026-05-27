package com.krakedev.examen.vuelos.controllers;

import java.math.BigDecimal;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.krakedev.examen.vuelos.entities.Vuelo;
import com.krakedev.examen.vuelos.services.VueloService;

@RestController
@RequestMapping("/api/vuelos")
public class VueloController {

    private final VueloService servicioV;

    public VueloController(VueloService servicioV) {
        super();
        this.servicioV = servicioV;
    }

    @PostMapping
    public ResponseEntity<?> crear(@RequestBody Vuelo vuelo) {
        try {
            return new ResponseEntity<>(servicioV.crear(vuelo), HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>("Error al crear el vuelo: " + e.getMessage(), 
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping
    public ResponseEntity<?> listar() {
        try {
            return new ResponseEntity<>(servicioV.listarTodos(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error al listar los vuelos: " + e.getMessage(), 
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Long id) {
        try {
            Vuelo vuelo = servicioV.buscarPorId(id);

            if (vuelo != null) {
                return new ResponseEntity<>(vuelo, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("No existe un vuelo con el id: " + id, 
                        HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            return new ResponseEntity<>("Error al buscar el vuelo: " + e.getMessage(), 
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(@PathVariable Long id, @RequestBody Vuelo vuelo) {
        try {
            Vuelo vueloActualizado = servicioV.actualizar(id, vuelo);

            if (vueloActualizado != null) {
                return new ResponseEntity<>(vueloActualizado, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("No existe un vuelo con el id: " + id, 
                        HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            return new ResponseEntity<>("Error al actualizar el vuelo: " + e.getMessage(), 
                    HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Long id) {
        try {
            boolean eliminado = servicioV.eliminar(id);

            if (eliminado) {
                return new ResponseEntity<>("Vuelo eliminado correctamente", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("No existe un vuelo con el id: " + id, 
                        HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            return new ResponseEntity<>("Error al eliminar el vuelo: " + e.getMessage(), 
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/precio-menor")
    public ResponseEntity<?> buscarPorPrecioMenor(@RequestParam BigDecimal precio) {
        try {
            return new ResponseEntity<>(servicioV.buscarPorPrecioMenor(precio), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error al buscar por precio: " + e.getMessage(), 
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}