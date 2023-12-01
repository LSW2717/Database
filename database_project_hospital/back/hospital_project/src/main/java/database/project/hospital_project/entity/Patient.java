package database.project.hospital_project.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patient")
@Getter
@Setter
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "patient_id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "social_security_number")
    private String socialSecurityNumber;

    @Column(name = "gender")
    private String gender;

    @Column(name = "blood_type")
    private String bloodType;

    @Column(name = "height")
    private Float height;

    @Column(name = "weight")
    private Float weight;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @OneToOne(mappedBy = "patient", cascade = CascadeType.ALL)
    private Inpatient inpatient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "staff_id")
    private MedicalStaff staff;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Examination> examinations = new ArrayList<>();

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Treatment> treatments = new ArrayList<>();

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Reservation> reservations = new ArrayList<>();

    public void setInpatient(Inpatient inpatient){
        this.inpatient = inpatient;
        inpatient.setPatient(this);
    }
    public void setStaff(MedicalStaff staff){
        this.staff = staff;
        staff.getPatients().add(this);
    }
    public void addExamination(Examination examination){
        examinations.add(examination);
        examination.setPatient(this);
    }
    public void addTreatment(Treatment treatment){
        treatments.add(treatment);
        treatment.setPatient(this);
    }
    public void addReservation(Reservation reservation){
        reservations.add(reservation);
        reservation.setPatient(this);
    }
}
