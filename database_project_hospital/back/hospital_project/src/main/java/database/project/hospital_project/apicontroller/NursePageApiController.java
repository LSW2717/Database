package database.project.hospital_project.apicontroller;


import database.project.hospital_project.dto.requestDto.TreatmentRequestDto;
import database.project.hospital_project.dto.responseDto.InpatientResponseDto;
import database.project.hospital_project.dto.responseDto.PatientInfoResponseDto;
import database.project.hospital_project.dto.responseDto.StaffWithPatientResponseDto;
import database.project.hospital_project.dto.responseDto.TreatmentResponseDto;
import database.project.hospital_project.service.NurseService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/nurse")
@RequiredArgsConstructor
public class NursePageApiController {
    private final NurseService nurseService;

    @GetMapping("/{nurseId}/treatments")
    public ResponseEntity<List<TreatmentResponseDto>> getAllTreatments(@PathVariable Long nurseId){
        List<TreatmentResponseDto> response = nurseService.getAllTreatmentsForNurse(nurseId);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/patients")
    public ResponseEntity<List<PatientInfoResponseDto>> getAllPatients(){
        List<PatientInfoResponseDto> response = nurseService.getAllPatients();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{nurseId}/patients")
    public ResponseEntity<StaffWithPatientResponseDto> getAllPatientsWithNurse(@PathVariable Long nurseId){
        StaffWithPatientResponseDto response = nurseService.getNurseWithPatients(nurseId);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/{nurseId}/treatments")
    public ResponseEntity<TreatmentResponseDto> createTreatment(@PathVariable Long nurseId, @RequestBody TreatmentRequestDto request){
        TreatmentResponseDto response = nurseService.createTreatment(nurseId, request);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @PutMapping("/{nurseId}/treatments/{treatmentId}")
    public ResponseEntity<TreatmentResponseDto> updateTreatment(@PathVariable Long nurseId, @PathVariable Long treatmentId, @RequestBody TreatmentRequestDto request){
        TreatmentResponseDto response = nurseService.updateTreatment(nurseId, treatmentId, request);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{nurseId}/treatments/{treatmentId}")
    public ResponseEntity<Void> deleteTreatment(@PathVariable Long nurseId, @PathVariable Long treatmentId){
        nurseService.deleteTreatment(nurseId, treatmentId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/inpatients")
    public ResponseEntity<List<InpatientResponseDto>> getAllInpatients(){
        List<InpatientResponseDto> response = nurseService.getAllInpatients();
        return ResponseEntity.ok(response);
    }


}
