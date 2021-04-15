<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.*"%>
<%
	// support Korean
	request.setCharacterEncoding("euc-kr");
	
	// get manager's current mac address 
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
		sql = "SELECT * FROM userInfo WHERE macAddress = ? AND position = 'M' AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, macAddress); 
		rs = pstmt.executeQuery();
		while (rs.next()){
			JSONObject jObject = new JSONObject(); 	// save json contents
			jObject.put("name", rs.getString("name"));
			jObject.put("macAddress", rs.getString("macAddress"));
			jObject.put("ssid", rs.getString("ssid"));
			jArray.add(0, jObject);	
		}
		jMain.put("Data Sent", jArray);
		out.println(jMain);  
	} catch(SQLException e) {
		rst = "System Error";
		msg = e.getMessage();
		out.println(e.toString());
	} finally {
		if(rs != null) 
			rs.close();
		if(pstmt != null) 
			pstmt.close();
		if(conn != null) 
			conn.close();
	}
%>

