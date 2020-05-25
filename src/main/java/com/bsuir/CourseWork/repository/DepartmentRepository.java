package com.bsuir.CourseWork.repository;

import com.bsuir.CourseWork.Domain.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DepartmentRepository extends JpaRepository<Department,Long> {

    public Department findDepartmentById(Long id);
}