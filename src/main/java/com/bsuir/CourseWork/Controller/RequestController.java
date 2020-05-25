package com.bsuir.CourseWork.Controller;

import com.bsuir.CourseWork.Domain.Priority;
import com.bsuir.CourseWork.Domain.Request;
import com.bsuir.CourseWork.Domain.Status;
import com.bsuir.CourseWork.Domain.User;
import com.bsuir.CourseWork.service.RequestService;
import com.bsuir.CourseWork.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/request")
public class RequestController {
    @Autowired
    private RequestService requestService;
    @Autowired
    UserService userService;

    private static String path = "requestTemplates/";

    @GetMapping
    public String showUserActionPage(Model model) {
        User user = userService.userBySecurityContext();
        List<Request> requestList;
        if(user.getRoles().iterator().next().name().equals("USER")) {
            requestList = requestService.findReqestForUser(user);
            Collections.reverse(requestList);
            model.addAttribute("requests",requestList );
        }else{
            requestList = requestService.findAllRequest();
            Collections.reverse(requestList);
            model.addAttribute("requests",requestList );
            model.addAttribute("users",userService.findAllAdmin());
        }
        return "request";
    }

    //Назначение самого себя на заявку
    @RequestMapping(value = "/setAssigned/{request_id}", method = RequestMethod.GET)
    public String setRequestForUser(@PathVariable long request_id)
    {
        User user = userService.userBySecurityContext();
        Request request = requestService.findRequestById(request_id);
        request.setUserAssigned(user);
        requestService.saveRequest(request);
        return "redirect:/request";
    }
    //Закрытие заявии
    @RequestMapping(value = "/close/{request_id}", method = RequestMethod.GET)
    public String closeRequest(@PathVariable long request_id)
    {
        User user = userService.userBySecurityContext();
        Request request = requestService.findRequestById(request_id);
        request.setStatus(Status.Закрыто);
        Date date = new Date();
        request.setDateEnd(date);
        requestService.saveRequest(request);

        userService.NotifyUserAboutClose(user,request);
        return "redirect:/request";
    }
    //Назначение админом спеца на заявку
    @RequestMapping(value = "/{request_id}/setAssigned/{user_id}")
    public String setRequestByAdmin(@PathVariable long request_id,
                                    @PathVariable long user_id)
    {
        User user = userService.findUserById(user_id);
        Request request = requestService.findRequestById(request_id);
        request.setUserAssigned(user);
        requestService.saveRequest(request);
        return "redirect:/request";
    }

    //Распределение кнопок
    @RequestMapping (value = "/action", method = RequestMethod.GET)
    public String redirectActionRequest(@RequestParam String button,
                                        @RequestParam Long request_id,
                                        @RequestParam (required = false) Long user_id,
                                        @RequestParam (required = false) String specialist,
                                        Model model)
    {
        if(button.equals("getRequest")) {
            return "redirect:/request/setAssigned/"+request_id;
        }
        if(button.equals("closeRequest")){
            return "redirect:/request/close/"+request_id;
        }
        if(button.equals("assignToRequest")){
            return "redirect:/request/"+request_id+"/setAssigned/"+user_id;
        }
        if(button.equals("pauseRequest")){
            return "redirect:/request/pause/"+request_id;
        }
        if(button.equals("reNewRequest")) {
            return "redirect:/request/work/"+request_id;
        }
        return "request";
    }

    @RequestMapping(value = "/pause/{request_id}", method = RequestMethod.GET)
    public String pauseRequest(@PathVariable long request_id, Model model)
    {
        User user = userService.userBySecurityContext();
        String message = requestService.pauseStatusRequest(request_id, user);
/*        model.addAttribute("message", message);
        model.addAttribute("users",userService.findAllAdmin());
        model.addAttribute("requests",requestService.findAllRequest());*/
        return "redirect:/request";
    }

