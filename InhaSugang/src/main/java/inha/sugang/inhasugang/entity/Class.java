package inha.sugang.inhasugang.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Array;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
public class Class {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @Column(name = "Cid", length = 10)
    private String cId;

    @Column(name = "Name", length = 45)
    private String name;

    @Column(name = "Professor", length = 100)
    private String professor;

    @Column(name = "Number_of_participant")
    private int numberOfParticipant;

    @Column(name = "Remaining_participant")
    private Integer remainingParticipant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Bid")
    private Building building;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Did")
    private Department department;

    @ManyToMany
    @JoinTable(name = "class_student",
            joinColumns = @JoinColumn(name = "Class_id"),
            inverseJoinColumns = @JoinColumn(name = "Student_id")
    )
    private List<Student> students;

    //연관관계 맵핑
    public void setBuilding(Building building) {
        this.building = building;
        if (building != null && !building.getClasses().contains(this)) {
            building.getClasses().add(this);
        }
    }

    public void setDepartment(Department department) {
        this.department = department;
        department.getClasses().add(this);
    }
    public void addStudent(Student student) {
        if (this.students == null) {
            this.students = new ArrayList<>();
        }
        this.students.add(student);
    }

}
