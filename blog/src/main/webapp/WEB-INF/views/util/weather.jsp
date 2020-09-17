<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<style>
	.table{
		background-color: white;
		margin-bottom: 10px;
		padding: 10px;
		border-radius: 8px;
		text-align: center;
	}
	.chart-div {
		width:  700px;
		height: 500px;
		text-align: center;
	}
</style>
<script>
$(function () {
	var cityName = ["서울","인천","안양","수원","울산","부산","대구","대전","광주","광양","군산","인제","제주도"];
	var cityNum = ["1835848","1843561","1846898","1835553","1833747","1838519","1835327","1835235","1841603","1841775","1842025","1843542","1846265"];
	
	$("#city").change(function () {
		var city = $(this).val();
		for (var v = 0; v < cityName.length; v++) {
			if(city == cityNum[v]){
				$("#loc").text(cityName[v]);
			}
		}
		//현제 날씨
		$.getJSON("http://api.openweathermap.org/data/2.5/weather?id="+city+"&APPID=ad7025c08fb0f2893250fbdfdc17baf1&units=metric",function(data){
			var temp = data.main.temp;
			var feels_like = data.main.feels_like;
			var date = data.name;
			var icon = "http://openweathermap.org/img/w/"+data.weather[0].icon+".png";
			if($(".ctemp").append() )
			
			$("#temp").text(temp);
			$("#feels_like").text(feels_like);
			$("#icon").attr("src",icon);
		});
		
		var html = "";
		//오늘의 날씨 - 3시간 간격
		$.getJSON("http://api.openweathermap.org/data/2.5/forecast?id="+city+"&APPID=ad7025c08fb0f2893250fbdfdc17baf1&units=metric",function(data){
			$(".tWeather").remove();
			
			html += "<thead class='tWeather'>";
			html += "<tr>";
			html += "<th>시간</th>";
			html += "<th>온도</th>";
			html += "<th>체감온도</th>";
			html += "<th>풍속</th>";
			html += "<th>#</th>";
			html += "</tr>";
			html += "<tbody class='tWeather'>";
			
			//오늘의 날짜
			var date = new Date(); 
			var year = date.getFullYear(); 
			var month = new String(date.getMonth()+1); 
			var day = new String(date.getDate()); 
			// 월/일이 한자리면 0을 채워준다. 
			if(month.length == 1){ 
			  month = "0" + month; 
			} 
			if(day.length == 1){ 
			  day = "0" + day; 
			} 
			var toDay = year + "-" + month + "-" + day;
			
			console.log(data);
			var tempArr = [];
			$.each(data.list,function(index, item){
				var itemDate = item.dt_txt.substring(0,10);//가져온 데이터에서 날짜만 추출
				if(toDay == itemDate){
					var icon = "http://openweathermap.org/img/w/"+item.weather[0].icon+".png";
					html += "<tr>";
					html += "<td>"+item.dt_txt+"</td>";
					html += "<td>"+item.main.temp+"</td>";
					html += "<td>"+item.main.feels_like+"</td>";
					html += "<td>"+item.wind.speed+"m/s</td>";
					html += "<td><img id='icon' src='"+icon+"'></td>";
					html += "</tr>";
					tempArr.push(item.main.temp);
				}
			});
			html += "</tbody>";
			html += "</thead>";
			$(".table").append(html);
				console.log(tempArr);
				
				//차트
				var myChart = $("#lineChart");
				var myLineChart = new Chart(myChart, {
					type : "line",
					data : {
						labels : ["09시","12시","15시","18시","21시"],
						datasets : [{
								label : "오늘의 날씨",
								data : tempArr,
								fill : false,
								backgroundColor : "rgb(60,141,188)",
								borderColor : "rgba(60,141,188,0.7)"
						}],
						options : {
							//부모 태그 크기에 맞게 설정
							maintainAspectRatio : false
						}
					}
				});//차트 끝
		});
	});//도시선택
	

	
});
</script>
<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<h1>weather api</h1>
			<select id="city">
				<option>선택</option>
				<option value="1835848">서울</option>
				<option value="1843561">인천</option>
				<option value="1846898">안양</option>
				<option value="1835553">수원</option>
				<option value="1833747">울산</option>
				<option value="1838519">부산</option>
				<option value="1835327">대구</option>
				<option value="1835235">대전</option>
				<option value="1841603">광주</option>
				<option value="1841775">광양</option>
				<option value="1842025">군산</option>
				<option value="1843542">인제</option>
				<option value="1846265">제주도</option>
			</select>
			<h4> <span id="loc"></span> 현재 날씨</h4>
			<div class="ctemp">현재 온도: <span id="temp"></span> </div>
			<div class="feels_like">체감 온도: <span id="feels_like"></span></div>
			<img id="icon" src="">
			<br>
			<div class="chart-div">
				<canvas id="lineChart"></canvas>
			</div>
			
			
			<div class="row">
				<div class="col-md-12">
					<table class="table">
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-2">
		</div>
	</div>
<%@ include file="../include/footer.jsp" %>