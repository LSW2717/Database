package database.project.hospital_project.dto.responseDto;


import database.project.hospital_project.entity.Treatment;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class TreatmentResponseDto {
    private final Long id;
    private final LocalDateTime treatmentDateTime;
    private final String treatmentDetails;
    private final Long nurseId;
    private final PatientInfoResponseDto patient;

    public TreatmentResponseDto(Treatment treatment){
        this.id = treatment.getId();
        this.treatmentDateTime = treatment.getTreatmentDateTime();
        this.treatmentDetails = treatment.getTreatmentDetails();
        this.nurseId = treatment.getNurse().getId();
        this.patient = new PatientInfoResponseDto((treatment.getPatient()));
    }

}
