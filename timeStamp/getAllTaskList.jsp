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
		// for some reason, DESC shows adapterlist as ASC order 
		sql = "SELECT * FROM taskList WHERE macAddress = ? AND del is null ORDER BY tID DESC";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, macAddress); 
		rs = pstmt.executeQuery();
		while (rs.next()){
			JSONObject jObject = new JSONObject(); 	// save json contents
			jObject.put("date", rs.getString("date"));
			jObject.put("task", rs.getString("task"));
			jObject.put("done", rs.getString("done"));
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

