<!-- Screen of user's posting edit form -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get MID of the post 
	String num = request.getParameter("num");
	
	// get original title, content of post
	String originalTitle = request.getParameter("originalTitle");
	String originalContent = request.getParameter("originalContent");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Edit Your Post</h2>
		<form method="post" action="boardPostEdit.jsp">
			<!-- title -->
			<div>
				<label>Title</label>
				<input type="text" name="newTitle" size="20" placeholder="<%=originalTitle%>"/>
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
			<input type="hidden" value="<%=num%>" name="num"></hidden>
			<button type="submit" value="<%=currentUser%>">EDIT</button>
		</form>
		
		<!-- Cancel button -->
		<form method="post" action="boardShowEdit.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>