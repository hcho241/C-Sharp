<!-- Show USER ACCOUNT REMOVE FORM -->
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
			<h2>Enter your PW again to remove your account</h2>
			<form method="post" action="userDelete.jsp">
				<!-- ID -->
				<div>
					<label>ID : <%=currentUser%></label>
				</div>
				<!-- PW -->
				<div>
					<label>PW :</label>
					<input type="password" name="PW"/>
				</div>	
				<!-- Submit Button -->
				<button type="submit">SUBMIT</button>
			</form>
			<!-- Cancel Button to return menu page-->
			<form method="post" action="menuForm.jsp">
				<button type="submit">CANCEL</button>
			</form>
		</section>
	</body>
</html>