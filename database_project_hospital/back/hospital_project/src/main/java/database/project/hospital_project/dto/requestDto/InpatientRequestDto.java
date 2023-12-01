package database.project.hospital_project.dto.requestDto;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class InpatientRequestDto {
    private String roomInformation;
    private LocalDateTime admissionDate;
    private LocalDateTime dischargeDateTime;
}
