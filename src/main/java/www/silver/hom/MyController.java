package www.silver.hom;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyController {
	@Resource(name = "cname") // 컨테이너로부터 주입 받는다
	String name; //값이 null이 아닌 주입받은 객체의 주소 < DI개념
	
	
}
