package database.project.hospital_project.dto.responseDto;


import database.project.hospital_project.entity.Examination;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ExaminationResponseDto {
    private final Long id;
    private final LocalDateTime examinationDateTime;
    private final String examinationDetails;
    private final Long doctorId;
    private final Long patientId;

    public ExaminationResponseDto(Examination examination){
        this.id = examination.getId();
        this.examinationDateTime = examination.getExaminationDateTime();
        this.examinationDetails = examination.getExaminationDetails();
        this.doctorId = examination.getDoctor().getId();
        this.patientId = examination.getPatient().getId();
    }
}
