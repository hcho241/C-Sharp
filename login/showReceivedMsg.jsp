<!-- Show RECEIVED message & WRITE REPLY & DELETE MESSAGE button if currentUser == receiver -->
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
				sql = "SELECT subject, sender, message, receiver FROM msgInfo WHERE msgID = ? AND receiver = ?";
				pstmt = conn.prepareStatement(sql);	
				pstmt.setString(1, msgID);
				pstmt.setString(2, currentUser);
				rs = pstmt.executeQuery();
				
				if (rs.next()){				
			%>			
					<!-- Title -->
					<div>
						<label>Subject : </label>
						<%=rs.getString("subject")%>
					</div>
					<!-- Sender -->
					<div>
						<label>Sender : </label>
						<%=rs.getString("sender")%>
					</div>
					<!-- Content -->
					<div>
						<label>Message : </label> 
						<br>
						<textarea name="message" rows="20" cols="70">
						<%=rs.getString("message")%>
						</textarea>
					</div>		
					
					<!-- Edit button when current user == writer -->
					<form method="post" action="msgReplyForm.jsp">
						<input type="hidden" value="<%=rs.getString("subject")%>" name="subject"/>
						<input type="hidden" value="<%=rs.getString("sender")%>" name="receiver"/>
						<br><button type="submit" value="<%=currentUser%>">REPLY</button>
					</form>
										
					<!-- Delete button when current user == writer -->
					<form method="post" action="msgDeleteForm.jsp">
						<input type="hidden" value="<%=msgID%>" name="msgID"/>
						<br><button type="submit" value="<%=currentUser%>">DELETE</button>
					</form>
										
					<!-- Back button when user log in -->
					<form method="post" action="msgReceivedForm.jsp">
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