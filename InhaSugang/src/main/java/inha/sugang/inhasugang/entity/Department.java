package inha.sugang.inhasugang.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
public class Department {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Did", length = 10)
    private String dId;

    @Column(name = "Dname", length = 100)
    private String dName;

    @Column(name = "Demail", length = 45)
    private String dEmail;

    @Column(name = "Dphonenum", length = 10)
    private String dPhoneNum;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Bid")
    private Building building;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Rid")
    private Room room;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL)
    private List<Student> students = new ArrayList<>();

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL)
    private List<Class> classes = new ArrayList<>();

    public void setBuilding(Building building){
        this.building = building;
        building.getDepartments().add(this);
    }
    public void setRoom(Room room){
        this.room = room;
        room.getDepartments().add(this);
    }
    public void addStudent(Student student){
        students.add(student);
        student.setDepartment(this);
    }
    public void addClass(Class lecture){
        classes.add(lecture);
        lecture.setDepartment(this);
    }

}
