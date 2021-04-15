<!-- If new pw != original pw, go back to login page
	 else, go back to pw update page
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get user info
	String originalPW = request.getParameter("originalPW");
	String newPW = request.getParameter("newPW");
	
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
		<title> Password Update Complete </title>
	</head>
	<body>		
		<!-- Connecting to DB & Login Process -->
		<%
			try{
		%>
				<%@ include file="../include/dbOpen.inc" %>
				
			<%
				// First, check whether duplicate ID/PW exists 
				sql = "SELECT ID FROM userInfo WHERE ID = ? and PW = ? and del is null";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, currentUser);
				pstmt.setString(2, originalPW);
				rs = pstmt.executeQuery();
				
				if (rs.next()){
					sql = "UPDATE userInfo SET PW = ? WHERE ID = ?";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, newPW); 				
					pstmt.setString(2, currentUser);				
					pstmt.executeUpdate();
			%>
				<h2>Your Password was successfully changed!</h2>
				<!-- Back to Login page -->
				<form method="post" action="loginForm.jsp">
					<button type="submit">Back to Login</button>
				</form>
			<%
				}
				else{
			%>
					<h2>ALERT</h2>
					<p> 
						Your Password must be different from your original password.
					</p>
					<!-- Back to PW update page -->
					<form method="post" action="userUpdateForm.jsp">
						<button type="submit" value="<%=currentUser%>">Back to Update</button>
					</form>
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
		if(!rst.equals("success")){
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>
