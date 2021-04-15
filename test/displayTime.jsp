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
	String ssid = request.getParameter("ssid");
	
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
		// it should be order by asc but somehow json order is opposite 
		sql = "SELECT * FROM userInfo WHERE position = 'W' AND del is null ORDER BY CAST(uID AS int) DESC";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()){
			JSONObject jObject = new JSONObject(); 	// save json contents
			jObject.put("name", rs.getString("name"));
			jObject.put("macAddress", rs.getString("macAddress"));
			jObject.put("date", rs.getString("date"));
			jObject.put("timeIN", rs.getString("timeIN"));
			jObject.put("timeOUT", rs.getString("timeOUT"));
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

