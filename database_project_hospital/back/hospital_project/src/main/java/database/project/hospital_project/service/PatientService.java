package database.project.hospital_project.service;

import database.project.hospital_project.dto.requestDto.PatientReservationRequestDto;
import database.project.hospital_project.dto.responseDto.PatientReservationResponseDto;
import database.project.hospital_project.entity.MedicalSpecialty;
import database.project.hospital_project.entity.Patient;
import database.project.hospital_project.entity.Reservation;
import database.project.hospital_project.repository.InpatientRepository;
import database.project.hospital_project.repository.MedicalSpecialtyRepository;
import database.project.hospital_project.repository.PatientRepository;
import database.project.hospital_project.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PatientService {
    private final PatientRepository patientRepository;
    private final ReservationRepository reservationRepository;
    private final MedicalSpecialtyRepository medicalSpecialtyRepository;

    public List<PatientReservationResponseDto> getReservationForPatient(Long patientId){
        List<Reservation> reservations = reservationRepository.findAllByPatientId(patientId);
        return reservations.stream()
                .map(PatientReservationResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public PatientReservationResponseDto createReservation(PatientReservationRequestDto request){
        Reservation reservation = new Reservation();
        reservation.setReservationDateTime(request.getReservationDateTime());
        reservation.setDepartment(medicalSpecialtyRepository.findByName(request.getDepartmentName()));
        Patient patient = patientRepository.findById(request.getPatientId())
                        .orElseThrow(() -> new RuntimeException("환자 id가 없습니다."));
        reservation.setPatient(patient);
        patient.addReservation(reservation);
        Reservation savedReservation = reservationRepository.save(reservation);
        return new PatientReservationResponseDto(savedReservation);
    }

    @Transactional
    public PatientReservationResponseDto updateReservation(Long reservationId, PatientReservationRequestDto request){
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new RuntimeException("해당하는 예약이 없습니다."));
        reservation.setReservationDateTime(request.getReservationDateTime());
        reservation.setDepartment(medicalSpecialtyRepository.findByName(request.getDepartmentName()));
        reservation.setPatient(patientRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("환자 아이디가 아닙니다.")));
        return new PatientReservationResponseDto(reservation);
    }

    @Transactional
    public void deleteReservation(Long reservationId){
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new RuntimeException("해당 예약이 없습니다."));
        reservationRepository.delete(reservation);
    }


}
