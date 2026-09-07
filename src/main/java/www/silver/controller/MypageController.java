package www.silver.controller;

import java.sql.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.SignUpService;
import www.silver.util.FileDataUtil;
import www.silver.vo.MemberVO;

@Controller
public class MypageController {

    @Inject
    SignUpService memberservice;
    
    @Inject
	FileDataUtil filedatautil;

    
    @RequestMapping(value = "/resetPassword", method = {RequestMethod.POST})
    public String passresetd(HttpSession session, RedirectAttributes ra,
                            @RequestParam("newPassword") String newPassword,
                            @RequestParam("oldPassword") String oldPassword) throws Exception {
        
        // 세션에서 loginUser 가져오기
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            ra.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        // 이전 비밀번호 검증
        String userId = loginUser.getUserId();
        MemberVO memberFromDB = memberservice.getMemberById(userId);
        if (!memberFromDB.getUserPassword().equals(oldPassword)) {
            ra.addFlashAttribute("error", "이전 비밀번호가 올바르지 않습니다.");
            return "redirect:/passreset";
        }

        // 새 비밀번호로 업데이트
        MemberVO idpass = new MemberVO();
        idpass.setUserId(userId);
        idpass.setUserPassword(newPassword);

        try {
            memberservice.updateMemberPass(idpass);
            ra.addFlashAttribute("success", "비밀번호가 성공적으로 재설정되었습니다.");
            return "redirect:/";
        } catch (Exception e) {
            ra.addFlashAttribute("error", "비밀번호 재설정에 실패했습니다.");
            return "redirect:/passreset";
        }
    } 
    
    @RequestMapping(value = "/passreset", method = RequestMethod.GET)
	public String passreset(HttpSession session, Model model) {
		return "/member/passresetF";
	}
    
    @RequestMapping(value = "/membermod", method = RequestMethod.GET)
	@GetMapping("/member/membermodF")
	public String membermod(HttpSession session, Model model) {
		MemberVO loginUser=(MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
            return "redirect:/";
        }
		
        // DB�뿉�꽌 理쒖떊 �젙蹂� 議고쉶 (�꽑�깮�궗�빆)
		try {
			MemberVO latestMember = memberservice.getMemberById(loginUser.getUserId());
			
			model.addAttribute("member", latestMember);
			//System.out.println(latestMember.getAddress()); 
		
			//System.out.println(latestMember.getUserPhoneNum()); 
			
			//System.out.println(loginUser.getUserId()); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/member/membermodF";
	}
    
  
   
  //�듅�젙 �쉶�썝�쓽 �젙蹂� 議고쉶
  	@RequestMapping(value = "/memberview", method = RequestMethod.GET)
  	public String memberview(HttpSession session, Model model) {

  		MemberVO loginUser=(MemberVO) session.getAttribute("loginUser");
  		if (loginUser == null) {
              return "redirect:/";
          }
  		
          // DB�뿉�꽌 理쒖떊 �젙蹂� 議고쉶 (�꽑�깮�궗�빆)
  		try {
  			MemberVO latestMember = memberservice.getMemberById(loginUser.getUserId());
  			
  			model.addAttribute("member", latestMember);
  			//System.out.println(latestMember.getAddress()); 
  		
  			//System.out.println(latestMember.getUserPhoneNum()); 
  			
  			//System.out.println(loginUser.getUserId()); 
  		} catch (Exception e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
  		//model.addAttribute("member", loginUser);
  		return "/member/memberviewF";
  	}
    @RequestMapping(value = "/memberreset", method = RequestMethod.GET)
	public String memberreset() {
		return "/getuseds/membermodF";
	}
	
	@RequestMapping(value = "/memberresertd", method = {RequestMethod.POST})
    public String memberresertd(HttpSession session, RedirectAttributes ra,
                            @RequestParam("newUserName") String newUserName,
                            @RequestParam("newZipCode") String newZipCode,
                            @RequestParam("newAddress") String newAddress,
                            @RequestParam("newDetailAddress") String newDetailAddress,
                            @RequestParam("newFullEmail") String newFullEmail,
                            @RequestParam("newUserPhoneNum") String newUserPhoneNum,
                            @RequestParam("newBirthdate") Date newBirthdate) throws Exception {
        
        // 세션에서 loginUser 가져오기
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            ra.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/login";
        }
        

        // 이전 비밀번호 검증
        String userId = loginUser.getUserId();
        
        
      

        // 새 비밀번호로 업데이트
        MemberVO reset = new MemberVO();
        reset.setUserId(userId);
        reset.setUserName(newUserName);
        reset.setZipCode(newZipCode);
        reset.setAddress(newAddress);
        reset.setDetailAddress(newDetailAddress);
        reset.setUserEmail(newFullEmail);
        reset.setUserPhoneNum(newUserPhoneNum);
        reset.setBirthdate(newBirthdate);

    
        try {
            memberservice.memberresert(reset);
            ra.addFlashAttribute("success", "성공적으로 재설정되었습니다.");
            return "redirect:/";
        } catch (Exception e) {
            ra.addFlashAttribute("error", "재설정에 실패했습니다.");
            return "redirect:/memberreset";
        }
    } 
	
	@RequestMapping(value = "/profileOptions", method = RequestMethod.GET)
	public String profileOptions() {
		return "/getuseds/profileOptions";
	}
}
