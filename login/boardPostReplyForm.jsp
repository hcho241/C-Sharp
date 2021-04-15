<!-- Show user to reply a post in the board -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get title of original post
	String reTitle = request.getParameter("reTitle");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Write Reply</h2>
		<form method="post" action="boardPostReply.jsp">
			<!-- Title -->
			<div>
				<label>Title [RE:]<%=reTitle%></label>
			</div>
			<!-- Writer -->
			<div>
				<label>Writer <%=currentUser%></label>
			</div>
			<!-- Content -->
			<div>
				<br>
				<label>Content</label> 
				<br><textarea name="contents" rows="20" cols="70"></textarea>
			</div>
			<!-- POST button -->
			<input type="hidden" value="<%=reTitle%>" name="reTitle"/>
			<br><button type="submit" value="<%=currentUser%>">SUBMIT</button>
		</form>
	
		<!-- Cancel button -->
		<form method="post" action="boardShowEdit.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>