package database.project.hospital_project.service;

import database.project.hospital_project.repository.InpatientRepository;
import database.project.hospital_project.repository.PatientRepository;
import database.project.hospital_project.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PatientService {
    private final PatientRepository patientRepository;
    private final InpatientRepository inpatientRepository;
    private final ReservationRepository reservationRepository;

}
