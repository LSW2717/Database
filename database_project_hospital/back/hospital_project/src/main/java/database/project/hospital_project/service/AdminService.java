package database.project.hospital_project.service;

import database.project.hospital_project.dto.StaffResponseDto;
import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalStaff;
import database.project.hospital_project.repository.MedicalStaffRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class AdminService {
    private final MedicalStaffRepository medicalStaffRepository;

    public List<StaffResponseDto> findAllNurses() {
        List<MedicalStaff> nurses = medicalStaffRepository.findAllByRole(Erole.nurse);
        return nurses.stream()
                .map(StaffResponseDto::new)
                .collect(Collectors.toList());
    }

    public List<StaffResponseDto> findAllDoctors() {
        List<MedicalStaff> doctors = medicalStaffRepository.findAllByRole(Erole.doctor);
        return doctors.stream()
                .map(StaffResponseDto::new)
                .collect(Collectors.toList());
    }


}
