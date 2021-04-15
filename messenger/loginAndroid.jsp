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
	String PW = request.getParameter("PW");
		
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
		sql = "SELECT * FROM userInfo WHERE ID = ? and PW = ? and del is null";
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, ID); 				// first param = ID
		pstmt.setString(2, PW);					// second param = PW
		rs = pstmt.executeQuery();
		
		JSONObject jMain = new JSONObject(); // json main object
		JSONArray jArray = new JSONArray(); 	// json array 
		// if user exists
		if (rs.next()) {
			JSONObject jObject = new JSONObject(); 	// save json contents

			jObject.put("ID", rs.getString("ID"));
			jObject.put("PW", rs.getString("PW"));
			
			jArray.add(0, jObject);
			jMain.put("Data Sent", jArray);
			
			out.println(jMain);    
		} 
		else {
			JSONObject jObject = new JSONObject(); 	// save json contents
			
			jObject.put("ID", "NO SUCH ID");
			jObject.put("PW", "NO SUCH PW");
			
			jArray.add(0, jObject);
			jMain.put("Data Sent", jArray);
			
			out.println(jMain);
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

