package com.bsuir.CourseWork.repository;

import com.bsuir.CourseWork.Domain.Company;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CompanyRepository extends JpaRepository <Company,Long> {
    Company findCompanyByCompanyTitle(String companyTitle);
}
