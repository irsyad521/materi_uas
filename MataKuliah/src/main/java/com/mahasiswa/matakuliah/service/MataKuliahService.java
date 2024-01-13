package com.mahasiswa.matakuliah.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mahasiswa.matakuliah.repository.MataKuliahRepository;
import com.mahasiswa.matakuliah.model.MataKuliah;

import  java.util.List;


@Service
public class MataKuliahService {

    @Autowired
    private MataKuliahRepository mataKuliahRepository; // Ubah nama repositori sesuai perubahan nama entitas

    public List<MataKuliah> listAll(){
        return mataKuliahRepository.findAll();
    }

    public void save(MataKuliah mataKuliah){
        mataKuliahRepository.save(mataKuliah);
    }

    public MataKuliah get(Long id){
        return mataKuliahRepository.findById(id).get();
    }

    public void delete(Long id){
        mataKuliahRepository.deleteById(id);
    }

}
