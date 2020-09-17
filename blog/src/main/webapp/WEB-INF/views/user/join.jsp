<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
$(function () {
	//비밀번호 양식 확인
	$("#user_pw").focusout(function () {
		var pw = $("#user_pw").val();
		for(var v= 0 ; v < pw.length ; v++){
			var ch = pw.charCodeAt(v);
			if( (ch < 97 || ch > 122) && (ch < 48 || ch > 57) ) {
				$("#pwSpan").text("영어 소문자, 숫자로 입력하세요.").css("color","red");
			} else {
				$("#pwSpan").text("");
			}
		};
	});
	//비밀번호 일치 확인
	$("#user_pw2").focusout(function () {
		var pw = $("#user_pw").val();
		var pw2 = $("#user_pw2").val();
		if(pw == pw2){
			$("#pw2Span").text("비밀번호 일치").css("color","blue");
		} else if(pw == ""){
			$("#pw2Span").text("비밀번호 불일치").css("color","red");
		} else{
			$("#pw2Span").text("비밀번호 불일치").css("color","red");
		}
	});
	
	//아이디 양식 확인
	$("#user_id").focusout(function () {
		var user_id = $("#user_id").val();
		var url = "/user/checkId";
		var sendData = {
				"user_id" : user_id 
		}
		//아이디 영소문자, 숫자
		for(var v= 0 ; v < user_id.length ; v++){
			var ch = user_id.charCodeAt(v);
			if((ch < 97 || ch > 122) && (ch < 48 || ch > 57)) {
				$("#idSpan").text("영어 소문자, 숫자로 입력하세요.").css("color","red");
			} else {
				$.get(url, sendData, function (rData) {
					console.log(rData);
					if (rData == "impossible"){
						$("#idSpan").text("이미 사용중인 아이디 입니다.").css("color","red");
						$("#btnInsert").attr("disabled",true);
					} else {
						$("#idSpan").text("사용 가능한 아이디 입니다.").css("color","blue");
						//아이디 사용가능일때 가입버튼 활성화
						$("#btnInsert").attr("disabled",false);
					}
				});
			}
		}
		
		
	});
});
</script>
<div class="container-fluid">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<form role="form" action="/user/join" method="post">
				<div class="form-group">
					 
					<label for="user_id">아이디</label>
					<input type="text" class="form-control" id="user_id" name="user_id" maxlength="15" required />
					<span id="idSpan"></span>
				</div>
				<div class="form-group">
					<label for="user_pw">비밀번호</label>
					<input type="password" class="form-control" id="user_pw" name="user_pw" maxlength="15" required />
					<span id="pwSpan"></span>
				</div>
				<div class="form-group">
					<label for="user_pw">비밀번호 확인</label>
					<input type="password" class="form-control" id="user_pw2" name="user_pw2" maxlength="15" required />
					<span id="pw2Span"></span>
				</div>
				<div class="form-group">
					<label for="user_name">이름</label>
					<input type="text" class="form-control" id="user_name" name="user_name" required />
				</div>
				<div class="form-group">
					<label for="user_email">이메일</label>
					<input type="email" class="form-control" id="user_email" name="user_email" maxlength="30" required />
				</div>
				
				<button id="btnInsert" type="submit" class="btn btn-primary" disabled>회원가입</button>
			</form>
		</div>
		<div class="col-md-2"></div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>