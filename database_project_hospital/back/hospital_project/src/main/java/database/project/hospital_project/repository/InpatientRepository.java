package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Inpatient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InpatientRepository extends JpaRepository<Inpatient, Long> {
}
