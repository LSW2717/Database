package database.project.hospital_project.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "medical_staff")
@Getter
@Setter
public class MedicalStaff {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "staff_id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "address")
    private String address;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Enumerated(EnumType.STRING)
    @Column(name = "role")
    private Erole role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private MedicalSpecialty department;

    @OneToMany(mappedBy = "staff")
    private List<Patient> patients = new ArrayList<>();

    @OneToMany(mappedBy = "doctor")
    private List<Examination> examinations = new ArrayList<>();

    @OneToMany(mappedBy = "nurse")
    private List<Treatment> treatments = new ArrayList<>();


    public void setDepartment(MedicalSpecialty department){
        this.department = department;
        department.getMedicalStaffs().add(this);
    }
    public void addPatient(Patient patient){
        patients.add(patient);
        patient.setStaff(this);
    }
    public void addExamination(Examination examination){
        examinations.add(examination);
        examination.setDoctor(this);
    }
    public void addTreatment(Treatment treatment){
        treatments.add(treatment);
        treatment.setNurse(this);
    }






}
