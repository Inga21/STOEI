
package com.bsuir.CourseWork.repository;

import com.bsuir.CourseWork.Domain.Device;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeviceRepository extends JpaRepository <Device,Long> {
    List<Device> getAllByUser(long id);

    List <Device> findDeviceByPersonnelNumber(String personnel_number);

    Device findDeviceById(long id);
}

