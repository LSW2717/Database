package inha.sugang.inhasugang.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Rid", length = 10)
    private String rId;

    @Column(name = "Rname", length = 100)
    private String rName;

    @Column(name = "capacity")
    private int capacity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Bid")
    private Building building;

    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL)
    private List<Department> departments = new ArrayList<>();

    public void setBuilding(Building building){
        this.building = building;
        building.getRooms().add(this);
    }
    public void addDepartment(Department department){
        departments.add(department);
        department.setRoom(this);
    }

}
