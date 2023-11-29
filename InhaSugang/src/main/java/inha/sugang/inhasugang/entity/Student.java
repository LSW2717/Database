package inha.sugang.inhasugang.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @Column(name = "Sname", length = 20)
    private String sName;

    @Column(name = "Semail", length = 45)
    private String sEmail;

    @Column(name = "Sphonenum", length = 11)
    private String sPhoneNum;

    @Column(name = "Student_Number")
    private int studentNumber;

    @Column(name = "password", length = 20)
    private String password;

    @ManyToMany(mappedBy = "students", fetch = FetchType.EAGER)
    private List<Class> classes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Did")
    private Department department;

    public void setDepartment(Department department){
        this.department = department;
        department.getStudents().add(this);
    }
    public void addClass(Class classEntity) {
        if (this.classes == null) {
            this.classes = new ArrayList<>();
        }
        this.classes.add(classEntity);
    }

}
