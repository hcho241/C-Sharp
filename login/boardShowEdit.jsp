<!-- Show TITLE LINK to edit page when user == writer -->
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
		<p>Hello, user "<%=currentUser%>"</p>
		<h2>BOARD</h2>
		<table style="width:100%">
			<!-- Board number -->
			<tr>
				<th>No.</th>
				<th>Title</th>
				<th>Writer</th>
				<th>Date</th>
				<th>View</th>
			</tr>
			<!-- Connecting to board DB -->
			<%
				try{
			%>
					<%@ include file="../include/dbOpen.inc" %>
				<%
					sql = "SELECT * FROM boardInfo WHERE del is null ORDER BY CAST(num AS int) DESC";
					pstmt = conn.prepareStatement(sql);	
					rs = pstmt.executeQuery();
					while (rs.next()){	
				%>
						<tr>
							<!-- Post number -->
							<td><%=rs.getString("num")%></td>
							<!-- Title -->
							<td>
								<a href="boardContentsEditForm.jsp?num=<%=rs.getString("num")%>&user=<%=currentUser%>"><%=rs.getString("title")%></a>
							</td>
							<!-- Writer -->
							<td><%=rs.getString("writer")%> </td>
							<!-- Date -->
							<td><%=rs.getString("date")%> </td>
							<!-- View -->
							<td><%=rs.getString("views")%> </td>
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
		<!-- Post Button to write in the board when user login -->
		<form method="post" action="boardWriteForm.jsp">
			<button type="submit" value="<%=currentUser%>">WRITE POST</button>
		</form>
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



		
	
		