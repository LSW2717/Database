package database.project.hospital_project.apicontroller;


import database.project.hospital_project.dto.requestDto.AdminStaffRequestDto;
import database.project.hospital_project.dto.responseDto.AdminStaffResponseDto;
import database.project.hospital_project.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminPageApiController {
    private final AdminService adminService;

    @GetMapping("/doctors")
    public ResponseEntity<List<AdminStaffResponseDto>> getAllDoctors(){
        List<AdminStaffResponseDto> doctors = adminService.getAllDoctors();
        return ResponseEntity.ok(doctors);
    }

    @GetMapping("/nurses")
    public ResponseEntity<List<AdminStaffResponseDto>> getAllNurses(){
        List<AdminStaffResponseDto> nurses = adminService.getAllNurses();
        return ResponseEntity.ok(nurses);
    }

    @PostMapping("/staff")
    public ResponseEntity<AdminStaffResponseDto> createStaff(@RequestBody AdminStaffRequestDto request){
        AdminStaffResponseDto response = adminService.createStaff(request);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }
    @PutMapping("/staff/{id}")
    public ResponseEntity<AdminStaffResponseDto> updateStaff(@PathVariable Long id, @RequestBody AdminStaffRequestDto request){
        AdminStaffResponseDto response = adminService.updateStaff(id, request);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/staff/{id}")
    public ResponseEntity<Void> deleteStaff(@PathVariable Long id){
        adminService.deleteStaff(id);
        return ResponseEntity.noContent().build();
    }
}
