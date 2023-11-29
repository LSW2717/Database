package database.project.hospital_project.dto;

import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalStaff;

public class StaffResponseDto {
    private Long id;
    private String name;
    private String address;
    private String phoneNumber;
    private String username;
    private Erole role;

    public StaffResponseDto(MedicalStaff medicalStaff){
        this.id = medicalStaff.getId();
        this.name = medicalStaff.getName();
        this.address = medicalStaff.getAddress();
        this.phoneNumber = medicalStaff.getPhoneNumber();
        this.username = medicalStaff.getUsername();
        this.role = medicalStaff.getRole();
    }
}
