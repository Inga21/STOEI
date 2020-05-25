package com.bsuir.CourseWork.Controller;

import com.bsuir.CourseWork.service.RequestService;
import com.bsuir.CourseWork.service.SummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/summary")
public class SummaryController {
    @Autowired
    SummaryService summaryService;
    @Autowired
    RequestService requestService;

    @GetMapping
    //by users
    public String showSummaryByAssigned(Model model) {
        Map<String, Integer> map = summaryService.getNumberOfTaskByCompany();
        model.addAttribute("summarysAssigned", summaryService.getSummaryBySpecialist());
        model.addAttribute("choice","Заявки по админам");
        model.addAttribute("bemn", map.get("Бемн"));
        model.addAttribute("baza", map.get("База"));
        model.addAttribute("atomka", map.get("Атомка"));
        return "summary";
    }

    @RequestMapping(value = "/priority", method = RequestMethod.GET)
    public String showSummaryByPriority(Model model) {
        Map<String, Integer> map = summaryService.getNumberOfTaskByCompany();
        model.addAttribute("summarysPriority", summaryService.getNumberOfTaskByStatus());
        model.addAttribute("choice","Заявки по приоритету");
        model.addAttribute("bemn", map.get("Бемн"));
        model.addAttribute("baza", map.get("База"));
        model.addAttribute("atomka", map.get("Атомка"));
        return "summary";
    }

    @RequestMapping(value = "filter", method = RequestMethod.GET)
    public String filter(@RequestParam String summary) {
        if (summary.equals("byAssigned")) {
            return "redirect:/summary";
        } else {
            return "redirect:/summary/priority";
        }
    }
    /*public String showSummaryByPriority(Model model)
    {

    }*/
}
