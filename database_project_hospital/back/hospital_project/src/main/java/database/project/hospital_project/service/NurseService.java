package database.project.hospital_project.service;

import database.project.hospital_project.repository.MedicalSpecialtyRepository;
import database.project.hospital_project.repository.MedicalStaffRepository;
import database.project.hospital_project.repository.TreatmentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class NurseService {
    private final MedicalSpecialtyRepository medicalSpecialtyRepository;
    private final MedicalStaffRepository medicalStaffRepository;
    private final TreatmentRepository treatmentRepository;
}
