package database.project.hospital_project.service;


import database.project.hospital_project.dto.requestDto.LoginRequestDto;
import database.project.hospital_project.dto.responseDto.LoginResponseDto;
import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalStaff;
import database.project.hospital_project.entity.Patient;
import database.project.hospital_project.repository.MedicalStaffRepository;
import database.project.hospital_project.repository.PatientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LoginService {
    private final MedicalStaffRepository medicalStaffRepository;
    private final PatientRepository patientRepository;

    public LoginResponseDto login(LoginRequestDto request) {
        String username = request.getUsername();
        String password = request.getPassword();

        // MedicalStaff에서 사용자 검색
        Optional<MedicalStaff> staff = Optional.ofNullable(medicalStaffRepository.findByUsername(username));
        if (staff.isPresent() && staff.get().getPassword().equals(password)) {
            String userType = getUserType(staff.get().getRole());
            return new LoginResponseDto(username, userType);
        }

        // Patient에서 사용자 검색
        Optional<Patient> patient = Optional.ofNullable(patientRepository.findByUsername(username));
        if (patient.isPresent() && patient.get().getPassword().equals(password)) {
            return new LoginResponseDto(username, "Patient");
        }

        throw new RuntimeException("Invalid username or password");
    }

    private String getUserType(Erole role) {
        return switch (role) {
            case DOCTOR -> "Doctor";
            case NURSE -> "Nurse";
            case ADMIN -> "Admin";
            default -> throw new IllegalArgumentException("Unknown role: " + role);
        };
    }
}
