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
	String sex = request.getParameter("sex");
	String age = request.getParameter("age");
	String ageRange = request.getParameter("ageRange");
	String prefAge = request.getParameter("prefAge");
	String prefAgeRange = request.getParameter("prefAgeRange");
	String distance = request.getParameter("distance");
	
	// Initialize variables
	Connection conn  = null;
	PreparedStatement pstmt = null;
	ResultSet rs    = null;
	String sql = "";
	String rst = "success";
	String msg = "";
	String uID = "";
	Integer index = 0;
%>

<%=ID%>
<%=PW%>
<%=sex%>
<%=age%>
<%=ageRange%>
<%=prefAge%>
<%=prefAgeRange%>
<%=distance%>

<%
	try {
%>
		<%@ include file="../include/dbOpen.inc" %>
    <%
		// First, check whether duplicate ID/PW exists 
		sql = "SELECT ID FROM datingUserInfo WHERE ID = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, ID);
		rs = pstmt.executeQuery();
		
		if (!rs.next()){	// if ID does not exist
			// First, find max num then increment by 1 to avoid duplicate when user delete post
			sql = "SELECT MAX(CAST(uID AS int)) AS cnt FROM datingUserInfo WHERE del is null";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()){
				uID = rs.getString("cnt");
				index = Integer.parseInt(uID)+1;
				uID = Integer.toString(index);

				sql = "INSERT INTO datingUserInfo(uID, ID, PW, sex, age, ageRange, prefAge, prefAgeRange, distance) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);	
				pstmt.setString(1, uID); 				
				pstmt.setString(2, ID);					
				pstmt.setString(3, PW); 				
				pstmt.setString(4, sex);				
				pstmt.setString(5, age); 				
				pstmt.setString(6, ageRange); 			
				pstmt.setString(7, prefAge);			
				pstmt.setString(8, prefAgeRange); 				
				pstmt.setString(9, distance); 				
				pstmt.executeUpdate();
			}
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

