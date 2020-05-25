package com.bsuir.CourseWork.Controller;

import com.bsuir.CourseWork.Domain.User;
import com.bsuir.CourseWork.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/restore")
public class RememberPasswordController {
    @Autowired
    private UserService userService;

    @GetMapping
    public String showRestorePage(Model model){
        return "restore";
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public String getEmailRestorePage(@RequestParam String email, Model model){
        userService.rememberPassword(email);
        model.addAttribute("message","check your email");
        return "restore";
    }

    @RequestMapping(value = "/{code}", method = RequestMethod.GET)
    public String userForgotPassword(@PathVariable String code, Model model){
        User user = userService.findUserByActivationCode(code);
        model.addAttribute("users",user);

        return "restore";
    }

    @RequestMapping(value = "/newPassword", method = RequestMethod.POST)
    public String createNewPassword(@Valid String username, @RequestParam String password1,
                                    @RequestParam String password2, Model model) {
        User user = userService.findUserByUserName(username);
        if (password1.equals(null) || !password1.equals(password2)) {
            model.addAttribute("users",user);
            model.addAttribute("message","password different!");
            return "restore";
        }
        userService.createNewPassword(user,password1);
        return "redirect:/";
    }
}
