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
	String ID = request.getParameter("receiver");
		
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg   = "";
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    
    <%
		sql = "SELECT * FROM datingMsgInfo WHERE receiver = ? AND del is null ORDER BY CAST(msgID AS int) ASC"; 
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, ID); 				// first param = ID
		rs = pstmt.executeQuery();
		
		JSONObject jMain = new JSONObject(); // json main object
		JSONArray jArray = new JSONArray(); 	// json array 
		// if user exists
		while (rs.next()) {
			JSONObject jObject = new JSONObject(); 	// save json contents
		
			jObject.put("msgID", rs.getString("msgID"));
			jObject.put("sender", rs.getString("sender"));
			jObject.put("date", rs.getString("date"));
			jObject.put("message", rs.getString("message"));	
			
			jArray.add(0, jObject);
		} 
		jMain.put("Data Sent", jArray);
		out.println(jMain);  
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

