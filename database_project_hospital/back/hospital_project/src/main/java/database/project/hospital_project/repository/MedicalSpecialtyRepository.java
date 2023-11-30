package database.project.hospital_project.repository;

import database.project.hospital_project.entity.MedicalSpecialty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MedicalSpecialtyRepository extends JpaRepository<MedicalSpecialty, Long> {
        Optional<MedicalSpecialty> findByName(String name);
}
