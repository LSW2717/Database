package inha.sugang.inhasugang.controller;

import inha.sugang.inhasugang.entity.Student;
import inha.sugang.inhasugang.service.StudentService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class LoginController {
    private final StudentService studentService;

    @PostMapping("/")
    public String handleLogin(@RequestParam String studentNumber, // 숫자 대신 문자열로 받음
                              @RequestParam String password,
                              HttpServletResponse response,
                              RedirectAttributes redirectAttributes) {

        try {
            // studentNumber가 숫자 형식인지 확인
            int studentNum = Integer.parseInt(studentNumber);

            Optional<Student> studentOptional = studentService.findOne(studentNum);
            if (studentOptional.isPresent()) {
                Student student = studentOptional.get();
                if (student.getPassword().equals(password)) {
                    // 쿠키 생성 및 설정
                    Cookie cookie = new Cookie("loggedInStudent", String.valueOf(studentNum));
                    cookie.setMaxAge(7 * 24 * 60 * 60); // 1주일 유효
                    cookie.setHttpOnly(true); // JavaScript 접근 방지
                    response.addCookie(cookie);

                    redirectAttributes.addFlashAttribute("user", studentNum);
                    return "redirect:/main";
                }
            }
            redirectAttributes.addFlashAttribute("loginError", "잘못된 아이디 또는 비밀번호입니다.");
        } catch (NumberFormatException e) {
            // 숫자 형식이 아닌 경우 오류 처리
            redirectAttributes.addFlashAttribute("loginError", "학번은 숫자만 가능합니다.");
        }

        return "redirect:/";
    }

    @GetMapping("/")
    public String login(@CookieValue(value = "loggedInStudent", defaultValue = "") String loggedInStudent, Model model) {
        if (!loggedInStudent.isEmpty()) {
            // 쿠키에 사용자 정보가 있으면 메인 페이지로 리다이렉트
            return "redirect:/main";
        }
        model.addAttribute("title", "로그인페이지");
        return "login";
    }

    @GetMapping("/main")
    public String mainPage(@CookieValue(value = "loggedInStudent", defaultValue = "") String loggedInStudent, Model model) {
        if (loggedInStudent.isEmpty()) {
            // 쿠키에 사용자 정보가 없으면 로그인 페이지로 리다이렉트
            return "redirect:/";
        }
        model.addAttribute("title", "메인페이지");
        model.addAttribute("user", loggedInStudent);
        return "main";
    }
}
