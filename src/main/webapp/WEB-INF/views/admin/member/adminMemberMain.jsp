<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
#detail_table {
   display: none;
   position:relative;
   width:100%;
   height:100%;
   z-index:1;
 }
 
/*  #detail_table h2 {
   margin:0;
 }
 #detail_table button {
   display:inline-block;
   width:100px;
   margin-left:calc(100% - 100px - 10px);
 } */
 
 #detail_table .modal_content {
   width:650px;
   margin:100px auto;
   padding:20px 10px;
   background:#fff;

 }
 
 #detail_table .modal_layer {
   position:fixed;
   top:0;
   left:0;
   width:100%;
   height:100%;
   background:rgba(0, 0, 0, 0.5);
   z-index:-1;
 } 
</style>
<script>
function search_member(search_period){	
	temp=calcPeriod(search_period);
	var date=temp.split(",");
	beginDate=date[0];
	endDate=date[1];
	//alert("beginDate:"+beginDate+",endDate:"+endDate);
	//return ;
	
	var formObj=document.createElement("form");
    
	var formObj=document.createElement("form");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
    
	i_beginDate.name="beginDate";
	i_beginDate.value=beginDate;
	i_endDate.name="endDate";
	i_endDate.value=endDate;
	
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="/bookshop01/admin/member/adminMemberMain.do";
    formObj.submit();
}


function  calcPeriod(search_period){
	var dt = new Date();
	var beginYear,endYear;
	var beginMonth,endMonth;
	var beginDay,endDay;
	var beginDate,endDate;
	
	endYear = dt.getFullYear();
	endMonth = dt.getMonth()+1;
	endDay = dt.getDate();
	if(search_period=='today'){
		beginYear=endYear;
		beginMonth=endMonth;
		beginDay=endDay;
	}else if(search_period=='one_week'){
		beginYear=dt.getFullYear();
		if(endDay-7<1){
			beginMonth=dt.getMonth();	
		}else{
			beginMonth=dt.getMonth()+1;
		}
		
		dt.setDate(endDay-7);
		beginDay=dt.getDate();
		
	}else if(search_period=='two_week'){
		beginYear = dt.getFullYear();
		if(endDay-14<1){
			beginMonth=dt.getMonth();	
		}else{
			beginMonth=dt.getMonth()+1;
		}
		dt.setDate(endDay-14);
		beginDay=dt.getDate();
	}else if(search_period=='one_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-1);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='two_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-2);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='three_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-3);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}else if(search_period=='four_month'){
		beginYear = dt.getFullYear();
		dt.setMonth(endMonth-4);
		beginMonth = dt.getMonth();
		beginDay = dt.getDate();
	}
	
	if(beginMonth <10){
		beginMonth='0'+beginMonth;
		if(beginDay<10){
			beginDay='0'+beginDay;
		}
	}
	if(endMonth <10){
		endMonth='0'+endMonth;
		if(endDay<10){
			endDay='0'+endDay;
		}
	}
	endDate=endYear+'-'+endMonth +'-'+endDay;
	beginDate=beginYear+'-'+beginMonth +'-'+beginDay;
	//alert(beginDate+","+endDate);
	return beginDate+","+endDate;
}



function fn_member_detail(order_id){
	//alert(order_id);
	var frm_delivery_list=document.frm_delivery_list;
	

	var formObj=document.createElement("form");
	var i_order_id = document.createElement("input");
	
	i_order_id.name="order_id";
	i_order_id.value=order_id;
	
    formObj.appendChild(i_order_id);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/bookshop01/admin/member/memberDetail.do";
    formObj.submit();
	
}


