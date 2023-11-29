package database.project.hospital_project.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "examination")
@Getter
@Setter
public class Examination {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "examination_id")
    private Long id;

    @Column(name = "examination_date_time")
    private LocalDateTime examinationDateTime;

    @Column(columnDefinition="TEXT", name = "examination_details")
    private String examinationDetails;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private MedicalStaff doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public void setDoctor(MedicalStaff doctor){
        this.doctor = doctor;
        doctor.getExaminations().add(this);
    }
    public void setPatient(Patient patient){
        this.patient = patient;
        patient.getExaminations().add(this);
    }




}
