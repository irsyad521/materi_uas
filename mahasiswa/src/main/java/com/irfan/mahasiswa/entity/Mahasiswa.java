
package com.irfan.mahasiswa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table
public class Mahasiswa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nama;
    private String email;
    private String tgllahir; // Ganti tipe data menjadi String

    public Mahasiswa() {
    }

    public Mahasiswa(Long id, String nama, String email, String tgllahir) {
        this.id = id;
        this.nama = nama;
        this.email = email;
        this.tgllahir = tgllahir;
    }

    public Mahasiswa(String nama, String email, String tgllahir) {
        this.nama = nama;
        this.email = email;
        this.tgllahir = tgllahir;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTgllahir() {
        return tgllahir;
    }

    public void setTgllahir(String tgllahir) {
        this.tgllahir = tgllahir;
    }

    @Override
    public String toString() {
        return "Mahasiswa{" + "id=" + id + ", nama=" + nama + ", email=" + email + ", tgllahir=" + tgllahir + '}';
    }
}
