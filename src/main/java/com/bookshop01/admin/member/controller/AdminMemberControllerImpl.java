package com.bookshop01.admin.member.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.admin.member.service.AdminMemberService;
import com.bookshop01.common.base.BaseController;
import com.bookshop01.member.vo.MemberVO;
import com.bookshop01.member.vo.MemberVO_Modified;

@Controller("adminMemberController")
@RequestMapping(value="/admin/member")
public class AdminMemberControllerImpl extends BaseController  implements AdminMemberController{
	@Autowired
	private AdminMemberService adminMemberService;
	
	@RequestMapping(value="/adminMemberMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		
		HashMap<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		ArrayList<MemberVO> member_list=adminMemberService.listMember(condMap);
		mav.addObject("member_list", member_list);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}
	@RequestMapping(value="{member_id}", method=RequestMethod.GET)
	public ResponseEntity memberDetail(@PathVariable("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		MemberVO memberVO=(MemberVO)adminMemberService.memberDetail(member_id);
		ResponseEntity resEntity=new ResponseEntity(memberVO, HttpStatus.OK);
		return resEntity;
		
	}
	
	@RequestMapping(value="/{member_id}", method=RequestMethod.PUT)
	public ResponseEntity<String> modifyMemberInfo(@PathVariable("member_id") String member_id, @RequestBody MemberVO_Modified memberVO) throws Exception {
		String mod_type=memberVO.getMod_type();
		String value=memberVO.getValue();
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String val[]=null;
		
		if(mod_type.equals("member_birth")){
		val=value.split(",");
		memberMap.put("member_birth_y",val[0]);
		memberMap.put("member_birth_m",val[1]);
		memberMap.put("member_birth_d",val[2]);
		memberMap.put("member_birth_gn",val[3]);
		}else if(mod_type.equals("tel")){
			val=value.split(",");
			memberMap.put("tel1",val[0]);
			memberMap.put("tel2",val[1]);
			memberMap.put("tel3",val[2]);
			
		}else if(mod_type.equals("hp")){
			val=value.split(",");
			memberMap.put("hp1",val[0]);
			memberMap.put("hp2",val[1]);
			memberMap.put("hp3",val[2]);
			memberMap.put("smssts_yn", val[3]);
		}else if(mod_type.equals("email")){
			val=value.split(",");
			memberMap.put("email1",val[0]);
			memberMap.put("email2",val[1]);
			memberMap.put("emailsts_yn", val[2]);
		}else if(mod_type.equals("address")){
			val=value.split(",");
			memberMap.put("zipcode",val[0]);
			memberMap.put("roadAddress",val[1]);
			memberMap.put("jibunAddress", val[2]);
			memberMap.put("namujiAddress", val[3]);
		}
		
		memberMap.put("member_id", member_id);
		
		adminMemberService.modifyMemberInfo(memberMap);	
		String message="mod_success";
		
		ResponseEntity resEntity=new ResponseEntity(message, HttpStatus.OK);
		
		return resEntity;
		
	}
	
	@RequestMapping(value="/{member_id}", method= {RequestMethod.DELETE})
	public ResponseEntity deleteMember(@PathVariable("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		adminMemberService.deleteMemberInfo(member_id);
		
		ResponseEntity resEntity=new ResponseEntity("delete_success", HttpStatus.OK);
		
		return resEntity;
		
	
	}
	
	@RequestMapping(value="", method = RequestMethod.POST)
	public ResponseEntity addMember(@RequestBody MemberVO memberVO) throws Exception {
		adminMemberService.insertMemberInfo(memberVO);
		return new ResponseEntity("success", HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity memberDetail(String member_id, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

		
}
