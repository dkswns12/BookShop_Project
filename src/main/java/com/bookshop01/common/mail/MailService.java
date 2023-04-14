package com.bookshop01.common.mail;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.bookshop01.member.vo.MemberVO;
import com.bookshop01.order.vo.OrderVO;

@Service("mailService")
public class MailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private SimpleMailMessage preConfiguredMessage;

	@Async
	public void sendMail(Map recieverMap, List<OrderVO> myOrderList, MemberVO orderer) throws UnsupportedEncodingException {
		MimeMessage messsage = mailSender.createMimeMessage();
		
		String to, subject, body="";
		String mail_template="";
		
		to=orderer.getEmail1()+"@"+orderer.getEmail2();
		
		if(to.indexOf(",")!=-1) {
			to=to.substring(0,to.indexOf(","));
		}
		
		subject=orderer.getMember_name()+"님 주문 내역을 확인해 주세요.";
		
		OrderVO orderVO=(OrderVO)myOrderList.get(0);
		
		try {
			
			MimeMessageHelper helper=new MimeMessageHelper(messsage, true, "UTF-8");
			
			helper.setTo(to);
			helper.setSubject(subject);
			
			helper.setFrom("jyanbizF.gmail.com", "관리자");
			
			mail_template=readHtmlFile();
			
			body=setOrderInfo(mail_template, orderVO);
			
			helper.setText(body, true);
			
			mailSender.send(messsage);
			
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private String readHtmlFile() {
		String mail_template="";
		
		File file=null;
		
		ClassPathResource resource = new ClassPathResource("template/mail_template.html");
		
		FileInputStream fis=null;
		InputStreamReader is=null;
		BufferedReader br=null;
		String temp="";
		try {
			file=resource.getFile();
			fis=new FileInputStream(file);
			is=new InputStreamReader(fis, "euc-kr");
			br=new BufferedReader(is);
			
			while((temp=br.readLine())!=null) {
				mail_template+=temp+"\n";
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mail_template;
	}
	

	private String setOrderInfo(String mail_template, OrderVO orderVO) {
		String regEx="_order_id";
		Pattern pat=Pattern.compile(regEx);
		
		Matcher m=pat.matcher(mail_template);
		
		mail_template=m.replaceAll(Integer.toString(orderVO.getOrder_id()));

	    regEx = "_goods_id";
	    pat = Pattern.compile(regEx);
	    m = pat.matcher(mail_template);
	    mail_template = m.replaceAll(Integer.toString(orderVO.getGoods_id()));
	    
	    regEx = "_goods_fileName";
	    pat = Pattern.compile(regEx);
	    m = pat.matcher(mail_template);
	    mail_template = m.replaceAll(orderVO.getGoods_fileName());
	    
	    regEx = "_goods_title";
	    pat = Pattern.compile(regEx);
	    m = pat.matcher(mail_template);
	    mail_template = m.replaceAll(orderVO.getGoods_title());
 
	    return mail_template;
	}

}