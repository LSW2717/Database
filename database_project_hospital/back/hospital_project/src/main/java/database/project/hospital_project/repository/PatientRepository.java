package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
    @Query("SELECT p FROM Patient p JOIN FETCH p.staff s WHERE s.id = :staffId")
    List<Patient> findByStaffId(Long staffId);

    Patient findByUsername(String username);
}