    @RequestMapping(value = "/work/{request_id}", method = RequestMethod.GET)
    public String inWorkRequest(@PathVariable long request_id, Model model)
    {
        User user = userService.userBySecurityContext();
        String message = requestService.inWorkStatusRequest(request_id, user);
/*        model.addAttribute("requests",requestService.findAllRequest());
        model.addAttribute("users",userService.findAllAdmin());
        model.addAttribute("message", message);*/
        return "redirect:/request";
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Фильтры
    //Мои заявки
    @RequestMapping (value = "/my", method = RequestMethod.GET)
    public String showMyRequest(Model model)
    {
        User user = userService.userBySecurityContext();
        model.addAttribute("requests", requestService.findMyRequest(user));
        model.addAttribute("users", userService.findAllAdmin());
        return "request";
    }
    //Неназначенные
    @RequestMapping (value = "/unassigned", method = RequestMethod.GET)
    public String showUnassignedRequest(Model model)
    {
        model.addAttribute("requests",requestService.findUnassignedRequest());
        model.addAttribute("users",userService.findAllAdmin());
        return "request";
    }
    //Мои в работе
    @RequestMapping(value = "/open",method = RequestMethod.GET)
    public String showMyAndOpenRequest(Model model)
    {
        User user = userService.userBySecurityContext();
        model.addAttribute("requests",requestService.findAdminAndOpenRequest(user));
        model.addAttribute("users",userService.findAllAdmin());
        return "request";
    }
    //Просмотр всех моих закрытых
    @RequestMapping(value = "/close",method = RequestMethod.GET)
    public String showMyCloseRequest(Model model)
    {
        User user = userService.userBySecurityContext();
        model.addAttribute("requests",requestService.findMyCloseRequest(user));
        model.addAttribute("users",userService.findAllAdmin());
        return "request";
    }
    //Просмотр всех закрытых
    @RequestMapping(value = "/allClose",method = RequestMethod.GET)
    public String showAllCloseRequest(Model model)
    {
        model.addAttribute("requests",requestService.findAllCloseRequest());
        model.addAttribute("users",userService.findAllAdmin());
        return "request";
    }

    @RequestMapping(value = "/admin/{id}", method = RequestMethod.GET)
    public String showCurrentRequest(@PathVariable Long id, Model model)
    {
        User user = userService.findUserById(id);
        model.addAttribute("requests",requestService.findAdminAndOpenRequest(user));
        model.addAttribute("users",userService.findAllAdmin());
        return "request";
    }
    //////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/find", method = RequestMethod.GET)
    public String findRequestById(@RequestParam Long findRequest_id, Model model)
    {
        model.addAttribute("requests",requestService.findRequestByIdList(findRequest_id));
        model.addAttribute("users", userService.findAllAdmin());
        return "request";
    }
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String showCurrentRequest(@PathVariable long id,  Model model)
    {
        model.addAttribute("request",requestService.findRequestById(id));
        model.addAttribute("admins", userService.findAllAdmin());
        return "requestShow";
    }
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showAddRequestPage(Model model)
    {
        model.addAttribute("request",new Request());
        model.addAttribute("user",userService.userBySecurityContext());
        model.addAttribute("admins",userService.findAllAdmin());
        model.addAttribute("users",userService.findAll());
        return "requestAdd";
    }
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addRequest(@Valid Request request, BindingResult bindingResult,
                             @RequestParam (required = false) Long adminAssigned,
                             @RequestParam(required = false) Long user_id,
                             @RequestParam(required = false) String priority,
                             @RequestParam(required = false) String user_fio, Model model) {
        User user;

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("requests",request);
            model.addAttribute("user",userService.userBySecurityContext());
            model.addAttribute("admins",userService.findAllAdmin());
            model.addAttribute("users",userService.findAll());
            return "requestAdd";
        }else {
            if (adminAssigned != null) {
                user = userService.findUserById(adminAssigned);
                request.setUserAssigned(user);
            }
            if (user_id != null) {
                user = userService.findUserById(user_id);
            } else {
                user = userService.findOneUserByFIO(user_fio);
            }
            request.setPriority(Priority.valueOf(priority));
            request.setUserApplicant(user);
            Date date = new Date();
            request.setDateCreate(date);
            if (request.getStatus().name().equals("Закрыто")) {
                Date dateEnd = new Date();
                request.setDateEnd(dateEnd);
            }
            requestService.saveRequest(request);
            return "redirect:/request";
        }
    }
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String editRequest(@PathVariable long id,
                              Request request, @RequestParam (required = false) Long adminAssigned,
                             @RequestParam (required = false) String status,
                             @RequestParam(required = false) Long user_id,
                             @RequestParam(required = false) String user_name,Model model)
    {

        Request currentRequest = requestService.findRequestById(id);
        currentRequest.setPriority(request.getPriority());
        currentRequest.setEffects(request.getEffects());
        currentRequest.setCategory(request.getCategory());
        currentRequest.setDescription(request.getDescription());
        currentRequest.setStatus(request.getStatus());

        requestService.saveRequest(currentRequest);
        return "redirect:/request/"+id;
    }
}
