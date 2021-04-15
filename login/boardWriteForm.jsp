<!-- Show user to write a post in the board -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Write Post</h2>
		<form method="post" action="boardWrite.jsp">
			<!-- Title -->
			<div>
				<label>Title</label>
				<input type="text" name="title" size="20"/>
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
			<br><button type="submit" value="<%=currentUser%>">SUBMIT</button>
		</form>
	
		<!-- Cancel button -->
		<form method="post" action="boardShowEdit.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>