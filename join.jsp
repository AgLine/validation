<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>회원가입</title>
<script>
	//한글입력만
	var regName = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g; 
	$(document).on("keyup", "input[koreanOnly]", function() {$(this).val( $(this).val().replace( regName ,"") );})
	
	//영어,숫자입력만
	var regEmail = /[^a-zA-Z0-9]/gi;
	$(document).on("keyup", "input[engNum]", function() {$(this).val( $(this).val().replace( regEmail ,"") );})
	
	//숫자입력만
	var regNum = /[^0-9]/gi;
	$(document).on("keyup", "input[numOnly]", function() {$(this).val( $(this).val().replace( regNum ,"") );})
	
	//폰번호 입력시 000-0000-0000 하이픈 생성
	$(document).on("keyup", "#phone", function() { 
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
	});
	
	$(document).ready(function() {		 		 		 
		$('input[type="checkbox"][name="agency"]').click(function(){//체크박스 클릭이 발생했을때
			if($(this).prop('checked')){ //만약에 체크박스가 클릭되어있으면,
			   $('input[type="checkbox"][name="agency"]').prop('checked',false);//checkbox 전체를 checked 해제 후, 
			   $(this).prop('checked',true);//click한 요소만 true 지정
			   if($("#etc").prop("checked")){
				   $("#otherAgency").show();
			   }else{
				   $("#otherAgency").hide();
			   }
			}
		
		});
	});
	
	function fn_checkClick(){
		var userName =$("#userName").val();//이름
		var userNum =$("#userNum").val();//주민번호앞자리
		var userNum2 =$("#userNum2").val();//주민번호뒷자리
		var userEmail =$("#userEmail").val();//이메일
		var email =$("#email").val();//이메일도메인
		var phone =$("#phone").val();//전화번호 하이픈포함
		var userAgency;//통신사
		
		if($("#userName").val() == ""){//이름
			$("#userName").focus();
			return;
		}
		
		if($("#userNum").val() == ""){//주민번호앞자리
			$("#userNum").focus();
			return;
		}
		
		if($("#userNum2").val() == ""){//주민번호뒷자리
			$("#userNum2").focus();
			return;
		}
		
		if($("#userNum").val() == ""){//주민번호앞자리
			$("#userNum").focus();
			return;
		}
		
		if($("#phone").val() == ""){//전화번호
			$("#phone").focus();
			return;
		}
		
		if($("#userEmail").val() == ""){//이메일
			$("#userEmail").focus();
			return;
		}
		
		if($("#email").val() == "선택"){//이메일
			$("#email").focus();
			return;
		}
		
		if($('input[name=agency]').is(':checked')){//통신사 체크가 되어있는가
			$('input:checkbox[name=agency]').each(function (index) {//있다면 
				if($(this).is(":checked")==true){
					userAgency = $(this).val();//해당값 저장
					if(userAgency == "etc"){//알뜰폰이 체크되었다면
						userAgency = $("#otherAgency").val();
						if(userAgency == "선택");{// 알뜰폰 통신사를 선택하지 않았다면
							$("#otherAgency").focus();
							return;
						}
						//console.log(userAgency);
					}
			    }
			});
		}else{//아니라면 통신사에 강조를해야하는데 흐으으으음
			$('#tel').focus();//해당위치강조
			return;
		}

		var phoneNum = phone.replace(/-/g,"");//하이픈제거 전화번호
		
		/*
		console.log(userName);
		console.log(userNum);
		console.log(userNum2);
		console.log(userEmail);
		console.log(email);
		console.log(phone);
		console.log(phoneNum);
		*/
		var addHtml="";
		addHtml += "결과<br>";
		addHtml += "이름 : "+userName+"<br>";
		addHtml += "주민번호 : "+userNum+"-"+userNum2+"XXXXX<br>";
		addHtml += userAgency+" "+phoneNum+"<br>";
		addHtml += userEmail+"@"+email+"<br>";
		
		$("#result").append(addHtml);
	}
</script>
</head>
<body>
	<p style="text-align: center;">회원가입</p>
	이름 : <input type="text" id="userName" maxlength="6" koreanOnly>
	<br>
	주민번호 : <input type="text" id="userNum" maxlength="6" numOnly>-<input type="text" id="userNum2" maxlength="1" numOnly>XXXXX
	<br>
	<div id="tel">
	통신사 :  <input type="checkbox" name="agency" id="sk" value="sk">SK 
			<input type="checkbox" name="agency" id="kt" value="kt">KT 
			<input type="checkbox" name="agency" id="lg" value="lg">LG 
			<input type="checkbox" name="agency" id="etc" value="etc">알뜰
			<select id="otherAgency" hidden>
				<option value="선택" hidden>선택</option>
				<option value="SK알뜰">SK알뜰</option>
				<option value="KT알뜰">KT알뜰</option>
				<option value="CJ모바일">CJ모바일</option>
			</select>
	<br> 
	</div>
	전화번호: <input type="text" maxlength="13" id="phone">
	<br>
	이메일 : <input type="text" id="userEmail" maxlength="20" engNum> @ 
	<select id="email">
		<option value="선택" hidden>선택</option>
		<option value="naver.com">naver.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="daum.com">daum.com</option>
	</select>
	<br>
	<button onclick="fn_checkClick();">확인</button>
	<div id="result" >
	
	</div>
</body>
</html>