package database.project.hospital_project.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "reservation")
@Getter
@Setter
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reservation_number")
    private Long reservationNumber;

    @Column(name = "reservation_date_time")
    private LocalDateTime reservationDateTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private MedicalSpecialty department;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public void setDepartment(MedicalSpecialty department){
        this.department = department;
        department.getReservations().add(this);
    }
    public void setPatient(Patient patient){
        this.patient = patient;
        patient.getReservations().add(this);
    }
}
