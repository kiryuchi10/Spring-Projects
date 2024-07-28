package com.projectA.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.projectA.repository.vo.UserVo;
import com.projectA.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    
    @GetMapping("/join")
	public String join(Model model) {
		// 지점 목록을 모델에 추가
		return "users/join";
	}
    
    @PostMapping("/join")
	public String join(@ModelAttribute @Valid UserVo userVo,
			@RequestParam("checkedName") String checkedName,
			Model model) {
		
		if("y".equals(checkedName)) {	//	이름 중복 체크 여부 판단
			boolean success = userService.join(userVo);
			if (success) {	//	가입 성공
				System.out.println("가입 성공");
				return "redirect:/user/joinsuccess";
			} else {
				System.err.println("실패!");
				return "redirect:/user/join";
			}
			
		} else {
			System.err.println("중복 체크 안 함");
			return "redirect:/user/join";
		}
		
	}
	
	@GetMapping("/joinsuccess")
	public String joinsuccess() {
		return "users/joinsuccess";
	}

	
	//	중복 이메일 체크(API) - 응답을 Json으로 
	@ResponseBody	//	메시지 컨버터 
	@RequestMapping("/checkName")
	public Object checkName(@RequestParam (value="name", required = true, defaultValue="") String name) {
		UserVo vo = userService.getUser(name);
		boolean exists = vo != null ? true : false;
		
		Map<String, Object> json = new HashMap<>();
		json.put("result", "success");
		json.put("exists", exists);
		return json;
	}
	
	@GetMapping ("/login")
	public String loginform () {
		return "users/loginform";
	}
	@PostMapping("/login")
	public String loginAction(@RequestParam(value="name", required=false, defaultValue="") String name,
	                          @RequestParam(value="password", required=false, defaultValue="") String password,
	                          HttpSession session) {

	    if (name.length() == 0 || password.length() == 0) {
	        // If name or password is not entered, redirect to login page.
	        return "redirect:/user/login";
	    }
		return "admins/admin_home";
	}



    @RequestMapping("/calendar")
    public String showCalendar(Model model) {
        List<UserVo> orders = userService.selectAllBookOrders(); // Fetch all book orders
        model.addAttribute("orders", orders); // Add book orders to model
        return "users/calendar"; // Returns the view name for the calendar page
    }


    // Endpoint to get branch list summary and display it on the orderlistsummary.jsp
    @RequestMapping("/summary")
    public String showOrderListSummary(Model model) {
        List<UserVo> orderList = userService.getBranchListSummary();
        model.addAttribute("orderList", orderList);
        return "users/orderlistsummary"; // This corresponds to the JSP file name
    }
}
