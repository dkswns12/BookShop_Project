package com.bookshop01.admin.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.member.vo.MemberVO;
import com.bookshop01.member.vo.MemberVO_Modified;

public interface AdminMemberController {
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity memberDetail(@PathVariable("member_id") String member_id, HttpServletResponse response)  throws Exception;
	public ResponseEntity<String> modifyMemberInfo(@PathVariable("member_id") String member_id, @RequestBody MemberVO_Modified memberVO) throws Exception;
	public ResponseEntity deleteMember(@PathVariable("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
