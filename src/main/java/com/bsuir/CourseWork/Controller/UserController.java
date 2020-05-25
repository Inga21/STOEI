package com.bsuir.CourseWork.Controller;

import com.bsuir.CourseWork.Domain.Company;
import com.bsuir.CourseWork.Domain.Department;
import com.bsuir.CourseWork.Domain.Device;
import com.bsuir.CourseWork.Domain.User;
import com.bsuir.CourseWork.service.CompanyService;
import com.bsuir.CourseWork.service.DepartmentService;
import com.bsuir.CourseWork.service.DeviceService;
import com.bsuir.CourseWork.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private DeviceService deviceService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private UserService userService;

    private static String path = "usersTemplates/";

    //Вывод всех пользователей для супер админа для изменения их роли.
    @GetMapping
    public String showUserActionPage(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return path+"userAction";
    }

    //Вывод информации о данном пользователе
    @RequestMapping(value = "/area", method = RequestMethod.GET)
    public String showUserArea(Model model) {
        User user = userService.userBySecurityContext();
        model.addAttribute("users", userService.findUserById(user.getId()));
        return path + "userArea";
    }

    //Заполнить информацию о себе (Компания, отдел)
    @RequestMapping(value = "/area/inform", method = RequestMethod.GET)
    public String showUserAreaInform(Model model) {
        model.addAttribute("company", companyService.getAllCompany());
        return path + "userAddInform";
    }

    //Сохранение информации о себе
    @RequestMapping(value = "/area/inform", method = RequestMethod.POST)
    public String addUserAreaInform(@RequestParam String companyTitle,
                                    Department department,
                                    BindingResult bindingResult,
                                    Model model) {
        if (bindingResult.hasErrors()) {
            Map<String,String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("department",department);
            return path + "userAddInform";
        }
        else {
            Company currentCompany = companyService.findByCompanyTitle(companyTitle);
            department.setCompany(currentCompany);
            departmentService.saveDepartment(department);
            User user = userService.userBySecurityContext();
            user.setDepartment(department);
            userService.saveUser(user);
            model.addAttribute("company", companyService.getAllCompany());
            return "redirect:/user/area";
        }

    }

    //отображение страницы Редактирования информации о себе
    @RequestMapping(value = "/area/edit/{id}", method = RequestMethod.GET)
    public String userAreaInformEdit(@PathVariable long id, Model model) {
        model.addAttribute("company", companyService.getAllCompany());
        model.addAttribute("users", userService.findUserById(id));
        return path + "UserEdit";
    }

    //Сохранение редактирование информации о себе
    @RequestMapping(value = "/area/edit", method = RequestMethod.POST)
    public String saveUserAreaInformEdit(@RequestParam Long user_id, @RequestParam String username,
                                         @RequestParam String fio, @RequestParam String telephoneMobile,
                                         @RequestParam String telephoneWork, @RequestParam String departmentTitle,
                                         @RequestParam int numberRoom, @RequestParam String companyTitle,
                                         @RequestParam Long department_id, @RequestParam String password1,
                                         @RequestParam String password, @RequestParam(required = false) List<Device> device) {
        User user = userService.findUserById(user_id);
        Department department;
        if(department_id==null) {
            department = new Department();
        } else {
            department = departmentService.findDepartmentById(department_id);
        }

        user.setUsername(username);
        user.setFio(fio);
        user.setTelephoneMobile(telephoneMobile);
        user.setTelephoneWork(telephoneWork);

        if (!password.equals("") && password.equals(password1)) {
            String encryptPassword = passwordEncoder.encode(password);
            user.setPassword(encryptPassword);
        }

        department.setNumberRoom(numberRoom);
        department.setDepartmentTitle(departmentTitle);
        department.setCompany(companyService.findByCompanyTitle(companyTitle));
        user.setDepartment(department);

        departmentService.saveDepartment(department);
        userService.saveUser(user);

        return "redirect:/user/area";
    }

    //Редактирование роли, добавление девайса, редактирование пользователя админом
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String editUser(@RequestParam Long id,
                           @RequestParam String button,
                           @RequestParam String role, Model model) {
        if (button.equals("editRole")) {
            userService.editUserRole(role, id);
        }
        if (button.equals("addDevice")) {
            model.addAttribute("id", id);
            return path + "userAddDevices";
        }
        if (button.equals("editUser")) {
            return "redirect:/user/area/edit/" + id;
        }
        if (button.equals("deleteUser")) {
            User currentUser = userService.userBySecurityContext();
            User user = userService.findUserById(id);
            if (user.equals(currentUser)) {
                model.addAttribute("message", "Вы не можете удалить сами себя!");
            } else {
                userService.deleteUser(user);
            }
        }
        return "redirect:/user";
    }

    //Вывод страницы для добавления пользователя
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showUserAddPage() {
        return "userAdd";
    }

    //Добавление нового пользователя
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addNewUser(@Valid User user,
                             BindingResult bindingResult,
                             @Valid Device device,
                             BindingResult bindingResult1,
                             @RequestParam(name = "role") String role, Model model) {
        if (bindingResult.hasErrors()||bindingResult1.hasErrors()) {
            Map<String,String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            errorsMap = ControllerUtils.getErrors(bindingResult1);
            model.mergeAttributes(errorsMap);
            model.addAttribute("user",user);
            model.addAttribute("device",device);
        }
            else {
            user.setDeviceList(Collections.singletonList(device));
            String message = userService.addNewUser(user, role);
            device.setUser(userService.findUserByUserName(user.getUsername()));
            deviceService.saveDevice(device);
            model.addAttribute("message", message);
        }
        return "userAdd";
    }
    @RequestMapping(value = "/device", method = RequestMethod.GET)
    public String showUserDevice(Model model) {
        model.addAttribute("devices", deviceService.getAllDevice());
        return path + "userDevice";
    }

    @RequestMapping(value = "/device/add", method = RequestMethod.POST)
    public String addUserDevice(@RequestParam long user_id, @Valid Device device,
                                BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            Map<String,String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("id",user_id);
            model.addAttribute("device",device);
            return path+"userAddDevices";
        }else{
            User user = userService.findUserById(user_id);
            device.setUser(user);
            deviceService.saveDevice(device);
            return "redirect:/user";
        }
    }

    @RequestMapping(value = "/find", method = RequestMethod.GET)
    public String findUser(@RequestParam String choice, @RequestParam String find,
                           Model model) {
        List<User> user = new ArrayList<>();
        List<User> user1 = null;
        if (choice.equals("email")) {
            user.add(userService.findUserByUserName(find));
        } else if (choice.equals("fio")) {
            user = userService.findUserByFio(find);
        } else if (choice.equals("role")) {
            user1 = userService.getAllUsers();
            String finded = find.toUpperCase();
            user = user1.stream().filter(us -> (us.getRoles().iterator().next().name().toString().equals(finded))).collect(Collectors.toList());
        }
        model.addAttribute("users", user);
        return path + "userAction";
    }

    @RequestMapping(value = "/device/edit", method = RequestMethod.GET)
    public String editDeviceUser(@RequestParam long id, @RequestParam String button,
                                 Model model) {
        String url = "";
        if (button.equals("editUserDevice")) {
            model.addAttribute("devices", deviceService.findDeviceById(id));
            url = path + "userDeviceedit";
        }
        if (button.equals("deleteDevice")) {
            deviceService.deviceDelete(id);
            url = "redirect:/user/device";
        }
        return url;
    }

    @RequestMapping(value = "/device/edit", method = RequestMethod.POST)
    public String editDeviceUser(@Valid Device device,
                                 BindingResult bindingResult,
                                 Model model) {

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("devices", device);
            return path + "userDeviceedit";
        }else{
            Device currentDevice = deviceService.findDeviceById(device.getId());
            device.setUser(currentDevice.getUser());
            deviceService.saveDevice(device);
            return "redirect:/user/device";
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/device/find", method = RequestMethod.GET)
    public String findDeviceUser(@RequestParam String choice, @RequestParam String findField,
                                 Model model) {
        List<Device> devices = null;

        if (choice.equals("fio")) {
            try {
                User user = userService.findOneUserByFIO(findField);
                devices = user.getDeviceList();
                model.addAttribute("devices", devices);
            } catch (Exception ex) {
                model.addAttribute("devices", null);
            }
        } else {
            devices = deviceService.findDeviceByPersonnelNumber(findField);
        }
        model.addAttribute("devices", devices);
        return path + "userDevice";
    }

}
