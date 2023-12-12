package database.project.hospital_project.apicontroller;

import database.project.hospital_project.dto.requestDto.PatientReservationRequestDto;
import database.project.hospital_project.dto.responseDto.PatientInfoResponseDto;
import database.project.hospital_project.dto.responseDto.PatientReservationResponseDto;
import database.project.hospital_project.entity.Reservation;
import database.project.hospital_project.service.PatientService;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/patient")
@RequiredArgsConstructor
public class PatientPageApiController {
    private final PatientService patientService;

    @GetMapping("/{patientId}")
    public ResponseEntity<PatientInfoResponseDto> getPatientInfo(@PathVariable Long patientId){
        PatientInfoResponseDto response = patientService.getPatientInfo(patientId);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{patientId}/reservations")
    public ResponseEntity<List<PatientReservationResponseDto>> getPatientReservations(@PathVariable Long patientId){
        List<PatientReservationResponseDto> reservations = patientService.getReservationForPatient(patientId);
        return ResponseEntity.ok(reservations);
    }

    @PostMapping("/reservations")
    public ResponseEntity<PatientReservationResponseDto> createReservation(@RequestBody PatientReservationRequestDto request){
        PatientReservationResponseDto response = patientService.createReservation(request);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @PutMapping("/reservations/{reservationId}")
    public ResponseEntity<PatientReservationResponseDto> updateReservation(@PathVariable Long reservationId, @RequestBody PatientReservationRequestDto request){
        PatientReservationResponseDto response = patientService.updateReservation(reservationId, request);
        return ResponseEntity.ok(response);
    }
    @DeleteMapping("/reservations/{reservationId}")
    public ResponseEntity<Void> deleteReservation(@PathVariable Long reservationId){
        patientService.deleteReservation(reservationId);
        return ResponseEntity.noContent().build();
    }

}
