package database.project.hospital_project.dto.requestDto;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class TreatmentRequestDto {
    private LocalDateTime treatmentDateTime;
    private String treatmentDetails;
    private Long patientId;
}
