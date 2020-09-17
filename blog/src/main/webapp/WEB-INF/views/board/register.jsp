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
		});//ajax
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
			// x 버튼누른 div 제거
		});
	});
	
	$("#registerForm").submit(function() {
		var upDiv = $("#uploadedList > div");
		upDiv.each(function(index) {
			var filename = $(this).attr("data-filename");
			console.log("filename:" + filename);
			var hiddenInput = "<input type='hidden' name='files["+index+"]' value='"+filename+"'/>";
			$("#registerForm").prepend(hiddenInput);
		});
	});
});
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<form id="registerForm" role="form" action="/board/register" method="post">
				<div class="form-group">
					<label for="title">제목</label>
					<input type="text" class="form-control" id="title" name="title" required/>
				</div>
				<div class="form-group">
					<label for="content">내용</label>
					<textarea id="content" name="content" class="form-control" rows="10"></textarea>
				</div>
				<div>
					<label>첨부할 파일을 드래그 &amp; 드롭 하세요</label>
					<div id="fileDrop"></div>
				</div>
				<div id="uploadedList"></div>
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