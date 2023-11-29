package inha.sugang.inhasugang.controller;


import inha.sugang.inhasugang.entity.Class;
import inha.sugang.inhasugang.service.ClassService;
import inha.sugang.inhasugang.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ClassController {
    private final ClassService classService;
    private final StudentService studentService;

    @GetMapping("/select")
    public String selectEnrolment(@CookieValue(value = "loggedInStudent", defaultValue = "") String loggedInStudent, Model model) {
        model.addAttribute("user", loggedInStudent);
        int studentId = Integer.parseInt(loggedInStudent);
        List<Class> classes = classService.findClassesByStudentId(studentId);
        model.addAttribute("classes", classes);
        List<Class> allClasses = classService.findClasses();
        model.addAttribute("allClass", allClasses);

        model.addAttribute("title", "Course completion list");
        model.addAttribute("title2", "Course List (Registration)");

        return "select";
    }

    @PostMapping("/select")
    public String applyForClass(@RequestParam("applyBtn") int classId,
                                @CookieValue(value = "loggedInStudent", defaultValue = "") String loggedInStudentId,
                                RedirectAttributes redirectAttributes) {
        try {
            int studentNumber = Integer.parseInt(loggedInStudentId);
            int studentId = studentService.findIdByStudentNumber(studentNumber);
            classService.enrollStudentInClass(studentId, classId);
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("Error", e.getMessage());
            return "redirect:/select";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("Error", "수강 신청 중 오류가 발생했습니다.");
            return "redirect:/select";
        }
        return "redirect:/select";
    }

}



