package inha.sugang.inhasugang.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Entity
@Getter @Setter
public class Building {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "Bid")
    private int bId;

    @Column(name = "Bname", length = 20)
    private String bName;

    @OneToMany(mappedBy = "building", cascade = CascadeType.ALL)
    private List<Class> classes = new ArrayList<>();

    @OneToMany(mappedBy = "building", cascade = CascadeType.ALL)
    private List<Department> departments = new ArrayList<>();

    @OneToMany(mappedBy = "building", cascade = CascadeType.ALL)
    private List<Room> rooms = new ArrayList<>();
}
