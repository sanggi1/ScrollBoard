<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>
<style>
 #board{
	background-color: white;
	margin-bottom: 10px;
	padding: 10px;
	border-radius: 8px; 
 }
 
 .oriImg{
	width : 130px; 
 	height: 130px; 
	vertical-align: middle;
	margin : 5px;
}
.boardImg {
	text-align: center;
}

.btn-warning{
	margin-right: 5px;
}

#scrollTopBtn {
    display: none;
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 99;
    border: 1px;
    border-style: solid;
    border-color: rgba(77,77,77,0.1);
    outline: none;
    background-color: #212121;
    color: #ffffff;
    font-size: 1em;
    font-weight: bold;
    cursor: pointer;
    padding: 25px 29px;
    border-radius: 1px;
}

#scrollTopBtn:hover {
  background-color: #3c8dbc;
    border: 1px;
    border-style: solid; 
    border-color: rgba(77,77,77,0.1);
}
</style>
<script>
$(function () {
	var user_id = "${sessionScope.user_id}";
//메시지
	var msg = "${msg}";
	if (msg == "success") {
		alert("게시글 등록 성공");
	} else if(msg == "update"){
		alert("게시글 수정 성공");
	}
	
//검색버튼
	$("#btnSearch").click(function() {
		var searchType = $("select[name=searchType]").val(); //검색 조건
		var keyword = $("#keyword").val();//검색할 키워드
		$("#frmPage > input[name=searchType]").val(searchType);
		$("#frmPage > input[name=keyword]").val(keyword);
		$("#frmPage").submit();
	});
	
//글 더보기
	$(window).scroll(function(){//스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	     if($(window).scrollTop() >= $(document).height() - $(window).height()){
	    	//다음 글 3개 가져오기
			var startRow = $(".boardList").length + 1;
			var endRow = startRow +2;
			var searchType = $("#searchType").val();
			var keyword = $("#keyword").val();
			var url = "/board/moreList";
			var sendData = {
				"startRow" : startRow,
				"endRow" : endRow,
				"searchType" : searchType,
				"keyword" : keyword
			};

			var html ="";
			
			$.ajax({
				"type" : "post",  
				"url" : url,
				"dataType" : "text",
				"data" : JSON.stringify(sendData),
				"headers" : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "post"
				},
				success : function(rdata) {
		        	$.each($.parseJSON(rdata), function (index, boardVo) {
			        	html += "<div id='board' class='boardList'>";
			        	html += "<div class='row' id='title'>";
			        	html += "<div class='col-md-6'>";
			        	html += "<h4 class='text-left'>" + boardVo.title+"</h4>";
			        	html += "</div>";
			        	html += "<div class='col-md-6' align='right'>"+boardVo.writer+" | "+boardVo.regdate+" | 글번호"+boardVo.bno+"</div>";
			        	html +="</div>";
			        	html +="<div id='content'>";
			        	html +="<pre>"+boardVo.content+"</pre>";
			        	html +="</div>";
			        	html +="<div class='boardImg'>";
			        	if(boardVo.files != null){
							for(var v= 0 ; v <= boardVo.files.length ; v++){
								if(boardVo.files[v] != null){
						        	html +="<img src='/upload/displayFile?fileName="+boardVo.files[v]+"' alt='사진 미등록' class='oriImg'/>";
								}
							}
			        	}
			        	html +="</div>";
			        	if(user_id == boardVo.writer){
				        	html +="<a href='/board/updateArticle?bno="+boardVo.bno+"' class='btn btn-warning btn-sm'>수정</a>";
				        	html +="<button type='button' class='btn btn-danger btn-sm btnDelete' data-bno='"+boardVo.bno+"'>삭제</button>";
			        	}
			        	html +="</div>";
					});
 		        	$(".boardList").last().after(html);
				},
				error : function(data) {
					console.log("ajax 처리 실패");
				}
			});//ajax
	     };//스크롤 if문
	});
//글 더보기 끝

//글 삭제
	$("#boardList").on("click", ".btnDelete", function () {
		var that = $(this);
		var bno = that.attr("data-bno");
		console.log(bno);
		var url = "/board/deleteArticle/"+bno;
		$.ajax({
			"type" : "delete",
			"url" : url,
			"dataType" : "text",
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "delete"
			},
			"success" : function (rData) {
				that.parent().hide(1000);
			}
		});//ajax
	});
//글 삭제 끝
});

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
var $element = matchMedia("screen and (min-width: 786px)").matches ? document.getElementById("scrollTopBtn") : document.getElementById("scrollTopBtnMob");
$element.style.display = (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) ? 'block' : 'none';
}

function topFunction() {
    $('html,body').animate({ scrollTop: 0 }, 500);
}
</script>
<%@ include file="../include/frmPage.jsp" %>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6" id="boardList">
			<!-- 검색 -->
			<select name="searchType" id="searchType" class="form-inline">
				<option value="t"
					<c:if test="${pagingDto.searchType == 't'}">selected</c:if>
				>제목</option>
				<option value="c"
					<c:if test="${pagingDto.searchType == 'c'}">selected</c:if>
				>내용</option>
				<option value="w"
					<c:if test="${pagingDto.searchType == 'w'}">selected</c:if>
				>작성자</option>
				<option value="tc"
					<c:if test="${pagingDto.searchType == 'tc'}">selected</c:if>
				>제목+내용</option>
				<option value="tcw"
					<c:if test="${pagingDto.searchType == 'tcw'}">selected</c:if>
				>제목+내용+작성자</option>
			</select>
			<input type="text" id="keyword" name="keyword" class="form-inline"
				value="${pagingDto.keyword}"/>
			<button type="button" id="btnSearch" class="btn btn-info btn-sm">검색</button>
			<a href="/board/register" class="btn btn-success btn-sm" style="float: right;">글쓰기</a>
			<c:forEach items="${list}" var="boardVo">
				<div id="board" class="boardList">
					<div class="row" id="title">
						<div class="col-md-6">
							<h4 class="text-left">${boardVo.title}</h4>
						</div>
						<div class="col-md-6" align="right">
							${boardVo.writer} | ${boardVo.regdate} | 글번호 ${boardVo.bno}
						</div>
					</div>
					<div id="content">
							<pre>${boardVo.content}</pre>
					</div>
					<div class="boardImg">
						<c:forEach items="${attachList}" var="attachVo">
							<c:if test="${attachVo.bno == boardVo.bno}">
								<img src="/upload/displayFile?fileName=${attachVo.file_name}" alt="사진 미등록" class="oriImg"/>
							</c:if>
						</c:forEach>
					</div>
					<c:if test="${sessionScope.user_id == boardVo.writer}">
						<a href="/board/updateArticle?bno=${boardVo.bno}" class="btn btn-warning btn-sm">수정</a>
						<button type="button" class="btn btn-danger btn-sm btnDelete" data-bno="${boardVo.bno}">삭제</button>
					</c:if>
				</div>
			</c:forEach>
			<button type="button" onclick="topFunction()" id="scrollTopBtn">PC Top 버튼</button>
		</div>
		<div class="col-md-3"></div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>
