package database.project.hospital_project.service;

import database.project.hospital_project.dto.requestDto.AdminStaffRequestDto;
import database.project.hospital_project.dto.responseDto.AdminStaffResponseDto;
import database.project.hospital_project.entity.Erole;
import database.project.hospital_project.entity.MedicalSpecialty;
import database.project.hospital_project.entity.MedicalStaff;
import database.project.hospital_project.repository.MedicalSpecialtyRepository;
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
    private final MedicalSpecialtyRepository medicalSpecialtyRepository;

    public List<AdminStaffResponseDto> getAllNurses() {
        List<MedicalStaff> nurses = medicalStaffRepository.findAllByRole(Erole.NURSE);
        return nurses.stream()
                .map(AdminStaffResponseDto::new)
                .collect(Collectors.toList());
    }

    public List<AdminStaffResponseDto> getAllDoctors() {
        List<MedicalStaff> doctors = medicalStaffRepository.findAllByRole(Erole.DOCTOR);
        return doctors.stream()
                .map(AdminStaffResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public AdminStaffResponseDto createStaff(AdminStaffRequestDto request) {
        MedicalStaff staff = new MedicalStaff();
        return getStaffResponseDto(request, staff);
    }

    @Transactional
    public AdminStaffResponseDto updateStaff(Long id, AdminStaffRequestDto request) {
        MedicalStaff staff = medicalStaffRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("해당하는 직원이 없습니다."));
        return getStaffResponseDto(request, staff);
    }

    @Transactional
    public void deleteStaff(Long id) {
        MedicalStaff staff = medicalStaffRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("해당하는 직원이 없습니다."));
        medicalStaffRepository.delete(staff);
    }

    private AdminStaffResponseDto getStaffResponseDto(AdminStaffRequestDto request, MedicalStaff staff) {
        staff.setName(request.getName());
        staff.setAddress(request.getAddress());
        staff.setPhoneNumber(request.getPhoneNumber());
        staff.setUsername(request.getUsername());
        staff.setPassword(request.getPassword());
        staff.setRole(request.getRole());

        if (request.getDepartmentName() != null) {
            MedicalSpecialty departmentName = medicalSpecialtyRepository.findByName(request.getDepartmentName());
            staff.setDepartment(departmentName);
        }
        MedicalStaff updateStaff = medicalStaffRepository.save(staff);
        if (request.getDepartmentName() != null){
            MedicalSpecialty department = medicalSpecialtyRepository.findByName(request.getDepartmentName());
            department.addMedicalStaff(updateStaff);
        }
        return new AdminStaffResponseDto(updateStaff);
    }
}
