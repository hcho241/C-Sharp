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
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	
	// JSON
	JSONObject jMain = new JSONObject(); 	// json main object
	JSONArray jArray = new JSONArray(); 	// json array 
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		// First, check whether duplicate ID/PW exists 
		sql = "SELECT * FROM datingNotice WHERE del is null";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()){
			JSONObject jObject = new JSONObject(); 	// save json contents
			jObject.put("title", rs.getString("title"));
			jObject.put("date", rs.getString("date"));
			jObject.put("writer", rs.getString("writer"));	
			jObject.put("contents", rs.getString("contents"));
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

