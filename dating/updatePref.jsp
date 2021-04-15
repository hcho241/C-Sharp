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
	String ID = request.getParameter("ID");
	String prefAge = request.getParameter("prefAge");
	String prefAgeRange = request.getParameter("prefAgeRange");
	String distance = request.getParameter("distance");
	String drink = request.getParameter("drink");
	String smoke = request.getParameter("smoke");
	String religion = request.getParameter("religion");
	String hobby = request.getParameter("hobby");
	String priority = request.getParameter("priority");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
%>

<%=ID%>
<%=prefAge%>
<%=prefAgeRange%>
<%=distance%>
<%=drink%>
<%=smoke%>
<%=religion%>
<%=hobby%>
<%=priority%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		// First, check whether duplicate ID/PW exists 
		sql = "UPDATE datingUserInfo SET prefAge = ?, prefAgeRange = ?, distance = ?, drink = ?, smoke = ?, religion = ?, hobby = ?, priority = ? WHERE ID = ? AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, prefAge);
		pstmt.setString(2, prefAgeRange);
		pstmt.setString(3, distance);
		pstmt.setString(4, drink);
		pstmt.setString(5, smoke);
		pstmt.setString(6, religion);
		pstmt.setString(7, hobby);
		pstmt.setString(8, priority);
		pstmt.setString(9, ID);
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

