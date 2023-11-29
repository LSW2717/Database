package database.project.hospital_project.apicontroller;


import database.project.hospital_project.dto.StaffResponseDto;
import database.project.hospital_project.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class adminPageApiController {
    private final AdminService adminService;

    @GetMapping("/doctors")
    public ResponseEntity<List<StaffResponseDto>> findAllDoctors(){
        List<StaffResponseDto> doctors = adminService.findAllDoctors();
        return ResponseEntity.ok(doctors);
    }

    @GetMapping("/nurses")
    public ResponseEntity<List<StaffResponseDto>> findAllNurses(){
        List<StaffResponseDto> nurses = adminService.findAllNurses();
        return ResponseEntity.ok(nurses);
    }
}
