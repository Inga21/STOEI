package com.bsuir.CourseWork.repository;

import com.bsuir.CourseWork.Domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);

    User findUserById(Long id);

    User findUserByActivationCode(String activationCode);

    List<User> findAllByFioContaining(String fio);

    User findUserByFio(String fio);


}
