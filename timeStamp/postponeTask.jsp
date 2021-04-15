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
	String today = request.getParameter("date");
	String task = request.getParameter("task");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	
	// date variables
	Integer yearInt = 0;
	Integer monthInt = 0;
	Integer dayInt = 0;
	String yearStr = "";
	String monthStr = "";
	String dayStr = "";
	String newDate = "";
	
	// for new task name
	Integer index = 0;
	String newTask = "";
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
%>

<%=macAddress%>
<%=today%>
<%=task%>
<%=year%>
<%=month%>
<%=day%>

<!-- ex) change dating_app to dating app -->
<%
	index = task.indexOf("_");
	if (index > 0){
		newTask = task.substring(0, index) + " " + task.substring(index+1);
	}
	else {
		newTask = task;
	}
%>

<%=newTask%>

<!-- postpone the date -->
<%
	// month = 1, 3, 5, 7, 8, 10, 12 day = 31
	// month = 2 day = 28
	// month = 4, 6, 9, 11 day = 30
	// change year, month, day to int
	yearInt = Integer.parseInt(year);
	monthInt = Integer.parseInt(month);
	dayInt = Integer.parseInt(day);
	if (month.equals("1") || month.equals("3") || month.equals("5") || month.equals("7") || month.equals("8") || month.equals("10") || month.equals("12")){
		if (dayInt == 31 && month.equals("12")) {	// new year 
			dayInt = 1;
			dayStr = Integer.toString(dayInt);
			monthInt = 1;
			monthStr = Integer.toString(yearInt);
			yearInt += 1;
			yearStr = Integer.toString(yearInt);
		}
		else if (dayInt == 31 && !month.equals("12")){	// new month 
			dayInt = 1;
			dayStr = Integer.toString(dayInt);
			monthInt += 1;
			monthStr = Integer.toString(monthInt);
			yearStr = year;
		}
		else if (dayInt < 31){
			if (dayInt > 0 && dayInt < 10){
				dayInt += 1;
				dayStr = "0" + Integer.toString(dayInt);
			}
			else {
				dayInt += 1;
				dayStr = Integer.toString(dayInt);
			}
			monthStr = month;
			yearStr = year;
		}
	}
	else if (month.equals("2")){
		if (dayInt < 28) {
			if (dayInt > 0 && dayInt < 10){
				dayInt += 1;
				dayStr = "0" + Integer.toString(dayInt);
			}
			else {
				dayInt += 1;
				dayStr = Integer.toString(dayInt);
			}
			monthStr = month;
			yearStr = year;
		}
		else if (dayInt == 28){	// new month 
			dayInt = 1;
			dayStr = Integer.toString(dayInt);
			monthInt += 1;
			monthStr = Integer.toString(monthInt);
			yearStr = year;
		}
		// 2-29 each 4 years --> leap year 
		else if (dayInt == 28 && (yearInt % 4 == 0 && yearInt % 100 == 0 && yearInt % 400 == 0)){
			dayInt += 1;
			dayStr = Integer.toString(dayInt);
			monthStr = month;
			yearStr = year;
		}
		else if (dayInt == 29){ // new year 
			dayInt = 1;
			dayStr = Integer.toString(dayInt);
			monthStr += 1;
			monthStr = Integer.toString(monthInt);
			yearStr = year;
		}
	}
	else {	// month == 4, 6, 9, 11
		if (dayInt < 30) {
			if (dayInt > 0 && dayInt < 10){
				dayInt += 1;
				dayStr = "0" + Integer.toString(dayInt);
			}
			else {
				dayInt += 1;
				dayStr = Integer.toString(dayInt);
			}
			monthStr = month;
			yearStr = year;
		}
		else if (dayInt == 30){	// new month 
			dayInt = 1;
			dayStr = Integer.toString(dayInt);
			monthInt += 1;
			monthStr = Integer.toString(monthInt);
			yearStr = year;
		}
	}
	newDate = yearStr + "-" + monthStr + "-" + dayStr;
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
		sql = "UPDATE taskList SET date = ? WHERE macAddress = ? AND task = ? AND del is null";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, newDate); 
		pstmt.setString(2, macAddress); 
		pstmt.setString(3, newTask); 
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

