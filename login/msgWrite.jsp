<!-- Insert what user sent in msgInfo table -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get msginfo
	String msgID = request.getParameter("msgID");
	String subject = request.getParameter("subject");
	String message = request.getParameter("message");
	String receiver = request.getParameter("receiver");
	
	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String mID = "";
	String today = "";
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
				// First, find max num then increment by 1 to avoid duplicate when user delete post
				sql = "SELECT MAX(CAST(msgID AS int)) AS cnt FROM msgInfo WHERE DEL is null";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()){
					msgID = rs.getString("cnt");
					int index = Integer.parseInt(msgID)+1;
					msgID = Integer.toString(index);
					// date
					sql = "SELECT CAST(getdate() AS date) as today";
					pstmt = conn.prepareStatement(sql);	
					rs = pstmt.executeQuery();
					if (rs.next()){
						today = rs.getString(1);
						// writer == currentUser 
						sql = "INSERT INTO msgInfo(msgID, subject, date, sender, message, receiver) VALUES(?, ?, ?, ?, ?, ?)";
						pstmt = conn.prepareStatement(sql);	
						pstmt.setString(1, msgID);
						pstmt.setString(2, subject); 	
						pstmt.setString(3, today); 		
						pstmt.setString(4, currentUser);			
						pstmt.setString(5, message);	
						pstmt.setString(6, receiver);	
						pstmt.executeUpdate();
					}	
				}
			%>
		<%
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
		if(rst.equals("success")){
			response.sendRedirect("../login/msgSentForm.jsp");
		}
		else{
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>