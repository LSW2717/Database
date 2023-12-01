package database.project.hospital_project.dto.requestDto;

import database.project.hospital_project.entity.Erole;
import lombok.Getter;


@Getter
public class AdminStaffRequestDto {
    private String name;
    private String address;
    private String phoneNumber;
    private String username;
    private String password;
    private Erole role;
    private String departmentName;
}
