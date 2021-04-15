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
	String macAddress = request.getParameter("macAddress");
	String ssid = request.getParameter("ssid");
	String today = request.getParameter("date");
	String timeIN = request.getParameter("timeIN");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
%>

<%=macAddress%>
<%=ssid%>
<%=today%>
<%=timeIN%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		sql = "UPDATE test SET date = ?, timeIN = ? WHERE macAddress = ? AND position = 'W' AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, today); 
		pstmt.setString(2, timeIN); 
		pstmt.setString(3, macAddress); 										
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

