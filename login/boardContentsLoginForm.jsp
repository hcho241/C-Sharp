<!-- ONLY SHOW POST OF OTHERS & BACK BUTTON since currentUser != writer -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID"); 
	
	// get board info
	String num = request.getParameter("num");

	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	String rst = "success";	 
	String msg = "";
	String views = "";
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
				// Only shows the post that the user clicked
				sql = "SELECT views, title, writer, contents FROM boardInfo WHERE num = ?";
				pstmt = conn.prepareStatement(sql);	
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				
				if (rs.next()){
					// update view + 1
					views = rs.getString("views");
					int count = Integer.parseInt(views) + 1;
					views = Integer.toString(count);
					
					// sql to update view
					sql = "UPDATE boardInfo SET views = ? WHERE num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, views);
					pstmt.setString(2, num);
					pstmt.executeUpdate();
			%>
				<!-- Title -->
				<div>
					<label>Title</label>
					<%=rs.getString("title")%>
				</div>
				<!-- Writer -->
				<div>
					<label>Writer</label>
					<%=rs.getString("writer")%>
				</div>
				<!-- Content -->
				<div>
					<label>Content</label> 
					<br>
					<textarea name="contents" rows="20" cols="70">
					<%=rs.getString("contents")%>
					</textarea>
				</div>
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
		<!-- Reply button when user log in -->
		<form method="post" action="boardPostReplyForm.jsp">
			<input type="hidden" value="<%=num%>" name="num"></hidden>
			<br><button type="submit" value="<%=currentUser%>">REPLY</button>
		</form>
		<!-- Back button when user log in -->
		<form method="post" action="boardShowEdit.jsp">
			<br><button type="submit" value="<%=currentUser%>">BACK</button>
		</form>
	<%
		// after execute 
		if(!rst.equals("success")){
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>