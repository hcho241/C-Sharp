<!-- DELETE MSG -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get board info
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
		<!-- Connecting to user DB -->
		<%
			try{
		%>
				<%@ include file="../include/dbOpen.inc" %>	
			<%
				sql = "SELECT msgID FROM msgInfo WHERE msgID = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, msgID);
				rs = pstmt.executeQuery();				
				
				if (rs.next()){
					sql = "UPDATE msgInfo SET del = 'del' WHERE msgID = ?";
					pstmt = conn.prepareStatement(sql);	
					pstmt.setString(1, msgID); 				
					pstmt.executeUpdate();
			%>
				<p>Selected Message was successfully deleted.</p>
				<form method="post" action="msgReceivedForm.jsp">
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