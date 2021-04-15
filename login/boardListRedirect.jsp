<!-- when user login, 
	 User == writer -> redirect to edit post page
	 User != writer -> redirect to only show post page 
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
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
				sql = "SELECT * FROM boardInfo";
				pstmt = conn.prepareStatement(sql);	
				rs = pstmt.executeQuery();
				while (rs.next()){	
					sql = "SELECT writer FROM boardInfo where writer = ?";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, currentUser);
					rs = pstmt.executeQuery();
					if (rs.next()){						// userID == writer -> edit 
						response.sendRedirect("../login/boardShowEdit.jsp");
					}
					else{
						response.sendRedirect("../login/boardUserNoPost.jsp");			
					}
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
	</body>
</html>



		
	
		