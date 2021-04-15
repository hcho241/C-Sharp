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
	String sex = request.getParameter("sex");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	JSONObject jMain = new JSONObject(); // json main object
	JSONArray jArray = new JSONArray(); 	// json array 
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    
    <%
		sql = "SELECT * FROM datingUserInfo WHERE ID != ? AND sex != ? AND del is null";
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, ID); 				// 1st param = ID
		pstmt.setString(2, sex); 				// 2nd param = sex
		rs = pstmt.executeQuery();

		// show all info of other users 
		while (rs.next()) {
			// get latitude, longitude of address and write it on json 
			JSONObject jObject = new JSONObject(); 	// save json contents
			
			jObject.put("ID", rs.getString("ID"));
			jObject.put("sex", rs.getString("sex"));	// just to check 
			jObject.put("age", rs.getString("age"));
			jObject.put("ageRange", rs.getString("ageRange"));
			jObject.put("latitude", rs.getString("latitude"));
			jObject.put("longitude", rs.getString("longitude"));
			jObject.put("drink", rs.getString("drink"));
			jObject.put("smoke", rs.getString("smoke"));
			jObject.put("religion", rs.getString("religion"));
			jObject.put("hobby", rs.getString("hobby"));
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

