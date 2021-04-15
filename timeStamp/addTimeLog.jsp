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
	String timeIN = request.getParameter("timeIN");
	String timeOUT = request.getParameter("timeOUT");
	String totalWorkHr = request.getParameter("totalWorkHr");
	
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
<%=timeIN%>
<%=timeOUT%>
<%=totalWorkHr%>

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
		sql = "INSERT INTO timeLog VALUES(null, ?, ?, ?, ?, ?, ?, null)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name); 
		pstmt.setString(2, macAddress); 
		pstmt.setString(3, today); 
		pstmt.setString(4, timeIN); 
		pstmt.setString(5, timeOUT); 
		pstmt.setString(6, totalWorkHr); 		
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

