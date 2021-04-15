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

	// get msg Info to add
	String sender = request.getParameter("sender");
	String message = request.getParameter("message");
	String receiver = request.getParameter("receiver");	
		
	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String msgID = "";
	String sql = "";
	String rst = "success";	 
	String msg = "";	
	String count = "";
	int index = 0;
%>
<%=sender%>
<%=message%>
<%=receiver%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    
    <%
		// Find max num then increment by 1 to avoid duplicate when user delete post
		sql = "SELECT MAX(CAST(msgID AS int)) AS cnt FROM datingMsgInfo WHERE del is null";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if (rs.next()){
			msgID = rs.getString("cnt");
			index = Integer.parseInt(msgID)+1;
			msgID = Integer.toString(index);
			sql = "INSERT INTO datingMsgInfo(msgID, sender, date, message, receiver) VALUES(?, ?, SYSDATETIME(), ?, ?)";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, msgID);
			pstmt.setString(2, sender); 	
			pstmt.setString(3, message);	
			pstmt.setString(4, receiver);	
			pstmt.executeUpdate();
		}
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

