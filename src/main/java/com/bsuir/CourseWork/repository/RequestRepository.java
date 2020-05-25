
package com.bsuir.CourseWork.repository;

import com.bsuir.CourseWork.Domain.Request;
import com.bsuir.CourseWork.Domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RequestRepository extends JpaRepository <Request,Long> {
    Request findRequestById(Long id);
    List <Request> findRequestByUserAssigned(User user);
    List <Request> findRequestByUserApplicant(User user);
}

