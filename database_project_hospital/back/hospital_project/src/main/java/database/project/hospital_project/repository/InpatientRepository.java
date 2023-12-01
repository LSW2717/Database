package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Inpatient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface InpatientRepository extends JpaRepository<Inpatient, Long> {
    @Query("SELECT i FROM Inpatient i WHERE i.patient.id = :patientId")
    Inpatient findByPatientId(Long patientId);
}
