<!-- Show sign up success if there was no duplicate ID in DB 
	 else, go back to sign up page
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get user info
	String ID = request.getParameter("ID");
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
				pstmt.setString(1, ID);
				pstmt.setString(2, PW);
				rs = pstmt.executeQuery();
				
				if (rs.next()){	// if ID/PW was already exists
			%>
					<h2>Sign Up Fail</h2>
					<p>Duplicate ID/PW exists</p>
					<!-- Back to Sign Up page -->
					<form method="post" action="signUpForm.jsp">
						<button type="submit">Back to Sign Up</button>
					</form>
			<%
				}
				else{	// if ID/PW was not duplicate, then add ID/PW in userDB
					sql = "INSERT INTO userInfo VALUES(?, ?, null)";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, ID); 				// first param = ID
					pstmt.setString(2, PW);					// second param = PW
					pstmt.executeUpdate();
			%>	
				<h2>Sign Up Complete!</h2>
				<p>Now you can login</p>
				<!-- Back to Login page -->
				<form method="post" action="loginForm.jsp">
					<button type="submit">Back to Login</button>
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


			
	

