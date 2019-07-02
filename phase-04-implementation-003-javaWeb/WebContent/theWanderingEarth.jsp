<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<style>
.background1 {
	background-image: url(/static/imgs/pic008.jpg);
	background-color: #000000;
}
</style>
<%
	String [] peom= new String [4];
	String name="";
	String peomname="";
%>
<script>
	function run(clickedObj) {
		$("#firstline").fadeOut('slow');
		$('#intr')[0].pause();
		$('#poem')[0].play();
		$('#poem-txt').fadeIn('slow');
		$(clickedObj).animate({
			width : '10px',
			opacity : '0.2',
			left : '1800px',
			top : '100px'
		}, 12000);
		$('#poem-txt').animate({
			
			left : '500px',
			top : '800px'
		}, 12000);
		$('#poem-txt').fadeOut('slow');
		
		$("#moviebox").show('slow');
		$("#movie")[0].play();
	}
	function onVideoEnd(){
		
		$("#moviebox").fadeOut('slow');
		
		$('#poem-txt').animate({
			bottom : '100px',
			right : '100px'
		}, 18000);
		
		$('#waiting')[0].play();
	}
</script>
<meta charset="UTF-8">
<title>The Wandering Earth</title>
<script src="/static/jquery.min.js"></script>
</head>
<body class="background1">
	<%
	try {
		 String sqlServerUrl = "jdbc:sqlserver://localhost:1433;DatabaseName=TheWanderingEarth;";
		 String sqlServerUser = "sa";
		 String sqlServerPass = "123456";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = DriverManager.getConnection(sqlServerUrl, sqlServerUser, sqlServerPass);
        Statement s =  con.createStatement();
        ResultSet res = s.executeQuery("select * from poemName");
        while(res.next()){
        	peomname=res.getString("poemName");
            name=res.getString("poemer");
            peom[0]=res.getString("poem1");
            peom[1]=res.getString("poem2");
            peom[2]=res.getString("poem3");
            peom[3]=res.getString("poem4");
            
        }
        
        res.close();
        s.close();
        con.close();

	} catch (Exception e) {
        e.printStackTrace();
	}
	%>
	<audio id="intr" controls="controls"
		src="/static/audio/introduction.mp3" autoplay="autoplay"></audio>
	<audio id="poem" src="/static/audio/wanderingEarch-poem.mp3"
		preload="auto"></audio>
	<span id="firstline" style="font-size: 26px; color: white">大家好，我准备设计和实现一个“<span
		style="font-size: 38px; color: red">流浪地球</span>”的漂亮网页！ 欢迎大家观赏,谢谢！
	</span>
	<audio id="waiting" src="/static/audio/waiting.mp3" preload="auto"></audio>
	<div id="poem-txt"
		style="display: none; position: absolute; font-size: 22px; color: orange; position:absolute; left :10px;top:50px" >
		<%=peomname%> <br /> <span style="font-size: 18px; color: grey">
			<%=name %> </span><br /> <br /> <%=peom[0]%><%=peom[1]%><br /> <%=peom[2]%><%=peom[3]%>
	</div>
	<img src="/static/imgs/earth.png"
		style="position: absolute; left: 10px; bottom: 10px; width: 200px"
		onclick="run(this);return false" />
	<div id="moviebox" style="margin-top: 100px; display: none"
		align="center">
		<video id="movie" height="500px" controls="controls"
			src="https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo-transcode/61990981_fd6360c7b3d2674e0b0937c34a4c1b1b_0.mp4" onended="onVideoEnd();" />
	</div>
</body>
</html>