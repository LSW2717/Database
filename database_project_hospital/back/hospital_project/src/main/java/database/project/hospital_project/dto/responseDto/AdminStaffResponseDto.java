package database.project.hospital_project.dto.responseDto;

import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalStaff;
import lombok.Getter;

@Getter
public class AdminStaffResponseDto {
    private final Long id;
    private final String name;
    private final String address;
    private final String phoneNumber;
    private final String username;
    private final String password;
    private final Erole role;
    private final String departmentName;

    public AdminStaffResponseDto(MedicalStaff medicalStaff){
        this.id = medicalStaff.getId();
        this.name = medicalStaff.getName();
        this.address = medicalStaff.getAddress();
        this.phoneNumber = medicalStaff.getPhoneNumber();
        this.username = medicalStaff.getUsername();
        this.password = medicalStaff.getPassword();
        this.role = medicalStaff.getRole();
        this.departmentName = medicalStaff.getDepartment().getName();
    }
}
