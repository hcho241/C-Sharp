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
	
	// JSON
	JSONObject jMain = new JSONObject(); // json main object
	JSONArray jArray = new JSONArray(); 	// json array 
%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		sql = "SELECT * FROM datingUserInfo WHERE ID = ? AND PW = ? AND del is null";
		pstmt = conn.prepareStatement(sql);	
		pstmt.setString(1, ID); 				// first param = ID
		pstmt.setString(2, PW);					// second param = PW
		rs = pstmt.executeQuery();

		// if user exists
		if (rs.next()) {		
			JSONObject jObject = new JSONObject(); 	// save json contents

			jObject.put("ID", rs.getString("ID"));
			jObject.put("PW", rs.getString("PW"));
			jObject.put("sex", rs.getString("sex"));
			jObject.put("age", rs.getString("age"));
			jObject.put("ageRange", rs.getString("ageRange"));
			jObject.put("prefAge", rs.getString("prefAge"));
			jObject.put("prefAgeRange", rs.getString("prefAgeRange"));
			jObject.put("latitude", rs.getString("latitude"));
			jObject.put("longitude", rs.getString("longitude"));
			jObject.put("distance", rs.getString("distance"));
			jObject.put("drink", rs.getString("drink"));
			jObject.put("smoke", rs.getString("smoke"));
			jObject.put("religion", rs.getString("religion"));
			jObject.put("hobby", rs.getString("hobby"));
			jObject.put("priority", rs.getString("priority"));
			jArray.add(0, jObject);
			jMain.put("Data Sent", jArray);
			
			out.println(jMain);    
		} 
		else {
			JSONObject jObject = new JSONObject(); 	// save json contents
			
			jObject.put("ID", "NOT EXIST");
			jObject.put("PW", "NOT EXIST");
			jObject.put("sex", "NOT EXIST");
			jObject.put("age", "NOT EXIST");
			jObject.put("ageRange", "NOT EXIST");
			jObject.put("prefAge", "NOT EXIST");
			jObject.put("prefAgeRange", "NOT EXIST");
			jObject.put("latitude", "NOT EXIST");
			jObject.put("longitude", "NOT EXIST");
			jObject.put("distance", "NOT EXIST");
			jObject.put("drink", "NOT EXIST");
			jObject.put("smoke", "NOT EXIST");
			jObject.put("religion", "NOT EXIST");
			jObject.put("hobby", "NOT EXIST");
			jObject.put("priority", "NOT EXIST");
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

