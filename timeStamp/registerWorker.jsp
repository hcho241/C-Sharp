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
	String ssid = request.getParameter("ssid");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	String uID = "";
	Integer index = 0;
%>

<%=name%>
<%=macAddress%>
<%=ssid%>

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
		// First, find max num then increment by 1 to avoid duplicate when user delete post
		sql = "SELECT MAX(CAST(uID AS int)) AS cnt FROM userInfo WHERE del is null";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if (rs.next()){
			uID = rs.getString("cnt");
			index = Integer.parseInt(uID)+1;
			uID = Integer.toString(index);

			sql = "INSERT INTO userInfo(uID, name, macAddress, position, ssid) VALUES(?, ?, ?, 'W', ?)";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, uID); 				
			pstmt.setString(2, name);					
			pstmt.setString(3, macAddress); 				
			pstmt.setString(4, ssid); 							
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

