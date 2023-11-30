package database.project.hospital_project.dto.requestDto;


import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ExaminationRequestDto {
    private LocalDateTime examinationDateTime;
    private String examinationDetails;
    private Long patientId;
}
