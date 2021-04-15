<!-- Show RECEIVED message board -->
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
		<style>
			table, th, td{
				border : 1px solid black;
				border-collapse : collapse;
				text-align : center;
			}
		</style>
	</head>
	<body>
		<h2>USER : <%=currentUser%>'S RECEIVED MESSAGES</h2>
		<table style="width:100%">
			<!-- Board number -->
			<tr>
				<th>No.</th>
				<th>Subject</th>
				<th>Date</th>
				<th>Sender</th>
			</tr>
			<!-- Connecting to userDB -->
			<%
				try{
			%>
					<%@ include file="../include/dbOpen.inc" %>
				<%
					// only shows messages if current user == receiver
					sql = "SELECT * FROM msgInfo WHERE del is null AND receiver = ? ORDER BY CAST(msgID AS int) DESC";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, currentUser);
					rs = pstmt.executeQuery();
					while (rs.next()){	
				%>
						<tr>
							<!-- Message number -->
							<td><%=rs.getString("msgID")%></td>
							<!-- Subject -->
							<td>
								<a href="showReceivedMsg.jsp?msgID=<%=rs.getString("msgID")%>&user=<%=currentUser%>"><%=rs.getString("subject")%></a>
							</td>
							<!-- Date -->
							<td><%=rs.getString("date")%> </td>
							<!-- Sender -->
							<td><%=rs.getString("sender")%> </td>	
						</tr>
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
		</table>
		<!-- Back To Menu Button -->
		<form method="post" action="menuForm.jsp">
			<button type="submit" value="<%=currentUser%>">BACK TO MENU</button>
		</form>
		<!-- Log out Button -->
		<form method="post" action="logout.jsp">
			<button type="submit" value="<%=currentUser%>">LOGOUT</button>
		</form>
	<%
		// after execute 
		if(!rst.equals("success")){
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>



		
	
		