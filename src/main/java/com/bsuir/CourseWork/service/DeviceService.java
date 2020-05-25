
package com.bsuir.CourseWork.service;

import com.bsuir.CourseWork.Domain.Device;
import com.bsuir.CourseWork.repository.DeviceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeviceService {
    @Autowired
    DeviceRepository deviceRepository;

    public List<Device> getAllDevice() {
        return deviceRepository.findAll();
    }

    public void saveDevice(Device device) {
        deviceRepository.save(device);
    }

    public List<Device> getDeviceByUserId(long id) {
        return deviceRepository.getAllByUser(id);
    }

    public List<Device> findDeviceByPersonnelNumber(String personnel_number) {
        return deviceRepository.findDeviceByPersonnelNumber(personnel_number);
    }

    public Device findDeviceById(long id) {
        return deviceRepository.findDeviceById(id);
    }

    public void deviceDelete(long id) {
        Device device = deviceRepository.findDeviceById(id);
        deviceRepository.delete(device);
    }
}


