package com.nilai.nilai.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nilai.nilai.repository.NilaiRepository;
import com.nilai.nilai.model.Nilai;

import  java.util.List;

@Service
public class NilaiService {

    @Autowired
    private NilaiRepository nilaiRepository;

    public List<Nilai> getAllNilai() {
        return nilaiRepository.findAll();
    }

    public Nilai getNilaiById(int id) {
        return nilaiRepository.findById(id).orElse(null);
    }

    public Nilai saveNilai(Nilai nilai) {
        return nilaiRepository.save(nilai);
    }

    public void deleteNilai(int id) {
        nilaiRepository.deleteById(id);
    }
}