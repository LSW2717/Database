package database.project.hospital_project.repository;

import database.project.hospital_project.entity.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    @Query("SELECT r FROM Reservation r WHERE r.patient.id = :patientId")
    List<Reservation> findAllByPatientId(Long patientId);
}
