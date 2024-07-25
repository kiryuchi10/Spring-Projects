package com.projectA.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @RequestMapping("/main") 
    public String main(Model model) {
    	logger.debug("메인 페이지");
        // 모델에 필요한 기본 속성을 추가할 수 있습니다.
        // model.addAttribute("key", "value");
        return "home";
    }

    // 루트 경로를 처리하는 메서드
    @RequestMapping("/")
    public String root() {
        return "redirect:/main"; // /main 경로로 리다이렉트
    }
    
  
//    @ExceptionHandler(RuntimeException.class)
//    @ResponseBody
//    public String handlerControllerException(RuntimeException e) {
//    	return "Exception: " + e.getMessage();
    	
//    }
   
}
