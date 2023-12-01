package database.project.hospital_project.dto.requestDto;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class PatientReservationRequestDto {
    private LocalDateTime reservationDateTime;
    private String departmentName;
    private Long patientId;
}
