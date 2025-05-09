package com.javaweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
  @GetMapping("/")
  public String homeRedirect() {
    return "redirect:/loginSystem";
  }


  @GetMapping("/home")
  public ModelAndView home() {
    // Trả về index.jsp trong /WEB-INF/views/
    return new ModelAndView("index");
  }

  @GetMapping("/register")
  public ModelAndView register() {
    // Trả về index.jsp trong /WEB-INF/views/
    return new ModelAndView("web/register");
  }
  @GetMapping("/loginSystem")
  public ModelAndView login() {
    // Trả về index.jsp trong /WEB-INF/views/
    return new ModelAndView("web/loginSystem");
  }
}