function fn_enable_detail_search(r_search){
	var frm_delivery_list=document.frm_delivery_list;
	t_beginYear=frm_delivery_list.beginYear;
	t_beginMonth=frm_delivery_list.beginMonth;
	t_beginDay=frm_delivery_list.beginDay;
	t_endYear=frm_delivery_list.endYear;
	t_endMonth=frm_delivery_list.endMonth;
	t_endDay=frm_delivery_list.endDay;
	s_search_type=frm_delivery_list.s_search_type;
	t_search_word=frm_delivery_list.t_search_word;
	btn_search=frm_delivery_list.btn_search;
	
	if(r_search.value=='detail_search'){
		//alert(r_search.value);
		t_beginYear.disabled=false;
		t_beginMonth.disabled=false;
		t_beginDay.disabled=false;
		t_endYear.disabled=false;
		t_endMonth.disabled=false;
		t_endDay.disabled=false;
		
		s_search_type.disabled=false;
		t_search_word.disabled=false;
		btn_search.disabled=false;
	}else{
		t_beginYear.disabled=true;
		t_beginMonth.disabled=true;
		t_beginDay.disabled=true;
		t_endYear.disabled=true;
		t_endMonth.disabled=true;
		t_endDay.disabled=true;
		
		s_search_type.disabled=true;
		t_search_word.disabled=true;
		btn_search.disabled=true;
	}
		
}

//상세조회 버튼 클릭 시 수행
function fn_detail_search(){
	var frm_delivery_list=document.frm_delivery_list;
	
	beginYear=frm_delivery_list.beginYear.value;
	beginMonth=frm_delivery_list.beginMonth.value;
	beginDay=frm_delivery_list.beginDay.value;
	endYear=frm_delivery_list.endYear.value;
	endMonth=frm_delivery_list.endMonth.value;
	endDay=frm_delivery_list.endDay.value;
	search_type=frm_delivery_list.s_search_type.value;
	search_word=frm_delivery_list.t_search_word.value;

	var formObj=document.createElement("form");
	var i_command = document.createElement("input");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
	var i_search_type = document.createElement("input");
	var i_search_word = document.createElement("input");
    
	
    i_command.name="command";
    i_beginDate.name="beginDate";
    i_endDate.name="endDate";
    i_search_type.name="search_type";
    i_search_word.name="search_word";
    
    i_command.value="list_detail_order_goods";
	i_beginDate.value=beginYear+"-"+beginMonth+"-"+beginDay;
    i_endDate.value=endYear+"-"+endMonth+"-"+endDay;
    i_search_type.value=search_type;
    i_search_word.value=search_word;
	
    formObj.appendChild(i_command);
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    formObj.appendChild(i_search_type);
    formObj.appendChild(i_search_word);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/bookshop01/admin/member/memberDetail.do";
    formObj.submit();
	
}

