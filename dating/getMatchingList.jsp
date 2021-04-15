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
	String currentUser = request.getParameter("ID");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg   = "";
	
	// JSON
	JSONObject jMain = new JSONObject(); 	// json main object
	JSONArray jArray = new JSONArray(); 	// json array 
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		// it supposed to be desc total & asc ageDiff / distance, but it shows opposite order in json file
		sql = "SELECT * FROM datingMatching WHERE currentUser = ? AND del is null ORDER BY CAST(total AS int) ASC";
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, currentUser); 				
		rs = pstmt.executeQuery();
		while (rs.next()) {
			JSONObject jObject = new JSONObject(); 	// save json contents
			jObject.put("matchingUser", rs.getString("matchingUser"));
			jObject.put("matchingAge", rs.getString("matchingAge"));
			jObject.put("matchingDistance", rs.getString("matchingDistance"));	
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

