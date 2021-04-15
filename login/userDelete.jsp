<!-- Remove user account -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get user info
	String PW = request.getParameter("PW");
	
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
		<!-- Connecting to DB & Login Process -->
		<%
			try{
		%>
				<%@ include file="../include/dbOpen.inc" %>
				
			<%
				// First, check whether duplicate ID/PW exists 
				sql = "SELECT ID FROM userInfo WHERE ID = ? and PW = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, currentUser);
				pstmt.setString(2, PW);
				rs = pstmt.executeQuery();
				
				if (rs.next()){
					sql = "UPDATE userInfo SET DEL = 'del' WHERE ID = ? and PW = ?";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, currentUser); 				
					pstmt.setString(2, PW);				
					pstmt.executeUpdate();
			%>
				<h2>Your account was removed successfully!</h2>
				<form method="post" action="loginForm.jsp">
					<button type="submit">BACK TO MAIN</button>
				</form>
		<%
				}
				else{	// if user selects cancel, go back to loginForm page
					response.sendRedirect("../login/loginForm.jsp");
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
		if(!rst.equals("success")){
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>
	
		
	