function fn_member_detail_show(member_id){
	$.ajax({
		type:"GET",
		url:"${contextPath}/admin/member/"+member_id,
		success:function(data, textStatus){
			$('input[name=member_id]').attr('value',data.member_id);
			$('input[name=member_pw]').attr('value',data.member_pw);
			$('input[name=member_name]').attr('value',data.member_name);
			$('input[name=member_gender]').attr('value',data.member_gender);
			$('input[name=tel2]').attr('value',data.tel2);
			$('input[name=tel3]').attr('value',data.tel3);
			$('input[name=hp2]').attr('value',data.hp2);
			$('input[name=hp3]').attr('value',data.hp3);
			$('input[name=email1]').attr('value',data.email1);
			$('input[name=email2]').attr('value',data.email2);
			$('input[name=roadAddress]').attr('value',data.roadAddress);
			$('input[name=jibunAddress]').attr('value',data.jibunAddress);
			$('input[name=namujiAddress]').attr('value',data.namujiAddress);
			$('input[name=zipcode]').attr('value',data.zipcode);
			$("#detail_table").show();		
			
		},		
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax
}

function fn_delete_member(){
	var member_id=document.getElementById('member_id').value;
	$.ajax({
		type:"DELETE",
		url:"${contextPath}/admin/member/"+member_id,
		success:function(data, textStatus){
			if(data.trim()=='delete_success'){	
				alert("회원을 삭제하였습니다.");
			}
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	});
}

function fn_modify_member_info(_member_id, mod_type){
	var member_id=document.getElementById('member_id').value;
	var value;

	/*     alert(member_id); */
	// alert("mod_type:"+mod_type);
		var frm_mod_member=document.frm_mod_member;
		if(mod_type=='member_pw'){
			value=frm_mod_member.member_pw.value;
			//alert("member_pw:"+value);
		}else if(mod_type=='member_gender'){
			var member_gender=frm_mod_member.member_gender;
			for(var i=0; member_gender.length;i++){
			 	if(member_gender[i].checked){
					value=member_gender[i].value;
					break;
				} 
			}
			//alert("member_gender111:"+value);
			
		}else if(mod_type=='member_birth'){
			var member_birth_y=frm_mod_member.member_birth_y;
			var member_birth_m=frm_mod_member.member_birth_m;
			var member_birth_d=frm_mod_member.member_birth_d;
			var member_birth_gn=frm_mod_member.member_birth_gn;
			for(var i=0; member_birth_y.length;i++){
			 	if(member_birth_y[i].selected){
					value_y=member_birth_y[i].value;
					break;
				} 
			}
			for(var i=0; member_birth_m.length;i++){
			 	if(member_birth_m[i].selected){
					value_m=member_birth_m[i].value;
					break;
				} 
			}
			
			for(var i=0; member_birth_d.length;i++){
			 	if(member_birth_d[i].selected){
					value_d=member_birth_d[i].value;
					break;
				} 
			}
			
			//alert("수정 년:"+value_y+","+value_m+","+value_d);
			for(var i=0; member_birth_gn.length;i++){
			 	if(member_birth_gn[i].checked){
					value_gn=member_birth_gn[i].value;
					break;
				} 
			}
			//alert("생년 양음년 "+value_gn);
			value=+value_y+","+value_m+","+value_d+","+value_gn;
		}else if(mod_type=='tel'){
			var tel1=frm_mod_member.tel1;
			var tel2=frm_mod_member.tel2;
			var tel3=frm_mod_member.tel3;
			
			for(var i=0; tel1.length;i++){
			 	if(tel1[i].selected){
					value_tel1=tel1[i].value;
					break;
				} 
			}
			value_tel2=tel2.value;
			value_tel3=tel3.value;
			
			value=value_tel1+","+value_tel2+", "+value_tel3;
		}else if(mod_type=='hp'){
			var hp1=frm_mod_member.hp1;
			var hp2=frm_mod_member.hp2;
			var hp3=frm_mod_member.hp3;
			var smssts_yn=frm_mod_member.smssts_yn;
			
			for(var i=0; hp1.length;i++){
			 	if(hp1[i].selected){
					value_hp1=hp1[i].value;
					break;
				} 
			}
			value_hp2=hp2.value;
			value_hp3=hp3.value;
			value_smssts_yn=smssts_yn.checked;
			
			value=value_hp1+","+value_hp2+", "+value_hp3+","+value_smssts_yn;
			
		}else if(mod_type=='email'){
			var email1=frm_mod_member.email1;
			var email2=frm_mod_member.email2;
			var emailsts_yn=frm_mod_member.emailsts_yn;
			
			value_email1=email1.value;
			value_email2=email2.value;
			value_emailsts_yn=emailsts_yn.checked;
			
			value=value_email1+","+value_email2+","+value_emailsts_yn;
			//alert(value);
		}else if(mod_type=='address'){
			var zipcode=frm_mod_member.zipcode;
			var roadAddress=frm_mod_member.roadAddress;
			var jibunAddress=frm_mod_member.jibunAddress;
			var namujiAddress=frm_mod_member.namujiAddress;
			
			value_zipcode=zipcode.value;
			value_roadAddress=roadAddress.value;
			value_jibunAddress=jibunAddress.value;
			value_namujiAddress=namujiAddress.value;
			
			value=value_zipcode+","+value_roadAddress+","+value_jibunAddress+","+value_namujiAddress;
		}
		
	$.ajax({
		type:"PUT",
		url:"${contextPath}/admin/member/"+member_id,
		contentType:"application/json",
		data:JSON.stringify({
			member_id:member_id,
			mod_type:mod_type,
			value:value
		}),
		success:function(data, textStatus){
			if(data.trim()=='mod_success'){	
				alert("회원을 수정하였습니다.");
			}
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	});
}

</script>
</head>
<body>
	<H3>회원 조회</H3>
	<form name="frm_delivery_list" >	
		<table cellpadding="10" cellspacing="10"  >
			<tbody>
				<tr>
					<td>
						<input type="radio" name="r_search_option" value="simple_search" checked onClick="fn_enable_detail_search(this)"/> 간단조회 &nbsp;&nbsp;&nbsp;
						<input type="radio" name="r_search_option" value="detail_search"  onClick="fn_enable_detail_search(this)" /> 상세조회 &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>
					  <select name="curYear">
					     <c:forEach   var="i" begin="0" end="5">
					      <c:choose>
					        <c:when test="${endYear==endYear-i}">
					          <option value="${endYear }" selected>${endYear  }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${endYear-i }">${endYear-i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>
					</select>년 <select name="curMonth" >
						 <c:forEach   var="i" begin="1" end="12">
					      <c:choose>
					        <c:when test="${endMonth==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${i }">${i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>					
					</select>월
					
					 <select name="curDay">
					  <c:forEach   var="i" begin="1" end="31">
					      <c:choose>
					        <c:when test="${endDay==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${i }">${i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>일  &nbsp;이전&nbsp;&nbsp;&nbsp;&nbsp; 
					<a href="javascript:search_member('today')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_one_day.jpg">
					</a>
					<a href="javascript:search_member('one_week')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_1_week.jpg">
					</a>
					<a href="javascript:search_member('two_week')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_2_week.jpg">
					</a>
					<a href="javascript:search_member('one_month')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_1_month.jpg">
					</a>
					<a href="javascript:search_member('two_month')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_2_month.jpg">
					</a>
					<a href="javascript:search_member('three_month')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_3_month.jpg">
					</a>
					<a href="javascript:search_member('four_month')">
					   <img   src="${pageContext.request.contextPath}/resources/image/btn_search_4_month.jpg">
					</a>
					&nbsp;까지 조회
					</td>
				</tr>
				
				<tr>
				  <td>
					조회 기간:
					<select name="beginYear" disabled>
					 <c:forEach   var="i" begin="0" end="5">
					      <c:choose>
					        <c:when test="${beginYear==beginYear-i }">
					          <option value="${beginYear-i }" selected>${beginYear-i  }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${beginYear-i }">${beginYear-i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>
					</select>년 
					<select name="beginMonth" disabled >
						 <c:forEach   var="i" begin="1" end="12">
					      <c:choose>
					        <c:when test="${beginMonth==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i <10 }">
					              <option value="0${i }">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i }">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>					
					</select>월
					 <select name="beginDay" disabled >
					  <c:forEach   var="i" begin="1" end="31">
					      <c:choose>
					        <c:when test="${beginDay==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i <10 }">
					              <option value="0${i }">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i }">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>일  &nbsp; ~
					
					<select name="endYear" disabled >
					 <c:forEach   var="i" begin="0" end="5">
					      <c:choose>
					        <c:when test="${endYear==endYear-i }">
					          <option value="${2016-i }" selected>${2016-i  }</option>
					        </c:when>
					        <c:otherwise>
					          <option value="${2016-i }">${2016-i }</option>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>
					</select>년 
					<select name="endMonth" disabled >
						 <c:forEach   var="i" begin="1" end="12">
					      <c:choose>
					        <c:when test="${endMonth==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i <10 }">
					              <option value="0${i }">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i }">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>					
					</select>월
					 <select name="endDay" disabled >
					  <c:forEach   var="i" begin="1" end="31">
					      <c:choose>
					        <c:when test="${endDay==i }">
					          <option value="${i }"  selected>${i }</option>
					        </c:when>
					        <c:otherwise>
					          <c:choose>
					            <c:when test="${i<10}">
					              <option value="0${i}">0${i }</option>
					            </c:when>
					            <c:otherwise>
					            <option value="${i}">${i }</option>
					            </c:otherwise>
					          </c:choose>
					        </c:otherwise>
					      </c:choose>
					    </c:forEach>	
					</select>
												 
				  </td>
				</tr>
				<tr>
				  <td>
				    <select name="s_search_type" disabled >
						<option value="all" checked>전체</option>
						<option value="member_name">회원이름</option>
						<option value="member_id">회원아이디</option>
						<option value="member_hp_num">회원휴대폰번호</option>
						<option value="member_addr">회원주소</option>
					</select>
					<input  type="text"  size="30" name="t_search_word" disabled />  
					<input   type="button"  value="조회" name="btn_search" onClick="fn_detail_search()" disabled  />
				  </td>
				</tr>				
			</tbody>
		</table>
		<div class="clear">
	</div>
	
<div class="clear"></div>
<table class="list_view">
		<tbody align=center >
			<tr align=center bgcolor="#ffcc00">
				<td class="fixed" >회원아이디</td>
				<td class="fixed">회원이름</td>
				<td>휴대폰번호</td>
				<td>주소</td>
				<td>가입일</td>
				<td>탈퇴여부</td>
			</tr>
   <c:choose>
     <c:when test="${empty member_list}">			
			<tr>
		       <td colspan=5 class="fixed">
				  <strong>조회된 회원이 없습니다.</strong>
			   </td>
		     </tr>
	 </c:when>
	 <c:otherwise>
	     <c:forEach var="item" items="${member_list}" varStatus="item_num">
	            <tr >       
					<td width=10%>
					
					  <a href="javascript:fn_member_detail_show('${item.member_id}')">
					     <strong>${item.member_id}</strong>
					  </a>
					</td>
					<td width=10%>
					  <strong>${item.member_name}</strong><br>
					</td>
					<td width=10% >
					  <strong>${item.hp1}-${item.hp2}-${item.hp3}</strong><br>
					</td>
					<td width=50%>
					  <strong>${item.roadAddress}</strong><br>
					  <strong>${item.jibunAddress}</strong><br>
					  <strong>${item.namujiAddress}</strong><br>
					</td>
					<td width=10%>
					   <c:set var="join_date" value="${item.joinDate}" />
					   <c:set var="arr" value="${fn:split(join_date,' ')}" />
					   <strong><c:out value="${arr[0]}" /></strong>
				    </td>
				    <td width=10%>
				       <c:choose>
				         <c:when test="${item.del_yn=='N' }">
				           <strong>활동중</strong>  
				         </c:when>
				         <c:otherwise>
				           <strong>탈퇴</strong>
				         </c:otherwise>
				       </c:choose>
				    </td>
				</tr>
		</c:forEach>
	</c:otherwise>
  </c:choose>	
         <tr>
             <td colspan=8 class="fixed">
                 <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${chapter >1 && page==1 }">
		          <a href="${pageContext.request.contextPath}/admin/member/adminMemberMain.do?chapter=${chapter-1}&pageNum=${(chapter-1)*10 +1 }">&nbsp;pre &nbsp;</a>
		         </c:if>
		          <a href="${pageContext.request.contextPath}/admin/member/adminMemberMain.do?chapter=${chapter}&pageNum=${page}">${(chapter-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${pageContext.request.contextPath}/admin/member/adminMemberMain.do?chapter=${chapter+1}&pageNum=${chapter*10+1}">&nbsp; next</a>
		         </c:if> 
	      		</c:forEach> 
           </td>
        </tr>  		   
		</tbody>
	</table>
  </form>   	
	<div class="clear"></div>
<c:choose>
 <c:when test="${not empty order_goods_list }">	
   <DIV id="page_wrap">
		 <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${chapter >1 && page==1 }">
		          <a href="${pageContext.request.contextPath}/admin/member/adminMemberMain.do?chapter=${chapter-1}&pageNum=${(chapter-1)*10 +1 }">&nbsp;pre &nbsp;</a>
		         </c:if>
		          <a href="${pageContext.request.contextPath}/admin/member/adminMemberMain.do?chapter=${chapter}&pageNum=${page}">${(chapter-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${pageContext.request.contextPath}/admin/member/adminMemberMain.do?chapter=${chapter+1}&pageNum=${chapter*10+1}">&nbsp; next</a>
		         </c:if> 
	      </c:forEach> 
	</DIV>	
 </c:when>
</c:choose>

<form name="frm_mod_member">
	<div id="detail_table">
		
		<div class="modal_content">
				<table>
					<tbody>
						<tr class="dot_line">
							<td class="fixed_join">아이디</td>
							<td>
								<input name="member_id" id="member_id" type="text" size="20" value="${member_info.member_id }"  disabled/>
							</td>
							 <td>
							  <input type="button" value="수정하기" disabled onClick="fn_modify_member_info('${member_info.member_id }','member_name')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">비밀번호</td>
							<td>
							  <input id="member_pw" name="member_pw" type="password" size="20" value="${member_info.member_pw }" />
							</td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','member_pw')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">이름</td>
							<td>
							  <input name="member_name" type="text" size="20" value="${member_info.member_name }"  disabled />
							 </td>
							 <td>
							  <input type="button" value="수정하기" disabled onClick="fn_modify_member_info('${member_info.member_id }','member_name')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">성별</td>
							<td>
							  <c:choose >
							    <c:when test="${member_info.member_gender =='101' }">
							      <input type="radio" name="member_gender" value="102" />
								  여성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							   <input type="radio" name="member_gender" value="101" checked />남성
							    </c:when>
							    <c:otherwise>
							      <input type="radio" name="member_gender" value="102"  checked />
								   여성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							      <input type="radio" name="member_gender" value="101"  />남성
							   </c:otherwise>
							   </c:choose>
							</td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','member_gender')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">법정생년월일</td>
							<td>
							   <select name="member_birth_y">
							     <c:forEach var="i" begin="1" end="100">
							       <c:choose>
							         <c:when test="${member_info.member_birth_y==1920+i }">
									   <option value="${ 1920+i}" selected>${ 1920+i} </option>
									</c:when>
									<c:otherwise>
									  <option value="${ 1920+i}" >${ 1920+i} </option>
									</c:otherwise>
									</c:choose>
							   	</c:forEach>
							</select>년 
							<select name="member_birth_m" >
								<c:forEach var="i" begin="1" end="12">
							       <c:choose>
							         <c:when test="${member_info.member_birth_m==i }">
									   <option value="${i }" selected>${i }</option>
									</c:when>
									<c:otherwise>
									  <option value="${i }">${i }</option>
									</c:otherwise>
									</c:choose>
							   	</c:forEach>
							</select>월 
							
							<select name="member_birth_d">
									<c:forEach var="i" begin="1" end="31">
							       <c:choose>
							         <c:when test="${member_info.member_birth_d==i }">
									   <option value="${i }" selected>${i }</option>
									</c:when>
									<c:otherwise>
									  <option value="${i }">${i }</option>
									</c:otherwise>
									</c:choose>
							   	</c:forEach>
							</select>일 
							
							   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							   <c:choose>
							    <c:when test="${member_info.member_birth_gn=='2' }"> 
							  <input type="radio" name="member_birth_gn" value="2" checked />양력
								&nbsp;&nbsp;&nbsp; 
								<input type="radio"  name="member_birth_gn" value="1" />음력
								</c:when>
								<c:otherwise>
								  <input type="radio" name="member_birth_gn" value="2" />양력
								   &nbsp;&nbsp;&nbsp; 
								<input type="radio"  name="member_birth_gn" value="1" checked  />음력
								</c:otherwise>
								</c:choose>
							</td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','member_birth')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">전화번호</td>
							<td>
							    <select  name="tel1" >
									<option>없음</option>
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="044">044</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="0502">0502</option>
									<option value="0503">0503</option>
									<option value="0505">0505</option>
									<option value="0506">0506</option>
									<option value="0507">0507</option>
									<option value="0508">0508</option>
									<option value="070">070</option>
							</select> 
							    - <input type="text" size=4  name="tel2" value="${member_info.tel2 }"> 
							    - <input type="text" size=4  name="tel3" value="${member_info.tel3 }">
							</td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','tel')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">휴대폰번호</td>
							<td>
							   <select  name="hp1">
									<option>없음</option>
									<option selected value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
							</select> 
							 - <input type="text" name="hp2" size=4 value="${member_info.hp2 }"> 
							 - <input type="text"name="hp3"  size=4 value="${member_info.hp3 }"><br> <br>
							 <c:choose> 
							   <c:when test="${member_info.smssts_yn=='true' }">
							     <input type="checkbox"  name="smssts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
								</c:when>
								<c:otherwise>
								  <input type="checkbox"  name="smssts_yn" value="N"  /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
								</c:otherwise>
							 </c:choose>	
						    </td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','hp')" />
							</td>	
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">이메일(e-mail)</td>
							<td>
							   <input type="text" name="email1" size=10 value="${member_info.email1 }" /> @ <input type="text" size=10  name="email2" value="${member_info.email2 }" /> 
							   <select name="select_email2" onChange=""  title="직접입력">
									<option value="non">직접입력</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="paran.com">paran.com</option>
									<option value="nate.com">nate.com</option>
									<option value="google.com">google.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="empal.com">empal.com</option>
									<option value="korea.com">korea.com</option>
									<option value="freechal.com">freechal.com</option>
							</select><Br><br> 
							<c:choose> 
							   <c:when test="${member_info.emailsts_yn=='true' }">
							     <input type="checkbox" name="emailsts_yn"  value="Y" checked /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
								</c:when>
								<c:otherwise>
								  <input type="checkbox" name="emailsts_yn"  value="N"  /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
								</c:otherwise>
							 </c:choose>
							</td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','email')" />
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">주소</td>
							<td>
							   <input type="text" id="zipcode" name="zipcode" size=5 value="${member_info.zipcode }" > <a href="javascript:execDaumPostcode()">우편번호검색</a>
							  <br>
							  <p> 
							   지번 주소:<br><input type="text" id="roadAddress"  name="roadAddress" size="50" value="${member_info.roadAddress }"><br><br>
							  도로명 주소: <input type="text" id="jibunAddress" name="jibunAddress" size="50" value="${member_info.jibunAddress }"><br><br>
							  나머지 주소: <input type="text"  name="namujiAddress" size="50" value="${member_info.namujiAddress }" />
							   <span id="guide" style="color:#999"></span>
							   </p>
							</td>
							<td>
							  <input type="button" value="수정하기" onClick="fn_modify_member_info('${member_info.member_id }','address')" />
							</td>
						</tr>
					</tbody>
	
				</table>
				<tr>																					
					<input type="button" value="회원삭제" onClick="fn_delete_member()" />
				</tr>
			</div>
	
	
			<div class="modal_layer"></div>
	
	</div>
</form>
<div><a href="${contextPath}/member/memberForm.do"><input type="button" value="회원 등록"/></a></div>
</body>
</html>

