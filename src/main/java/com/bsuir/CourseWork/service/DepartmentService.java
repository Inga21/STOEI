package com.bsuir.CourseWork.service;

import com.bsuir.CourseWork.Domain.Department;
import com.bsuir.CourseWork.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DepartmentService {

    @Autowired
    DepartmentRepository departmentRepository;

    public void saveDepartment(Department department)
    {
        departmentRepository.save(department);
    }

    public Department findDepartmentById(Long id)
    {
        return departmentRepository.findDepartmentById(id);
    }

    public List<Department> getAll(){return departmentRepository.findAll();}
}
