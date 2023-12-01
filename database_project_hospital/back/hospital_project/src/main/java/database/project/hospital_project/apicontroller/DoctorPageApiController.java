package database.project.hospital_project.apicontroller;

import database.project.hospital_project.dto.requestDto.ExaminationRequestDto;
import database.project.hospital_project.dto.requestDto.InpatientRequestDto;
import database.project.hospital_project.dto.responseDto.ExaminationResponseDto;
import database.project.hospital_project.dto.responseDto.InpatientResponseDto;
import database.project.hospital_project.dto.responseDto.StaffWithPatientResponseDto;
import database.project.hospital_project.service.DoctorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/doctor")
@RequiredArgsConstructor
public class DoctorPageApiController {
    private final DoctorService doctorService;

    @GetMapping("/{doctorId}/examinations")
    public ResponseEntity<List<ExaminationResponseDto>> getAllExaminations(@PathVariable Long doctorId){
        List<ExaminationResponseDto> response = doctorService.getAllExaminationForDoctor(doctorId);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{doctorId}/patients")
    public ResponseEntity<StaffWithPatientResponseDto> getAllPatients(@PathVariable Long doctorId){
        StaffWithPatientResponseDto response = doctorService.getDoctorWithPatients(doctorId);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/{doctorId}/examinations")
    public ResponseEntity<ExaminationResponseDto> createExamination(@PathVariable Long doctorId, @RequestBody ExaminationRequestDto request){
        ExaminationResponseDto response = doctorService.createExamination(doctorId, request);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @PutMapping("/{doctorId}/examinations/{examinationId}")
    public ResponseEntity<ExaminationResponseDto> updateExamination(@PathVariable Long doctorId, @PathVariable Long examinationId, @RequestBody ExaminationRequestDto request){
        ExaminationResponseDto response = doctorService.updateExamination(doctorId, examinationId, request);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{doctorId}/examinations/{examinationId}")
    public ResponseEntity<Void> deleteExamination(@PathVariable Long doctorId, @PathVariable Long examinationId){
        doctorService.deleteExamination(doctorId, examinationId);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{patientId}")
    public ResponseEntity<InpatientResponseDto> admitPatient(@PathVariable Long patientId, InpatientRequestDto request){
        InpatientResponseDto response = doctorService.admitPatient(patientId, request);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @DeleteMapping("/{patientId}")
    public ResponseEntity<Void> dischargePatient(@PathVariable Long patientId){
        doctorService.dischargePatient(patientId);
        return ResponseEntity.noContent().build();
    }

}
