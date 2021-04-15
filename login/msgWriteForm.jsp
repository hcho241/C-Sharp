<!-- Show user to write a post in the board -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//support korean
	request.setCharacterEncoding("euc-kr");
	
	// get current user ID
	String currentUser = (String)session.getAttribute("ID");
	
	// get receiver, subject from msg
	String receiver = request.getParameter("receiver");
	String subject = request.getParameter("subject");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2>Write Message</h2>
		<form method="post" action="msgWrite.jsp">
			<!-- Title -->
			<div>
				<label>Subject : </label>
				<input type="text" name="subject" size="20"/>
			</div>
			<!-- Sender -->
			<div>
				<label>Sender : <%=currentUser%></label>
			</div>
			<!-- Receiver -->
			<div>
				<label>Receiver : </label>
				<input type="text" name="receiver" size="20"/>
			</div>
			<!-- Content -->
			<div>
				<br>
				<label>Message</label> 
				<br><textarea name="message" rows="20" cols="70"></textarea>
			</div>
			<!-- SEND button -->
			<input type="hidden" value="<%=subject%>" name="subject"/>
			<input type="hidden" value="<%=receiver%>" name="receiver"/>
			<br><button type="submit" value="<%=currentUser%>">SEND</button>
		</form>
	
		<!-- Cancel button -->
		<form method="post" action="menuForm.jsp">
			<button type="submit" value="<%=currentUser%>">CANCEL</button>
		</form>
	</body>
</html>