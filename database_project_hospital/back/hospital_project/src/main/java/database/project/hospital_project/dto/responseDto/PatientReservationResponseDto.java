package database.project.hospital_project.dto.responseDto;

import database.project.hospital_project.entity.Reservation;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class PatientReservationResponseDto {
    private final Long reservationId;
    private final LocalDateTime reservationDateTime;
    private final String departmentName;
    private final Long patientId;

    public PatientReservationResponseDto(Reservation reservation){
        this.reservationId = reservation.getReservationId();
        this.reservationDateTime = reservation.getReservationDateTime();
        this.departmentName = reservation.getDepartment().getName();
        this.patientId = reservation.getPatient().getId();
    }

}
