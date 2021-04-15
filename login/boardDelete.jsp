<!-- DELETE the post -->
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
				sql = "SELECT num FROM boardInfo WHERE num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();				
				
				if (rs.next()){
					sql = "UPDATE boardInfo SET DEL = 'del' WHERE num = ?";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, num); 				
					pstmt.executeUpdate();
			%>
				<p>Your post was successfully deleted.</p>
				<form method="post" action="boardListRedirect.jsp">
					<button type="submit" value="<%=currentUser%>">BACK</button>
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