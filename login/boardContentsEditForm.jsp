<!-- Show board's post & EDIT POST & DELETE POST button if currentUser == writer -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID"); 
	
	// get board info
	String num = request.getParameter("num");
	String title = request.getParameter("title");	
	String contents = request.getParameter("contents");

	// initiate variables
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	String rst = "success";	 
	String msg = "";
	String views = "";
	String reTitle = "";
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
				// if writer == user ID, show edit button & back button
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
				}
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
					if (currentUser.equals(rs.getString("writer"))){
						if(rs.getString("title").contains("[RE:]")){
							reTitle = rs.getString("title");
				%>
						<form method="post" action="boardRePostEditForm.jsp">
							<input type="hidden" value="<%=reTitle%>" name="reTitle"/>
							<input type="hidden" value="<%=rs.getString("contents")%>" name="originalContent"/>
							<input type="hidden" value="<%=num%>" name="num"/>
							<br><button type="submit" value="<%=currentUser%>">EDIT POST</button>
						</form>
						
						<!-- Delete button when current user == writer -->
							<form method="post" action="boardDeleteForm.jsp">
								<input type="hidden" value="<%=num%>" name="num"/>
								<br><button type="submit" value="<%=currentUser%>">DELETE POST</button>
							</form>
							
						<!-- Back button when user log in -->
							<form method="post" action="boardShowEdit.jsp">
								<br><button type="submit" value="<%=currentUser%>">BACK</button>
							</form>
					<%	}
						else{
					%>
							<!-- Edit button when current user == writer -->
							<form method="post" action="boardPostEditForm.jsp">
								<input type="hidden" value="<%=num%>" name="num"/>
								<input type="hidden" value="<%=rs.getString("contents")%>" name="originalContent"/>
								<input type="hidden" value="<%=rs.getString("title")%>" name="originalTitle"/>
								<br><button type="submit" value="<%=currentUser%>">EDIT POST</button>
							</form>
							
							<!-- Delete button when current user == writer -->
							<form method="post" action="boardDeleteForm.jsp">
								<input type="hidden" value="<%=num%>" name="num"/>
								<br><button type="submit" value="<%=currentUser%>">DELETE POST</button>
							</form>
							
							<!-- Back button when user log in -->
								<form method="post" action="boardShowEdit.jsp">
									<br><button type="submit" value="<%=currentUser%>">BACK</button>
								</form>
		<%
						}
					}
				else{
					reTitle = rs.getString("title");
		%>
					<!-- Reply button when user log in -->
					<form method="post" action="boardPostReplyForm.jsp">
						<input type="hidden" value="<%=reTitle%>" name="reTitle"/>
						<br><button type="submit" value="<%=currentUser%>">REPLY</button>
					</form>
					<!-- Back button when user log in -->
					<form method="post" action="boardShowEdit.jsp">
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