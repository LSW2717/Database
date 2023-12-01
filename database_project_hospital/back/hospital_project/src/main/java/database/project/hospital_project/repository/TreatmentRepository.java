package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Treatment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TreatmentRepository extends JpaRepository<Treatment, Long> {

    @Query("SELECT t FROM Treatment t WHERE t.nurse.id = :nurseId")
    List<Treatment> findAllByNurseId(Long nurseId);
}
