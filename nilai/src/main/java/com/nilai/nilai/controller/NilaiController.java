package com.nilai.nilai.controller;

import com.nilai.nilai.model.Nilai;
import com.nilai.nilai.service.NilaiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/api/v1/nilai")
public class NilaiController {

    @Autowired
    private NilaiService nilaiService;

    @GetMapping
    public List<Nilai> getAllNilai() {
        return nilaiService.getAllNilai();
    }

    @GetMapping(path = "{id}")
    public ResponseEntity<Nilai> getNilaiById(@PathVariable int id) {
        try {
            Nilai nilai = nilaiService.getNilaiById(id);
            return new ResponseEntity<>(nilai, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    public ResponseEntity<String> addNilai(@RequestBody Nilai nilai) {
        try {
            nilaiService.saveNilai(nilai);
            return new ResponseEntity<>("New Nilai Added", HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to add Nilai", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Nilai> updateNilai(@RequestBody Nilai nilai, @PathVariable int id) {
        try {
            Nilai existingNilai = nilaiService.getNilaiById(id);
            if (existingNilai != null) {
                existingNilai.setIdmahasiswa(nilai.getIdmahasiswa());
                existingNilai.setIdmatakuliah(nilai.getIdmatakuliah());
                existingNilai.setNilai(nilai.getNilai());

                nilaiService.saveNilai(existingNilai);
                return new ResponseEntity<>(existingNilai, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteNilai(@PathVariable int id) {
        try {
            nilaiService.deleteNilai(id);
            return new ResponseEntity<>("Deleted Nilai with id " + id, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to delete Nilai", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
