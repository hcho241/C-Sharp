<!-- Insert what user write a post in the board in boardDB-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get board info
	String title = request.getParameter("title");
	String contents = request.getParameter("contents");
	
	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String num = "";
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
		<!-- Connecting to board DB -->
		<%
			try{
		%>
				<%@ include file="../include/dbOpen.inc" %>	
			<%
				// First, find max num then increment by 1 to avoid duplicate when user delete post
				sql = "SELECT MAX(CAST(num AS int)) AS cnt FROM boardInfo WHERE DEL is null";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()){
					num = rs.getString("cnt");
					int index = Integer.parseInt(num)+1;
					num = Integer.toString(index);
					// date
					sql = "SELECT CAST(getdate() AS date) as today";
					pstmt = conn.prepareStatement(sql);	
					rs = pstmt.executeQuery();
					if (rs.next()){
						today = rs.getString(1);
						// writer == currentUser 
						sql = "INSERT INTO boardInfo(num, title, writer, date, contents, views) VALUES(?, ?, ?, ?, ?, 0)";
						pstmt = conn.prepareStatement(sql);	
						pstmt.setString(1, num);
						pstmt.setString(2, title); 	
						pstmt.setString(3, currentUser); 		
						pstmt.setString(4, today);			
						pstmt.setString(5, contents);	
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
			response.sendRedirect("../login/boardShowEdit.jsp");
		}
		else{
			response.sendRedirect("../login/connectionError.jsp?rst=" + rst + "&msg=" + msg);
		}
	%>
	</body>
</html>