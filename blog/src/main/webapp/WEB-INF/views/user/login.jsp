<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
$(function () {
	var msg = "${msg}";
	if(msg == "fail"){
		alert("아이디 비밀번호를 확인해 주세요");
	}
});
</script>
<div class="container-fluid">

	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<form role="form" action="/user/login" method="post">
				<div class="form-group">
					 
					<label for="user_id">아이디</label>
					<input type="text" class="form-control" id="user_id" name="user_id"
						required />
				</div>
				<div class="form-group">
					<label for="user_pw">비밀번호</label>
					<input type="password" class="form-control" id="user_pw" name="user_pw" 
						required />
				</div>
				<div style="text-align: right; margin-bottom: 10px;">
					<button type="submit" class="btn btn-success">로그인</button>
				</div>
			</form>
			<div style="text-align: right;">
				<a href="/user/join" class="btn btn-primary btn-sm"> 회원가입</a>
				<a href="/user/findPw" class="btn btn-warning btn-sm">비밀번호 찾기</a>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>