package database.project.hospital_project.dto.responseDto;

import database.project.hospital_project.entity.Inpatient;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class InpatientResponseDto {
    private final Long inpatientId;
    private final Long patientId;
    private final String roomInformation;
    private final LocalDateTime admissionDate;
    private final LocalDateTime dischargeDateTime;

    public InpatientResponseDto(Inpatient inpatient){
        this.inpatientId = inpatient.getId();
        this.patientId = inpatient.getPatient().getId();
        this.roomInformation = inpatient.getRoomInformation();
        this.admissionDate = inpatient.getAdmissionDate();
        this.dischargeDateTime = inpatient.getDischargeDateTime();
    }
}
