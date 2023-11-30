package database.project.hospital_project.service;

import database.project.hospital_project.dto.requestDto.ExaminationRequestDto;
import database.project.hospital_project.dto.responseDto.ExaminationResponseDto;
import database.project.hospital_project.dto.responseDto.PatientInfoResponseDto;
import database.project.hospital_project.entity.Examination;
import database.project.hospital_project.entity.MedicalStaff;
import database.project.hospital_project.entity.Patient;
import database.project.hospital_project.repository.ExaminationRepository;
import database.project.hospital_project.repository.MedicalStaffRepository;
import database.project.hospital_project.repository.PatientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class DoctorService {
    private final MedicalStaffRepository medicalStaffRepository;
    private final ExaminationRepository examinationRepository;
    private final PatientRepository patientRepository;

    public List<ExaminationResponseDto> getAllExaminationForDoctor(Long doctorId){
        List<Examination> examinations = examinationRepository.findByDoctorId(doctorId);
        return examinations.stream()
                .map(ExaminationResponseDto::new)
                .collect(Collectors.toList());
    }
    public List<PatientInfoResponseDto> getAllPatientForDoctor(Long doctorId){
        List<Patient> patients = patientRepository.findByStaffId(doctorId);
        return patients.stream()
                .map(PatientInfoResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public ExaminationResponseDto createExamination(Long doctorId, ExaminationRequestDto request){
        MedicalStaff doctor = medicalStaffRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("해당 의사가 없습니다."));
        Patient patient = patientRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("해당 환자가 없습니다."));
        Examination examination = new Examination();
        examination.setExaminationDateTime(request.getExaminationDateTime());
        examination.setExaminationDetails(request.getExaminationDetails());
        examination.setDoctor(doctor);
        examination.setPatient(patient);

        Examination saveExamination = examinationRepository.save(examination);
        return new ExaminationResponseDto(saveExamination);
    }

    @Transactional
    public ExaminationResponseDto updateExamination(Long doctorId, Long examinationId, ExaminationRequestDto request){
        Examination examination = examinationRepository.findById(examinationId)
                .orElseThrow(() -> new RuntimeException("해당 검사가 없습니다."));
        Patient patient = patientRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("해당 환자가 없습니다."));
        examination.setExaminationDateTime(request.getExaminationDateTime());
        examination.setExaminationDetails(request.getExaminationDetails());
        examination.setPatient(patient);
        Examination updatedExamination = examinationRepository.save(examination);
        return new ExaminationResponseDto(updatedExamination);
    }

    @Transactional
    public void deleteExamination(Long doctorId, Long examinationId){
        Examination examination = examinationRepository.findById(examinationId)
                .orElseThrow(() -> new RuntimeException("해당 검사가 없습니다."));
        examinationRepository.delete(examination);
    }

}
