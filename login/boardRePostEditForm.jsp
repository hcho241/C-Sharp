<!-- Screen of user's posting edit form -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get MID of the post 
	String num = request.getParameter("num");
	
	// get title of Reply post
	String reTitle = request.getParameter("reTitle");
	
	// get original content of post
	String originalContent = request.getParameter("originalContent");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Edit Your Post</h2>
		<form method="post" action="boardRePostEdit.jsp">
			<!-- title -->
			<div>
				<label>Title <%=reTitle%></label>
			</div>
			<!-- Writer -->
			<div>
				<label>Writer <%=currentUser%></label>
			</div>
			<!-- Content -->
			<div>
				<br>
				<label>Content</label> 
				<br><textarea name="newContent" rows="20" cols="70" placeholder="<%=originalContent%>"></textarea>
			</div>
			<!-- POST button -->
			<br>
			<input type="hidden" value="<%=reTitle%>" name="reTitle"></hidden>
			<input type="hidden" value="<%=num%>" name="num"></hidden>
			<button type="submit" value="<%=currentUser%>">EDIT</button>
		</form>
		
		<!-- Cancel button -->
		<form method="post" action="boardShowEdit.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>