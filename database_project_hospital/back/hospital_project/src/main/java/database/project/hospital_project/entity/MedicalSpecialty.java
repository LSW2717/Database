package database.project.hospital_project.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "medical_specialty")
@Getter
@Setter
public class MedicalSpecialty {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "department_id")
    private Long id;

    @Column(name = "department_name")
    private String name;

    @Column(name = "phone_number")
    private String phoneNumber;

    @OneToMany(mappedBy = "department")
    private List<MedicalStaff> medicalStaffs = new ArrayList<>();

    @OneToMany(mappedBy = "department")
    private List<Reservation> reservations = new ArrayList<>();

    public void addMedicalStaff(MedicalStaff medicalStaff){
        medicalStaffs.add(medicalStaff);
        medicalStaff.setDepartment(this);
    }

    public void removeMedicalStaff(MedicalStaff medicalStaff){
        medicalStaffs.remove(medicalStaff);
        medicalStaff.setDepartment(this);
    }

    public void addReservation(Reservation reservation){
        reservations.add(reservation);
        reservation.setDepartment(this);
    }
}
