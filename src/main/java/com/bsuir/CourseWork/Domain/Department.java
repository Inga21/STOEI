package com.bsuir.CourseWork.Domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table (name = "department")
public class Department {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

   // @NotBlank(message = "Название отела не может быть пустым!")
    private String departmentTitle;
    //@NotBlank(message = "Номер отдела не может быть пустым!")
    private int numberRoom;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "company_id")
    private Company company;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<User> userList;

    public Department(String departmentTitle, int numberRoom)
    {
        this.departmentTitle = departmentTitle;
        this.numberRoom = numberRoom;
    }
}
