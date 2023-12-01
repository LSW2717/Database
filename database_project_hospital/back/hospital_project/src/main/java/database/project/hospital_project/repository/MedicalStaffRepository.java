package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalStaff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MedicalStaffRepository extends JpaRepository<MedicalStaff, Long> {

    List<MedicalStaff> findAllByRole(Erole role);
    MedicalStaff findByUsername(String username);
}
