<!-- After user edit the post -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get board info
	String num = request.getParameter("num");
	String newTitle = request.getParameter("newTitle");
	String newContent = request.getParameter("newContent");
	
	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String today = "";
	String sql = "";
	String rst = "success";	 
	String msg = "";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<!-- Connecting to board DB -->
		<%
			try{
		%>
				<%@ include file="../include/dbOpen.inc" %>
			<%
				// date
				sql = "SELECT CAST(getdate() AS date) as today";
				pstmt = conn.prepareStatement(sql);	
				rs = pstmt.executeQuery();
				if (rs.next()){
					today = rs.getString("today");
					sql = "UPDATE boardInfo SET title = ?, date = ?, contents = ? WHERE num = ?";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, newTitle); 	
					pstmt.setString(2, today); 
					pstmt.setString(3, newContent);		
					pstmt.setString(4, num);						
					pstmt.executeUpdate();
			%>

		<%
				}
			} 
			catch(Exception e){
				rst = "Server Error";
				msg = e.getMessage();
			} 
			finally { // after one page, it closes everything
				if (rs != null){
					rs.close();
				}
				if (pstmt != null){
					pstmt.close();
				}
				if (conn != null){
					conn.close();
				}
			}
		%>
	<%
		// after execute 
		if(rst.equals("success")){
			response.sendRedirect("../login/boardShowEdit.jsp");
		}
		else{
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>