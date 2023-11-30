package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Examination;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExaminationRepository extends JpaRepository<Examination, Long> {
    @Query("SELECT e FROM Examination e WHERE e.doctor.id = :doctorId")
    List<Examination> findByDoctorId(Long doctorId);
}
