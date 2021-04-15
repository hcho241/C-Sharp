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
	String religion = request.getParameter("religion");

	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		sql = "UPDATE datingUserInfo SET religion = ? WHERE ID = ? AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, religion);
		pstmt.setString(2, ID);
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

