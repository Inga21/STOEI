package com.bsuir.CourseWork.Domain;

import org.hibernate.validator.constraints.Length;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.*;
import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.Set;

@Entity
@Getter
@Setter
@Table (name = "user")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    @Email(message = "Логин не корректен")
    @NotBlank(message = "Логин не может быть пустым!")
    private String username;
    private String password;
    private boolean active;

    @NotBlank(message = "ФИО не может быть пустым!")
    private String fio;
    @Length(max = 20, message = "Слишком много символов!")
    private String telephoneMobile;
    @Length(max = 10, message = "Слишком много символов!")
    @NotBlank(message = "Рабочий телефон не может быть пустым!")
    private String telephoneWork;
    private String activationCode;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)//Подгружаем данные со свзянной таблицы, Eager полная подгрузка, лайзи - по обращению
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))//Указываем через что будет происходить подгрузка
    @Enumerated (EnumType.STRING)
    private Set<Role> roles;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id")
    private Department department;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Device> deviceList;

    @OneToMany(mappedBy = "userApplicant", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Request> requestListApplicant;

   @OneToMany(mappedBy = "userAssigned", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Request> requestListAssigned;

    public User(){}

    public boolean isAdmin(){
        return roles.contains(Role.ADMIN);
    }

    public boolean isSuperAdmin(){
        return roles.contains(Role.SUPER_ADMIN);
    }

    public boolean isSuper_Admin(){
        return roles.contains(Role.SUPER_ADMIN);
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return active == user.active &&
                Objects.equals(id, user.id) &&
                Objects.equals(username, user.username) &&
                Objects.equals(password, user.password) &&
                Objects.equals(fio, user.fio) &&
                Objects.equals(telephoneMobile, user.telephoneMobile) &&
                Objects.equals(telephoneWork, user.telephoneWork) &&
                Objects.equals(activationCode, user.activationCode) &&
                Objects.equals(roles, user.roles) &&
                Objects.equals(department, user.department) &&
                Objects.equals(deviceList, user.deviceList) &&
                Objects.equals(requestListApplicant, user.requestListApplicant) &&
                Objects.equals(requestListAssigned, user.requestListAssigned);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, username, password, active, fio, telephoneMobile, telephoneWork, activationCode, roles, department, deviceList, requestListApplicant, requestListAssigned);
    }
}