package com.bsuir.CourseWork.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BemnSupportController {
    @GetMapping("/")
    public String redirectBemn() {
        return "redirect:/request";
    }
}