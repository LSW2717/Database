package database.project.hospital_project.apicontroller;


import database.project.hospital_project.dto.requestDto.StaffRequestDto;
import database.project.hospital_project.dto.responseDto.StaffResponseDto;
import database.project.hospital_project.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class adminPageApiController {
    private final AdminService adminService;

    @GetMapping("/doctors")
    public ResponseEntity<List<StaffResponseDto>> getAllDoctors(){
        List<StaffResponseDto> doctors = adminService.getAllDoctors();
        return ResponseEntity.ok(doctors);
    }

    @GetMapping("/nurses")
    public ResponseEntity<List<StaffResponseDto>> getAllNurses(){
        List<StaffResponseDto> nurses = adminService.getAllNurses();
        return ResponseEntity.ok(nurses);
    }

    @PostMapping("/staff")
    public ResponseEntity<StaffResponseDto> createStaff(@RequestBody StaffRequestDto request){
        StaffResponseDto response = adminService.createStaff(request);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }
    @PutMapping("/staff/{id}")
    public ResponseEntity<StaffResponseDto> updateStaff(@PathVariable Long id, @RequestBody StaffRequestDto request){
        StaffResponseDto response = adminService.updateStaff(id, request);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/staff/{id}")
    public ResponseEntity<Void> deleteStaff(@PathVariable Long id){
        adminService.deleteStaff(id);
        return ResponseEntity.noContent().build();
    }
}
