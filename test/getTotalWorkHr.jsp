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
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	
	// JSON variables 
	JSONObject jMain = new JSONObject(); 	// json main object
	JSONArray jArray = new JSONArray(); 	// json array 
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		sql = "SELECT * FROM test WHERE macAddress = ? AND position = 'W' AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, macAddress); 
		rs = pstmt.executeQuery();
		while (rs.next()){
			JSONObject jObject = new JSONObject(); 	// save json contents
			jObject.put("totalWorkHr", rs.getString("totalWorkHr"));
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

