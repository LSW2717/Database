package database.project.hospital_project.dto.responseDto;


import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalStaff;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
public class StaffWithPatientResponseDto {
    private final Long id;
    private final String name;
    private final String address;
    private final String phoneNumber;
    private final String departmentName;
    private final Erole role;
    private final List<PatientInfoResponseDto> patients;

    public StaffWithPatientResponseDto(MedicalStaff medicalStaff){
        this.id = medicalStaff.getId();
        this.name = medicalStaff.getName();
        this.address = medicalStaff.getAddress();
        this.phoneNumber = medicalStaff.getPhoneNumber();
        this.departmentName = medicalStaff.getDepartment().getName();
        this.role = medicalStaff.getRole();
        this.patients = medicalStaff.getPatients().stream()
                .map(PatientInfoResponseDto::new)
                .collect(Collectors.toList());
    }
}
