package inha.sugang.inhasugang.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class LogoutController {
    @GetMapping("/logout")
    public String handleLogout(HttpServletResponse response) {
        Cookie cookie = new Cookie("loggedInStudent", null);
        cookie.setMaxAge(0); // 쿠키 삭제
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
        return "redirect:/";
    }
}
