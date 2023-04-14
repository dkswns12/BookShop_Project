package com.bookshop01.member.vo;

import org.springframework.stereotype.Component;

@Component("memberVO_modified")
public class MemberVO_Modified {
	private String member_id;
	private String mod_type;
	private String value;
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMod_type() {
		return mod_type;
	}
	public void setMod_type(String mod_type) {
		this.mod_type = mod_type;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
}

