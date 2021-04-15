<!-- Ask user to DELETE POST when userID == writer -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get MID of the post 
	String num = request.getParameter("num");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Delete Your Post</h2>
		<p>Once you delete, you can't restore.</p>
		<form method="post" action="boardDelete.jsp">
			<!-- Delete button -->
			<input type="hidden" value="<%=num%>" name="num"></hidden>
			<button type="submit" value="<%=currentUser%>">DELETE</button>
		</form>
		<!-- Cancel button -->
		<form method="post" action="boardShowEdit.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>