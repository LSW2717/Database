package database.project.hospital_project.service;

import database.project.hospital_project.dto.requestDto.ExaminationRequestDto;
import database.project.hospital_project.dto.requestDto.TreatmentRequestDto;
import database.project.hospital_project.dto.responseDto.*;
import database.project.hospital_project.entity.*;
import database.project.hospital_project.repository.InpatientRepository;
import database.project.hospital_project.repository.MedicalStaffRepository;
import database.project.hospital_project.repository.PatientRepository;
import database.project.hospital_project.repository.TreatmentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class NurseService {
    private final MedicalStaffRepository medicalStaffRepository;
    private final TreatmentRepository treatmentRepository;
    private final PatientRepository patientRepository;
    private final InpatientRepository inpatientRepository;

    public List<TreatmentResponseDto> getAllTreatmentsForNurse(Long nurseId) {
        List<Treatment> treatments = treatmentRepository.findAllByNurseId(nurseId);
        return treatments.stream()
                .map(TreatmentResponseDto::new)
                .collect(Collectors.toList());
    }

    public StaffWithPatientResponseDto getNurseWithPatients(Long nurseId) {
        MedicalStaff nurse = medicalStaffRepository.findById(nurseId)
                .orElseThrow(() -> new RuntimeException("해당 간호사가 없습니다."));
        return new StaffWithPatientResponseDto(nurse);
    }

    public List<PatientInfoResponseDto> getAllPatients(){
        List<Patient> patients = patientRepository.findAll();
        return patients.stream()
                .map(PatientInfoResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public TreatmentResponseDto createTreatment(Long nurseId, TreatmentRequestDto request) {
        MedicalStaff nurse = medicalStaffRepository.findById(nurseId)
                .orElseThrow(() -> new RuntimeException("해당 간호사가 없습니다."));
        Patient patient = patientRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("해당 환자가 없습니다."));
        Treatment treatment = new Treatment();
        treatment.setTreatmentDateTime(request.getTreatmentDateTime());
        treatment.setTreatmentDetails(request.getTreatmentDetails());
        treatment.setNurse(nurse);
        treatment.setPatient(patient);
        nurse.addTreatment(treatment);
        patient.addTreatment(treatment);
        Treatment saveTreatment = treatmentRepository.save(treatment);
        return new TreatmentResponseDto(saveTreatment);
    }

    @Transactional
    public TreatmentResponseDto updateTreatment(Long nurseId, Long treatmentId, TreatmentRequestDto request) {
        Treatment treatment = treatmentRepository.findById(treatmentId)
                .orElseThrow(() -> new RuntimeException("해당 치료가 없습니다."));

        if (!treatment.getNurse().getId().equals(nurseId)) {
            throw new RuntimeException("해당 간호사의 치료가 아닙니다.");
        }

        Patient patient = patientRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("해당 환자가 없습니다."));
        treatment.setTreatmentDateTime(request.getTreatmentDateTime());
        treatment.setTreatmentDetails(request.getTreatmentDetails());
        treatment.setPatient(patient);
        return new TreatmentResponseDto(treatment);
    }

    @Transactional
    public void deleteTreatment(Long nurseId, Long treatmentId) {
        Treatment treatment = treatmentRepository.findById(treatmentId)
                .orElseThrow(() -> new RuntimeException("해당 치료가 없습니다."));

        if (!treatment.getNurse().getId().equals(nurseId)) {
            throw new RuntimeException("해당 간호사의 치료가 아닙니다.");
        }
        treatmentRepository.delete(treatment);
    }

    public List<InpatientResponseDto> getAllInpatients() {
        List<Inpatient> inpatients = inpatientRepository.findAll();
        return inpatients.stream()
                .map(InpatientResponseDto::new)
                .collect(Collectors.toList());
    }


}
