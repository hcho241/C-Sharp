<!-- Show SENT message & DELETE MESSAGE button if currentUser == sender -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID"); 
	
	// get message info
	String msgID = request.getParameter("msgID");

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
		<!-- Connecting to userDB -->
		<%
			try{
		%>
				<%@ include file="../include/dbOpen.inc" %>
			<%
				// if receiver == user ID, show reply button & delete button
				sql = "SELECT subject, message, receiver FROM msgInfo WHERE msgID = ? AND sender = ?";
				pstmt = conn.prepareStatement(sql);	
				pstmt.setString(1, msgID);
				pstmt.setString(2, currentUser);
				rs = pstmt.executeQuery();
				
				if (rs.next()){
			%>
					<!-- Subject -->
					<div>
						<label>Subject : </label>
						<%=rs.getString("subject")%>
					</div>
					<!-- Receiver -->
					<div>
						<label>Receiver : </label>
						<%=rs.getString("receiver")%>
					</div>
					<!-- Message -->
					<div>
						<label>Message : </label> 
						<br>
						<textarea name="message" rows="20" cols="70">
						<%=rs.getString("message")%>
						</textarea>
					</div>			
					<!-- Delete button when current user == writer -->
					<form method="post" action="msgDeleteForm.jsp">
						<input type="hidden" value="<%=msgID%>" name="msgID"/>
						<br><button type="submit" value="<%=currentUser%>">DELETE</button>
					</form>
										
					<!-- Back button when user log in -->
					<form method="post" action="msgSentForm.jsp">
						<br><button type="submit" value="<%=currentUser%>">BACK</button>
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