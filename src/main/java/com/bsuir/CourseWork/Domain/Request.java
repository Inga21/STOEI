
package com.bsuir.CourseWork.Domain;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Date;
import java.util.Objects;

@Entity
@Getter
@Setter
@Table(name = "request")
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    //тема
    @NotBlank(message = "Тема не может быть пустой!")
    private String subject;

    private Date dateCreate;
    private Date dateEnd;

    @Enumerated(EnumType.STRING)
    private Status status;
    @Enumerated(EnumType.STRING)
    private Priority priority;
    @Enumerated(EnumType.STRING)
    private Category category;

    //Последствия
    private String effects;
    //Описание
    @NotBlank(message = "Описание не может быть пустым!")
    private String description;

    //Заявитель
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User userApplicant;

    //Назначенный
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_fio")
    private User userAssigned;

    public Request() {
    }

    /*String oldstring = "2011-01-18 00:00:00.0";
    LocalDateTime datetime = LocalDateTime.parse(oldstring, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));*/

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Request)) return false;
        Request request = (Request) o;
        return Objects.equals(id, request.id) &&
                Objects.equals(subject, request.subject) &&
                status == request.status &&
                Objects.equals(dateCreate, request.dateCreate) &&
                Objects.equals(dateEnd, request.dateEnd) &&
                priority == request.priority &&
                Objects.equals(effects, request.effects) &&
                category == request.category &&
                Objects.equals(description, request.description) &&
                Objects.equals(userApplicant, request.userApplicant) &&
                Objects.equals(userAssigned, request.userAssigned);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, subject, status, dateCreate, dateEnd, priority, effects, category, description, userApplicant, userAssigned);
    }
}

