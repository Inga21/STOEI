package com.bsuir.CourseWork.service;

import com.bsuir.CourseWork.Domain.Priority;
import com.bsuir.CourseWork.Domain.Request;
import com.bsuir.CourseWork.Domain.Status;
import com.bsuir.CourseWork.Domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class SummaryService {
    @Autowired
    UserService userService;
    @Autowired
    RequestService requestService;

    public LinkedHashMap<String, List<Long>> getSummaryBySpecialist() {
        LinkedHashMap<String, List<Long>> map = new LinkedHashMap<>();
        List<User> adminList = userService.findAllAdmin();
        Long totalWork = Long.valueOf(0);
        Long totalPause = Long.valueOf(0);
        Long totalClose = Long.valueOf(0);

        for (User user : adminList) {
            List<Long> sum = new ArrayList<>();
            Long inWork = user.getRequestListAssigned().stream().filter(request -> request.getStatus().name().equals("Работа")).count();
            Long inPause = user.getRequestListAssigned().stream().filter(request -> request.getStatus().name().equals("Пауза")).count();
            Long inClose = user.getRequestListAssigned().stream().filter(request -> request.getStatus().name().equals("Закрыто")).count();

            totalWork += inWork;
            totalPause += inPause;
            totalClose += inClose;

            sum.add(inWork);
            sum.add(inPause);
            sum.add(inClose);
            map.put(user.getFio(), sum);
        }
        List<Long> total = new ArrayList<>();

        total.add(totalWork);
        total.add(totalPause);
        total.add(totalClose);
        map.put("Всего", total);

        return map;
    }


    public Map <String, Integer> getNumberOfTaskByCompany()
    {
        int countBemn = 0;
        int countAtom = 0;
        int countBaza = 0;
        Map<String,Integer> map = new HashMap<>();
        List <User> userList = userService.getAllUsers();
        for (User user : userList) {
            if(!user.getRequestListAssigned().equals(null)) {
                if(user.getDepartment().getCompany().getCompanyTitle().equals("Бемн")) {
                    countBemn += user.getRequestListApplicant().stream().count();
                }
                if(user.getDepartment().getCompany().getCompanyTitle().equals("База")) {
                    countBaza += user.getRequestListApplicant().stream().count();
                }
                if(user.getDepartment().getCompany().getCompanyTitle().equals("Атомка")){
                    countAtom += user.getRequestListApplicant().stream().count();
                }
            }
            map.put("Бемн",countBemn);
            map.put("База",countBaza);
            map.put("Атомка",countAtom);
        }
        return map;
    }

    public LinkedHashMap<String, List<Long>> getNumberOfTaskByStatus() {
        LinkedHashMap<String, List<Long>> map = new LinkedHashMap<>();
        List<Request> requestList = requestService.findAllRequest();
        List<Request> requestInWork = requestList.stream().filter(request -> request.getStatus().name().equals("Работа")).collect(Collectors.toList());
        List<Request> requestInPause = requestList.stream().filter(request -> request.getStatus().name().equals("Пауза")).collect(Collectors.toList());
        List <Request> requestInClose = requestList.stream().filter(request -> request.getStatus().name().equals("Закрыто")).collect(Collectors.toList());
        List<Long> longListVeryLow = new ArrayList<>();
        List<Long> longListLow = new ArrayList<>();
        List<Long> longListUsually = new ArrayList<>();
        List<Long> longListHigh = new ArrayList<>();
        List<Long> longListUrgency = new ArrayList<>();
        Long totalWork = Long.valueOf(0);
        Long totalPause = Long.valueOf(0);
        Long totalClose = Long.valueOf(0);

        Long inWorkVeryLow = requestInWork.stream().filter(req -> req.getPriority().name()=="Самый_Низкий").count();
        Long inWorkLow = requestInWork.stream().filter(req -> req.getPriority().name().equals("Низкий")).count();
        Long inWorkUsually = requestInWork.stream().filter(req -> req.getPriority().name().equals("Обычный")).count();
        Long inWorkHigh = requestInWork.stream().filter(req -> req.getPriority().name().equals("Высокий")).count();
        Long inWorkUrgent = requestInWork.stream().filter(req -> req.getPriority().name().equals("Безотлагательный")).count();
        totalWork = inWorkVeryLow+inWorkLow+inWorkUsually+inWorkHigh+inWorkUrgent;

        Long inPauseVeryLow = requestInPause.stream().filter(req -> req.getPriority().name()==("Самый_Низкий")).count();
        Long inPauseLow = requestInPause.stream().filter(req -> req.getPriority().name().equals("Низкий")).count();
        Long inPauseUsually = requestInPause.stream().filter(req -> req.getPriority().name().equals("Обычный")).count();
        Long inPauseHigh = requestInPause.stream().filter(req -> req.getPriority().name().equals("Высокий")).count();
        Long inPauseUrgent = requestInPause.stream().filter(req -> req.getPriority().name().equals("Безотлагательный")).count();
        totalPause = inPauseVeryLow+inPauseLow+inPauseUsually+inPauseHigh+inPauseUrgent;

        Long inCloseVeryLow = requestInClose.stream().filter(req -> req.getPriority().name()==("Самый_Низкий")).count();
        Long inCloseLow = requestInClose.stream().filter(req -> req.getPriority().name().equals("Низкий")).count();
        Long inCloseUsually = requestInClose.stream().filter(req -> req.getPriority().name().equals("Обычный")).count();
        Long inCloseHigh = requestInClose.stream().filter(req -> req.getPriority().name().equals("Высокий")).count();
        Long inCloseUrgent = requestInClose.stream().filter(req -> req.getPriority().name().equals("Безотлагательный")).count();
        totalClose = inCloseVeryLow+inCloseLow+inCloseUsually+inCloseHigh+inCloseUrgent;

        longListVeryLow.add(inWorkVeryLow);
        longListVeryLow.add(inPauseVeryLow);
        longListVeryLow.add(inCloseVeryLow);
        map.put("Самый низкий", longListVeryLow);

        longListLow.add(inWorkLow);
        longListLow.add(inPauseLow);
        longListLow.add(inCloseLow);
        map.put("Низкий", longListLow);

        longListUsually.add(inWorkUsually);
        longListUsually.add(inPauseUsually);
        longListUsually.add(inCloseUsually);
        map.put("Обычный", longListUsually);

        longListHigh.add(inWorkHigh);
        longListHigh.add(inPauseHigh);
        longListHigh.add(inCloseHigh);
        map.put("Высокий", longListHigh);

        longListUrgency.add(inWorkUrgent);
        longListUrgency.add(inPauseUrgent);
        longListUrgency.add(inCloseUrgent);
        map.put("Безотлагательный", longListUrgency);

        List<Long> longList = new ArrayList<>();
        longList.add(totalWork);
        longList.add(totalPause);
        longList.add(totalClose);

        map.put("Всего", longList);

        return map;
    }

}
