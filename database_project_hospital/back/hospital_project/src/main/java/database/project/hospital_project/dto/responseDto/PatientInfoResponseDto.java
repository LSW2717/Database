package database.project.hospital_project.dto.responseDto;

import database.project.hospital_project.entity.Patient;
import lombok.Getter;

@Getter
public class PatientInfoResponseDto {
    private final Long id;
    private final String name;
    private final String socialSecurityNumber;
    private final String gender;
    private final String bloodType;
    private final Float height;
    private final Float weight;
    private final
    String phoneNumber;

    public PatientInfoResponseDto(Patient patient){
        this.id = patient.getId();
        this.name = patient.getName();
        this.socialSecurityNumber = patient.getSocialSecurityNumber();
        this.gender = patient.getGender();
        this.bloodType = patient.getBloodType();
        this.height = patient.getHeight();
        this.weight = patient.getWeight();
        this.phoneNumber = patient.getPhoneNumber();
    }

}
