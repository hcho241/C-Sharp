<%@ page contentType="application/json; charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.*"%>

<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>

<%
	// support Korean
	request.setCharacterEncoding("euc-kr");

	// get user info
	String name = request.getParameter("name");
	String macAddress = request.getParameter("macAddress");
	String today = request.getParameter("date");
	String task = request.getParameter("task");
	
	// variables 
	Integer index = 0;
	String newTask = "";
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	
%>

<%=name%>
<%=macAddress%>
<%=today%>
<%=task%>

<!-- ex) change dating_app to dating app -->
<%
	index = task.indexOf("_");
	if (index > 0){
		newTask = task.substring(0, index) + " " + task.substring(index+1);
	}
	else {
		newTask = task;
	}
%>

<%=newTask%>

<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch(ClassNotFoundException e) {
		out.println(e.toString());
	}
%>

<%
	try {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/timeStamp", "hcho241", "*Hgi}E9PgPjc");
	} catch(SQLException e) {
		out.println(e.toString());
	}
%>

<%
	try {
		sql = "INSERT INTO taskList VALUES(null, ?, ?, ?, ?, 'N', null)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name); 
		pstmt.setString(2, macAddress); 
		pstmt.setString(3, today); 
		pstmt.setString(4, newTask); 
		pstmt.executeUpdate();
	} catch(SQLException e) {
		rst = "System Error";
		msg = e.getMessage();
	} finally {
		if(rs != null) 
			rs.close();
		if(pstmt != null) 
			pstmt.close();
		if(conn != null) 
			conn.close();
	}
%>

