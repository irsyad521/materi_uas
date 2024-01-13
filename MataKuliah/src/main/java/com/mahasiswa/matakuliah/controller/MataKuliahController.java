package com.mahasiswa.matakuliah.controller;

import com.mahasiswa.matakuliah.model.MataKuliah;
import com.mahasiswa.matakuliah.service.MataKuliahService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/api/v1/matakuliah")
public class MataKuliahController {

    @Autowired
    private MataKuliahService mataKuliahService;

    @GetMapping
    public List<MataKuliah> getAll() {
        return mataKuliahService.listAll();
    }

    @GetMapping(path = "{id}")
    public ResponseEntity<MataKuliah> getMatakuliahById(@PathVariable Long id) {
        try {
            MataKuliah mataKuliah = mataKuliahService.get(id);
            return new ResponseEntity<>(mataKuliah, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    public ResponseEntity<String> add(@RequestBody MataKuliah mataKuliah) {
        try {
            mataKuliahService.save(mataKuliah);
            return new ResponseEntity<>("New MataKuliah Added", HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to add MataKuliah", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<MataKuliah> update(@RequestBody MataKuliah mataKuliah, @PathVariable Long id) {
        try {
            MataKuliah existingMataKuliah = mataKuliahService.get(id);
            if (existingMataKuliah != null) {
                existingMataKuliah.setNama(mataKuliah.getNama());
                existingMataKuliah.setKode(mataKuliah.getKode());
                existingMataKuliah.setSks(mataKuliah.getSks());

                mataKuliahService.save(existingMataKuliah);
                return new ResponseEntity<>(existingMataKuliah, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {
        try {
            mataKuliahService.delete(id);
            return new ResponseEntity<>("Deleted MataKuliah with id " + id, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to delete MataKuliah", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}