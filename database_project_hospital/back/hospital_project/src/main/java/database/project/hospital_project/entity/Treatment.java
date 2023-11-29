package database.project.hospital_project.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table (name = "treatment")
@Getter
@Setter
public class Treatment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "treatment_id")
    private Long id;

    @Column(name = "treatment_date_time")
    private LocalDateTime treatmentDateTime;

    @Column(name = "treatment_details", columnDefinition="TEXT")
    private String treatmentDetails;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nurse_id")
    private MedicalStaff nurse;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public void setNurse(MedicalStaff nurse){
        this.nurse = nurse;
        nurse.getTreatments().add(this);
    }

    public void setPatient(Patient patient){
        this.patient = patient;
        patient.getTreatments().add(this);
    }

}
