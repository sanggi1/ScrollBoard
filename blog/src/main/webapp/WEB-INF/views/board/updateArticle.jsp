<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>
<script src="/resources/js/myscript.js"></script>
<style>
#fileDrop {
	width : 80%;
	height : 100px;
	background-color: yellow;
	margin : 20px auto;
	border : 1px dashed blue;
}

#uploadedList > div {
	float : left;
	margin : 20px;
}
#attachList > div {
	float : left;
	margin : 20px;
}

#btnDiv {
	clear : both;
}

</style>
<script>
$(function() {
	$("#fileDrop").on("dragenter dragover", function(e) {
		e.preventDefault();
	});
	
	$("#fileDrop").on("drop", function(e) {
		e.preventDefault();
		var file = e.originalEvent.dataTransfer.files[0];
		console.log(file);
		var formData = new FormData(); // <form>
		formData.append("file", file); // <input type="file"> : 파일 선택
		var url = "/upload/uploadAjax";
		// "processData" : false -> data를 쿼리스트링으로 보내지 않음
		// "contentType" : false -> text아닌 binary 명시
		// -> enctype="multipart/form-data"
		$.ajax({
			"processData" : false,
			"contentType" : false,
			"type" : "post",
			"url" : url,
			"data" : formData,
			"success" : function(rData) {
				console.log(rData); // thumbnail 이미지 경로를 출력 (D:/upload/ 를 제외)
				var slashIndex = rData.lastIndexOf("/");
				var front = rData.substring(0, slashIndex + 1);
				var rear = rData.substring(slashIndex + 1);
				var thumbnailName = front + "sm_" + rear;
				
				var originalFilename = rData.substring(rData.indexOf("_") + 1);
				
				var html = "<div data-filename='" + rData + "'>";
				var result = isImage(originalFilename);
				if (result == true) {
					html += "<img class='img-rounded' src='/upload/displayFile?fileName=" + thumbnailName + "'/><br/>";
				} else {
					html += "<img class='img-rounded' src='/resources/images/file_image.png'/><br/>";
				}
				html += "<span>"+originalFilename+"</span>";
				html += "<a href='"+rData+"' class='attach-del'><span class='pull-right'>x</span></a>";
				html += "</div>";
				$("#uploadedList").append(html);
			}
		});
	});
	
	// html 소스 보기 상태에서 로딩된 엘리먼트에 대해서 이벤트 처리
	$("#uploadedList").on("click", ".attach-del", function(e) {
		e.preventDefault();
		var that = $(this);
		console.log("클릭");
		var filename = that.attr("href");
		console.log(filename);
		var url = "/upload/deleteFile";
		var sendData = {
				"filename" : filename
		};
		$.get(url, sendData, function(rData) {
// 			console.log(rData);
			that.parent().remove();
			// -> x 버튼이 들어있는 div 제거
		});
	});
	
	$("#attachList").on("click", ".attach-del", function(e) {
		e.preventDefault();
		var that = $(this);
		that.parent().attr("style","visibility: hidden;");
	});
	
	
	$("#updateForm").submit(function(e) {
// 		e.preventDefault();
		var delDiv = $("#attachList > div");
			delDiv.each(function (index) {// 올렸던 사진의 수 만큼 반복
				var file_name = $(this).attr("data-filename");
				var visibility = $(this).attr("style");
				if(visibility == "visibility: hidden;"){ //지울 예정인 사진 지우기
					var fileUrl = "/upload/deleteFile";
					var deleteUrl = "/board/deleteImg";
					
					var sendData = {
							"filename" : file_name
					};
					//데이터 삭제
					$.ajax({
						"type" : "delete",
						"url" : deleteUrl,
						"dataType" : "text",
						"data" : file_name,
						"headers" : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "delete"
						},
						"success" : function(rData) {
						}
					});//ajax
					
					//파일 삭제
					$.get(fileUrl, sendData, function(rData) {
//				 			console.log(rData);
					});//get
				}
			});
		var upDiv = $("#uploadedList > div");
		upDiv.each(function(index) {
			var filename = $(this).attr("data-filename");
			console.log("filename:" + filename);
			var hiddenInput = "<input type='hidden' name='files["+index+"]' value='"+filename+"'/>";
			$("#updateForm").prepend(hiddenInput);
		});
	});
});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<form id="updateForm" role="form" action="/board/updateArticle" method="post">
			<input type="hidden" name="bno" value="${boardVo.bno}">
				<div class="form-group">
					 
					<label for="title">
						제목
					</label>
					<input type="text" class="form-control" id="title" name="title" value="${boardVo.title}" required/>
				</div>
				<div class="form-group">
					 
					<label for="content">
						내용
					</label>
					<textarea id="content" name="content" class="form-control" rows="10">${boardVo.content}</textarea>
				</div>
				
				<div>
					<label>첨부할 파일을 드래그 &amp; 드롭 하세요</label>
					<div id="fileDrop"></div>
				</div>
				<div id="uploadedList">
				</div>
				<div class="row">
					<div class="col-md-12">
						<div>
						<label>올렸던 사진</label>
						</div>
						<div id="attachList">
							<c:forEach items="${attachList}" var="attachVo">
								<div style="visibility: visible;" data-filename="${attachVo.file_name}">
									<img class="img-rounded" width="100" height="100" src="/upload/displayFile?fileName=${attachVo.file_name}"><br/>
									<span>${attachVo.file_name}</span>
									<a href="${attachVo.file_name}" class="attach-del"><span class='pull-right'>x</span></a>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div id="btnDiv">
					<button type="submit" class="btn btn-primary" style="margin-bottom: 10px;">
						작성완료
					</button>
				</div>
			</form>
		</div>
		<div class="col-md-2">
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>