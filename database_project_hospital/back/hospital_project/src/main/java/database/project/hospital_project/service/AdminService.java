package database.project.hospital_project.service;

import database.project.hospital_project.dto.requestDto.StaffRequestDto;
import database.project.hospital_project.dto.responseDto.StaffResponseDto;
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

    public List<StaffResponseDto> getAllNurses() {
        List<MedicalStaff> nurses = medicalStaffRepository.findAllByRole(Erole.nurse);
        return nurses.stream()
                .map(StaffResponseDto::new)
                .collect(Collectors.toList());
    }

    public List<StaffResponseDto> getAllDoctors() {
        List<MedicalStaff> doctors = medicalStaffRepository.findAllByRole(Erole.doctor);
        return doctors.stream()
                .map(StaffResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public StaffResponseDto createStaff(StaffRequestDto request) {
        MedicalStaff staff = new MedicalStaff();
        return getStaffResponseDto(request, staff);
    }

    @Transactional
    public StaffResponseDto updateStaff(Long id, StaffRequestDto request) {
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

    private StaffResponseDto getStaffResponseDto(StaffRequestDto request, MedicalStaff staff) {
        staff.setName(request.getName());
        staff.setAddress(request.getAddress());
        staff.setPhoneNumber(request.getPhoneNumber());
        staff.setUsername(request.getUsername());
        staff.setPassword(request.getPassword());
        staff.setRole(request.getRole());

        if (request.getDepartmentName() != null) {
            MedicalSpecialty departmentName = medicalSpecialtyRepository.findByName(request.getDepartmentName())
                    .orElseThrow(() -> new RuntimeException("해당 부서가 없습니다."));
            staff.setDepartment(departmentName);
        }
        MedicalStaff updateStaff = medicalStaffRepository.save(staff);
        return new StaffResponseDto(updateStaff);
    }
}
