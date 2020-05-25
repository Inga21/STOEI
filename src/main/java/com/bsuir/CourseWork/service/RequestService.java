
package com.bsuir.CourseWork.service;

import com.bsuir.CourseWork.Domain.Request;
import com.bsuir.CourseWork.Domain.Status;
import com.bsuir.CourseWork.Domain.User;
import com.bsuir.CourseWork.repository.RequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class RequestService {
    @Autowired
    RequestRepository requestRepository;

    public List<Request> findReqestForUser(User user)
    {
        return requestRepository.findRequestByUserApplicant(user);
    }

    public List<Request> findAllRequest()
    {
        return requestRepository.findAll();
    }

    public Request findRequestById(Long id) {
        return requestRepository.findRequestById(id);
    }

    public void saveRequest(Request request)
    {
        requestRepository.save(request);
    }

    public List <Request> findMyRequest(User user)
    {
        List <Request> requests = requestRepository.findRequestByUserAssigned(user);
        Collections.reverse(requests);
        return requests;

    }

    public List <Request> findUnassignedRequest()
    {
        List <Request> requestList = requestRepository.findAll();
        List <Request> requests = requestList.stream().filter(req -> req.getUserAssigned()==null).collect(Collectors.toList());
        Collections.reverse(requests);
        return requests;
    }

    public List <Request> findAdminAndOpenRequest(User user)
    {
        List <Request> requestList = requestRepository.findRequestByUserAssigned(user);
        List <Request> requests = requestList.stream().filter(req-> req.getStatus().name().equals("Работа")).collect(Collectors.toList());
        Collections.reverse(requests);
        return requests;
    }

    public List <Request> findMyCloseRequest(User user)
    {
        List <Request> requestList = requestRepository.findRequestByUserAssigned(user);
        List <Request> requests = requestList.stream().filter(req-> req.getStatus().name().equals("Закрыто")).collect(Collectors.toList());
        Collections.reverse(requests);
        return requests;
    }

    public List <Request> findAllCloseRequest()
    {
        List <Request> requestList = requestRepository.findAll();
        List <Request> requests = requestList.stream().filter(req-> req.getStatus().name().equals("Закрыто")).collect(Collectors.toList());
        Collections.reverse(requests);
        return requests;
    }

    public List <Request> findRequestByIdList(Long id)
    {
        List <Request> requestList = new ArrayList<>();
        requestList.add(requestRepository.findRequestById(id));
        return requestList;
    }
    public String pauseStatusRequest(long id, User user)
    {
        Request request = requestRepository.findRequestById(id);
       // if(request.getStatus().name().equals(Status.Работа)) {
            request.setStatus(Status.Пауза);

            return "Успешно приостановлено";
        //}
       // return "Не удалось приостановить";
    }
    public String inWorkStatusRequest(long id, User user)
    {
        Request request = requestRepository.findRequestById(id);
        //if(user.equals(request.getUserAssigned()) && request.getStatus().name().equals(Status.Пауза)) {
            request.setStatus(Status.Работа);
            return "Успешно возобновлено";
        //}
        //return "Не удалось возобновить";
    }
}

