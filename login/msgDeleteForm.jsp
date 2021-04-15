<!-- Ask user to DELETE MSG when userID == receiver -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get MID of the post 
	String msgID = request.getParameter("msgID");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Delete Message</h2>
		<p>Once you delete, you can't restore.</p>
		<form method="post" action="msgDelete.jsp">
			<!-- Delete button -->
			<input type="hidden" value="<%=msgID%>" name="msgID"></hidden>
			<button type="submit" value="<%=currentUser%>">DELETE</button>
		</form>
		<!-- Cancel button -->
		<form method="post" action="msgReceivedForm.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>