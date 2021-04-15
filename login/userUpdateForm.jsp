<!-- Show PW UPDATE FORM -->
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
		<section>		
			<h2>Update your password</h2>
			<p>Please enter your ID to confirm your action.</p>
			<form method="post" action="userUpdate.jsp">
				<!-- ID -->
				<div>
					<label>ID : <%=currentUser%></label>
				</div>
				<!-- Original PW -->
				<div>
					<label>Original PW :</label>
					<input type="password" name="originalPW"/>
				</div>	
				<!-- New PW -->
				<div>
					<label>New PW :</label>
					<input type="password" name="newPW"/>
				</div>	
				<button type="submit" value="<%=currentUser%>">SUBMIT</button>
			</form>
			<!-- Cancel Button to return menu page -->
			<form method="post" action="menuForm.jsp">
				<button type="submit">CANCEL</button>
			</form>
		</section>
	</body>
</html>