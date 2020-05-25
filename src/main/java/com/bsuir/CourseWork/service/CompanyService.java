package com.bsuir.CourseWork.service;

import com.bsuir.CourseWork.Domain.Company;
import com.bsuir.CourseWork.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CompanyService {
    @Autowired
    CompanyRepository companyRepository;

    public List<Company> getAllCompany()
    {
        return companyRepository.findAll();
    }

    public Company findByCompanyTitle(String companyTitle)
    {
        return companyRepository.findCompanyByCompanyTitle(companyTitle);
    }
}
