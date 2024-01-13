package com.nilai.nilai.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Nilai {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String idmahasiswa;
    private String idmatakuliah;
    private int nilai;

    public Nilai() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIdmahasiswa() {
        return idmahasiswa;
    }

    public void setIdmahasiswa(String idmahasiswa) {
        this.idmahasiswa = idmahasiswa;
    }

    public String getIdmatakuliah() {
        return idmatakuliah;
    }

    public void setIdmatakuliah(String idmatakuliah) {
        this.idmatakuliah = idmatakuliah;
    }

    public int getNilai() {
        return nilai;
    }

    public void setNilai(int nilai) {
        this.nilai = nilai;
    }
}
