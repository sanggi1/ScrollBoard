<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>
<style>
	p {
	color: black;
	text-align: center;
	}
	.form {
		margin-bottom: 15px;
	}
	#sendMail{
		margin-bottom: 15px;
	}
</style>
<script>
$(function () {
	
	$("#sendMail").click(function () {
		var user_id = $("#user_id").val();
		var user_email = $("#user_email").val();
		var checkEmailUrl = "/user/checkEmail"
		var sendMailUrl = "/email/sendMail";
		var sendData = {
				"user_id" : user_id,
				"user_email" : user_email
			};
		$.ajax({//이메일 체크
			"type" : "post",  
			"url" : checkEmailUrl,
			"dataType" : "text",
			"data" : JSON.stringify(sendData),
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "post"
			},
			success : function (rData) {
				if(rData == "possible"){ //이메일, 아이디가 일치한 정보가 있으면 인증 코드를 보냄
					$.ajax({
						"type" : "post",  
						"url" : sendMailUrl,
						"dataType" : "text",
						"data" : user_email,
						"headers" : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "post"
						},
						"success" : function (rData) {
							console.log(rData);
							$("#sendCode").val(rData);
							$("#formDiv").attr("style","visibility: visible;");
							alert("전송된 임시 비밀번호를 확인하세요");
						}
					});//인증코드 보내기 ajax
				} else if(rData == "impossible"){
					alert("입력하신 정보와 일치하는 회원이 없습니다.");
				}
				
			}
		});//이메일 체크 ajax
		

	});//이메일 인증
	
	$("#pwForm").submit(function () {
		var code = $("#code").val();
		var sendCode = $("#sendCode").val();
		$("#id").val($("#user_id").val());
		console.log(code);
		console.log(sendCode);
		if(sendCode != code){
			$("#codeSpan").text("인증코드를 다시 확인하세요.").css("color","red");
			return false;
		}
	});
});
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<h3>비밀번호 찾기</h3>
			<span>이메일로 인증번호가 전송 됩니다.</span>
			
			<div class="form">
				<label>아이디</label>
				<input type="text" class="form-control form-control-user" id="user_id" name="user_id" placeholder="아이디">
			</div>
			<div class="form">
				<label>이메일</label>
				<input type="email" class="form-control form-control-user" id="user_email" name="user_email" placeholder="이메일">
			</div>
			<button type="button" id="sendMail" class="btn btn-primary btn-user btn-block">전송</button>
			
			<div id="formDiv" style="visibility: hidden;">
				<form id="pwForm" action="/user/updatePw" method="get">
					<input type="hidden" name="id" id="id">
					<input type="text" id="code" class="form-control" placeholder="인증코드를 입력하세요">
					<button type="submit" class="btn btn-primary">인증</button>
					<span id="codeSpan"></span>
				</form>
			</div>
			
			<input type="hidden" id="sendCode">
		</div>
		<div class="col-md-3"></div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>