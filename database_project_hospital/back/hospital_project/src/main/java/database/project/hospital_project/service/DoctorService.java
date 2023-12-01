package database.project.hospital_project.service;

import database.project.hospital_project.dto.requestDto.ExaminationRequestDto;
import database.project.hospital_project.dto.requestDto.InpatientRequestDto;
import database.project.hospital_project.dto.responseDto.ExaminationResponseDto;
import database.project.hospital_project.dto.responseDto.InpatientResponseDto;
import database.project.hospital_project.dto.responseDto.PatientInfoResponseDto;
import database.project.hospital_project.dto.responseDto.StaffWithPatientResponseDto;
import database.project.hospital_project.entity.Examination;
import database.project.hospital_project.entity.Inpatient;
import database.project.hospital_project.entity.MedicalStaff;
import database.project.hospital_project.entity.Patient;
import database.project.hospital_project.repository.ExaminationRepository;
import database.project.hospital_project.repository.InpatientRepository;
import database.project.hospital_project.repository.MedicalStaffRepository;
import database.project.hospital_project.repository.PatientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class DoctorService {
    private final MedicalStaffRepository medicalStaffRepository;
    private final ExaminationRepository examinationRepository;
    private final PatientRepository patientRepository;
    private final InpatientRepository inpatientRepository;

    public List<ExaminationResponseDto> getAllExaminationForDoctor(Long doctorId){
        List<Examination> examinations = examinationRepository.findByDoctorId(doctorId);
        return examinations.stream()
                .map(ExaminationResponseDto::new)
                .collect(Collectors.toList());
    }
    public StaffWithPatientResponseDto getDoctorWithPatients(Long doctorId){
        MedicalStaff doctor = medicalStaffRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("해당 의사가 없습니다."));
        return new StaffWithPatientResponseDto(doctor);
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
        doctor.addExamination(examination);
        patient.addExamination(examination);
        Examination saveExamination = examinationRepository.save(examination);
        return new ExaminationResponseDto(saveExamination);
    }

    @Transactional
    public ExaminationResponseDto updateExamination(Long doctorId, Long examinationId, ExaminationRequestDto request){
        Examination examination = examinationRepository.findById(examinationId)
                .orElseThrow(() -> new RuntimeException("해당 검사가 없습니다."));

        if (!examination.getDoctor().getId().equals(doctorId)) {
            throw new RuntimeException("해당 의사의 검사가 아닙니다.");
        }

        Patient patient = patientRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("해당 환자가 없습니다."));
        examination.setExaminationDateTime(request.getExaminationDateTime());
        examination.setExaminationDetails(request.getExaminationDetails());
        examination.setPatient(patient);
        return new ExaminationResponseDto(examination);
    }

    @Transactional
    public void deleteExamination(Long doctorId, Long examinationId){
        Examination examination = examinationRepository.findById(examinationId)
                .orElseThrow(() -> new RuntimeException("해당 검사가 없습니다."));

        if (!examination.getDoctor().getId().equals(doctorId)) {
            throw new RuntimeException("해당 의사의 검사가 아닙니다.");
        }

        examinationRepository.delete(examination);
    }

    @Transactional
    public InpatientResponseDto admitPatient(Long patientId, InpatientRequestDto request){
        Patient patient = patientRepository.findById(patientId)
                .orElseThrow(() -> new RuntimeException("해당 환자가 없습니다."));
        if (patient.getInpatient() != null) {
            throw new IllegalStateException("Patient is already admitted");
        }
        Inpatient inpatient = new Inpatient();
        inpatient.setPatient(patient);
        inpatient.setRoomInformation(request.getRoomInformation());
        inpatient.setAdmissionDate(request.getAdmissionDate());
        inpatient.setDischargeDateTime(request.getDischargeDateTime());
        Inpatient savedInpatient = inpatientRepository.save(inpatient);
        return new InpatientResponseDto(savedInpatient);
    }

    @Transactional
    public void dischargePatient(Long patientId){
        Inpatient inpatient = inpatientRepository.findByPatientId(patientId);
        inpatientRepository.delete(inpatient);
    }


}
