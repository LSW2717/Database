package database.project.hospital_project.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "inpatient")
@Getter
@Setter
public class Inpatient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inpatient_id")
    private Long id;

    @Column(name = "room_information")
    private String roomInformation;

    @Column(name = "admission_date")
    private LocalDateTime admissionDate;

    @Column(name = "discharge_date_time")
    private LocalDateTime dischargeDateTime;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public void setPatient(Patient patient){
        this.patient = patient;
        patient.setInpatient(this);
    }

}
