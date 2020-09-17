<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>
<style>

</style>
<script>
$(function () {
	
	//비밀번호 양식 확인
	$("#updateform").submit(function (e) {
		var pw = $("#user_pw").val();
		console.log(pw);
		for(var v= 0 ; v < pw.length ; v++){
			var ch = pw.charCodeAt(v);
			if( (ch < 97 || ch > 122) && (ch < 48 || ch > 57) ){
				$("#pwSpan").text("영어 소문자, 숫자로 입력하세요.").css("color","red");
				return false;
			} else {
				$("#pwSpan").text("");
			}
		};
	});
});
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<form role="form" id="updateform" action="/user/updatePw" method="post">
					<input type="hidden" class="form-control" id="user_id" name="user_id" value="${user_id}" maxlength="15" required />
				<div class="form-group">
					<label for="user_pw">비밀번호</label>
					<input type="password" class="form-control" id="user_pw" name="user_pw" maxlength="15" required />
					<span id="pwSpan"></span>
				</div>
				
				<button id="btnUpdate" type="submit" class="btn btn-primary">확인</button>
			</form>
		</div>
		<div class="col-md-3"></div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>