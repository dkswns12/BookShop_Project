<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }
      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;
/*       // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      } */
      
     
    }
  }).open();
}
function fn_overlapped(){
    var _id=$("#_member_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/member/overlapped.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data=='false'){
       	    alert("사용할 수 있는 ID입니다.");
       	    $('#btnOverlapped').prop("disabled", true);
       	    $('#_member_id').prop("disabled", true);
       	    $('#member_id').val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");ㅣ
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }	
 
function fn_compare_pw(){
	 var pw1=$('#member_pw').val();
	 var pw2=$('#member_pw2').val();
	 
	 if(pw1==pw2){
		 $('#s_result').text("비밀번호 일치합니다.");
	 } else{
		 $('#s_result').text("비밀번호가 일치하지 않습니다.");
	 }
	 
}

function fn_create_member(){
	 
	 var form=document.getElementById("add_member");
	 
	 var member_id=form._member_id.value;
	 var member_pw=form.member_pw.value;
	 
	 var member_name=form.member_name.value;
	 var member_gender=form.member_gender.value;
	 
	 var select_member_birth_y=document.getElementById("member_birth_y");
	 var member_birth_y=select_member_birth_y.options[select_member_birth_y.selectedIndex].value;
	 
	 var select_member_birth_m=document.getElementById("member_birth_m");
	 var member_birth_m=select_member_birth_m.options[select_member_birth_m.selectedIndex].value;
	 
	 var select_member_birth_d=document.getElementById("member_birth_d");
	 var member_birth_d=select_member_birth_d.options[select_member_birth_d.selectedIndex].value;
	 
	 var member_birth_gn=form.member_birth_gn.value;
	 
	 var select_tel1=document.getElementById("tel1");
	 var tel1=select_tel1.options[select_tel1.selectedIndex].value;
	 var tel2=form.tel2.value;
	 var tel3=form.tel3.value;
	 
	 var select_hp1=document.getElementById("hp1");
	 var hp1=select_hp1.options[select_hp1.selectedIndex].value;
	 var hp2=form.hp2.value;
	 var hp3=form.hp3.value;
	 
	 var zipcode=form.zipcode.value;
	 var roadAddress=form.roadAddress.value;
	 
	 var jibunAddress=form.jibunAddress.value;
	 var namujiAddress=form.namujiAddress.value;
	 
	 var member_data={
			 member_id:member_id, 
			 member_pw:member_pw, 
			 member_name:member_name, 
			 member_gender:member_gender, 
			 member_birth_y:member_birth_y, 
			 member_birth_m:member_birth_m, 
			 member_birth_d:member_birth_d
			 ,member_birth_gn:member_birth_gn, 
			 tel1:tel1, 
			 tel2:tel2, 
			 tel3:tel3, 
			 hp1:hp1, 
			 hp2:hp2, 
			 hp3:hp3, 
			 zipcode:zipcode, 
			 roadAddress:roadAddress, 
			 jibunAddress:jibunAddress, 
			 namujiAddress:namujiAddress
	 };
	 
	 $.ajax({
		type:"POST",
		url:"${contextPath}/admin/member",
		contentType:"application/json",
		data:JSON.stringify(member_data),
		success:function(data, textStatus){
			if(data.trim()=='success'){
				alert("회원 등록이 완료 되었습니다.");
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
	<h3>필수입력사항</h3>
	<form id="add_member">		
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
					  <input type="text" name="_member_id"  id="_member_id"  size="20" />
					  <input type="hidden" name="member_id"  id="member_id" />
					  
					  <input type="button"  id="btnOverlapped" value="중복체크" onClick="fn_overlapped()" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td><input id="member_pw" name="member_pw" type="password" size="20" /></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호확인</td>
					<td>
						<input name="member_pw2" id="member_pw2" type="password" size="20" onKeyUp="fn_compare_pw()" />
						<span style="font-size:14px" id="s_result">비밀번호가 일치하지 않습니다.</span>
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td><input name="member_name" type="text" size="20" /></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">성별</td>
					<td><input type="radio" name="member_gender" value="102" />
						여성<span style="padding-left:120px"></span>
						 <input type="radio" name="member_gender" value="101" checked />남성
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">법정생년월일</td>
					<td>
					<select name="member_birth_y" id="member_birth_y">
					 
					     <c:forEach var="year" begin="1" end="100">
					       <c:choose>
					         <c:when test="${year==80}">
							   <option value="${ 1920+year}" selected>${ 1920+year} </option>
							</c:when>
							<c:otherwise>
							  <option value="${ 1920+year}" >${ 1920+year} </option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach> 
							
					</select>년 
					 <select name="member_birth_m" id="member_birth_m" >
					   <c:forEach var="month" begin="1" end="12">
					       <c:choose>
					         <c:when test="${month==5 }">
							   <option value="${month }" selected>${month }</option>
							</c:when>
							<c:otherwise>
							  <option value="${month }">${month}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>월  
					<select name="member_birth_d" id="member_birth_d">
							<c:forEach var="day" begin="1" end="31">
					       <c:choose>
					         <c:when test="${day==10 }">
							   <option value="${day}" selected>${day}</option>
							</c:when>
							<c:otherwise>
							  <option value="${day}">${day}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>일 <span style="padding-left:50px"></span>
					  <input type="radio" name="member_birth_gn" value="2" checked />양력
						 <span style="padding-left:50px"></span>
						<input type="radio"  name="member_birth_gn" value="1" />음력
				  </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">전화번호</td>
					<td><select  name="tel1" id="tel1">
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
					   </select> - <input  size="10px" type="text" name="tel2"  id="tel2"> - <input size="10px"  type="text" name="tel3"  id="tel3">
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td><select  name="hp1" id="hp1">
							<option>없음</option>
							<option selected value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
					</select> - <input size="10px"  type="text" name="hp2"> - <input size="10px"  type="text"name="hp3"><br> <br> 
					<input type="checkbox"	name="smssts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					<td><input size="10px"   type="text" name="email1" /> @ <input  size="10px"  type="text"name="email2" /> 
						  <select name="email2" onChange=""	title="직접입력">
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
							</select><br> <br> <input type="checkbox" name="emailsts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 e-mail을 수신합니다.</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					   <input type="text" id="zipcode" name="zipcode" size="10" > <a href="javascript:execDaumPostcode()">우편번호검색</a>
					  <br>
					  <p> 
					   지번 주소:<br><input type="text" id="roadAddress"  name="roadAddress" size="50"><br><br>
					  도로명 주소: <input type="text" id="jibunAddress" name="jibunAddress" size="50"><br><br>
					  나머지 주소: <input type="text"  name="namujiAddress" size="50" />
					 <!--   <span id="guide" style="color:#999"></span> -->
					   </p>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
		</form>
		<div class="clear">
		<br><br>
		<table align=center>
		<tr >
			<td >
				<input type="button"  value="회원 등록" onClick="fn_create_member()">
				<input  type="reset"  value="다시입력">
			</td>
		</tr>
	</table>
	</div>
</form>	
</body>
</html>