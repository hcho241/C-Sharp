<!-- If ID is matched in userDB, login success
	 else, login fail 
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.io.*" %>
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
				sql = "SELECT ID FROM userInfo WHERE ID = ? and PW = ? and del is null";
				pstmt = conn.prepareStatement(sql);	
				pstmt.setString(1, ID); 				// first param = ID
				pstmt.setString(2, PW);					// second param = PW
				rs = pstmt.executeQuery();
			
				// if ID/PW was matched in userDB
				if (rs.next()){	
					// Change RS to JSON format
					//json.put("ID", rs.getString("ID"));
					//json.put("PW", rs.getString("PW"));
					
					// to remember ID after the user login
					session.setAttribute("ID", ID); 
					String userID = (String)session.getAttribute("ID"); 
					response.sendRedirect("../login/menuForm.jsp");
				}
				else{
					// if only ID was matched in userDB
					sql = "SELECT ID FROM userInfo WHERE PW = ? and del is null";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, PW); 				// second param = PW
					rs = pstmt.executeQuery();
					
					if (rs.next()){	
			%>
						<h2>Login Fail</h2>
						<p>Please enter your PW again</p>
						<form method="post" action="loginForm.jsp">
								<button type="submit">BACK</button>
						</form>
			<%
					}
					else{
			%>
						<h2>Login Fail</h2>
						<p>Please enter your ID again</p>
						<form method="post" action="loginForm.jsp">
								<button type="submit">BACK</button>
						</form>
		<%
					}
					response.sendRedirect("../login/signUpForm.jsp");
				}
			}
		catch(Exception e){
			rst = "Server Error";
			msg = e.getMessage();
			//response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
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


		