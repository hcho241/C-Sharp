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
	String current_timeIN = request.getParameter("timeIN");
	String current_timeOUT = request.getParameter("timeOUT");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	
	// calculation for total work hr
    Integer hr_in = 0;
	Integer min_in = 0;
	Integer sec_in = 0;
	Integer totalIN = 0;
    String hr_in_Str = ""; 
	String min_in_Str = "";
	String sec_in_Str = "";
    Integer hr_out = 0;
	Integer min_out = 0;
	Integer sec_out = 0;
	Integer totalOUT = 0;
    String hr_out_Str = "";
	String min_out_Str = "";
	String sec_out_Str = "";
    Integer totalHr_inSec = 0;
	Integer totalHr_inMin = 0; 
    String totalHr = "";
	String totalMin = "";
	String totalSec = "";
    String totalWorkHr = "";
%>

<%=macAddress%>
<%=current_timeIN%>
<%=current_timeOUT%>

<%
	// calculation for total work hr 
	hr_in_Str = current_timeIN.substring(0, 2);
	min_in_Str = current_timeIN.substring(3, 5);
	sec_in_Str = current_timeIN.substring(6);
	sec_in = Integer.valueOf(sec_in_Str);
	min_in = Integer.valueOf(min_in_Str) * 60;
	hr_in = Integer.valueOf(hr_in_Str) * 3600;
	totalIN = hr_in + min_in + sec_in;
	hr_out_Str = current_timeOUT.substring(0, 2);
	min_out_Str = current_timeOUT.substring(3, 5);
	sec_out_Str = current_timeOUT.substring(6);
	sec_out = Integer.valueOf(sec_out_Str);
	min_out = Integer.valueOf(min_out_Str) * 60;
	hr_out = Integer.valueOf(hr_out_Str) * 3600;
	totalOUT = hr_out + min_out + sec_out;
	totalHr_inSec = totalOUT - totalIN;
	// now convert total hour in sec to hour
	totalSec = String.valueOf(totalHr_inSec % 60);
	totalHr_inMin = totalHr_inSec / 60;
	totalMin = String.valueOf(totalHr_inMin % 60);
	totalHr = String.valueOf(totalHr_inMin / 60);
	totalWorkHr = totalHr + ":" + totalMin + ":" + totalSec;
%>

<%=totalWorkHr%>

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
		sql = "UPDATE userInfo SET totalWorkHr = ? WHERE macAddress = ? AND position = 'W' AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, totalWorkHr); 
		pstmt.setString(2, macAddress);										
		pstmt.executeUpdate();
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

