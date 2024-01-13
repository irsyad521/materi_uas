package com.nilai.nilai.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.nilai.nilai.model.Nilai;

@Repository
public interface NilaiRepository extends JpaRepository<Nilai, Integer> {

}
