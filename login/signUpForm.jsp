<!-- Show SIGN UP FORM -->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>

<%
	//support korean
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<section>		
			<!-- ID -->
			<h2>You don't have an account with us.</h2>
			<p>Please enter ID and PW to create your account.</p>
			<form method="post" action="signUp.jsp">
				<!-- ID -->
				<div>
					<label>ID:</label>
					<input type="text" name="ID"/>
				</div>
				<!-- PW -->
				<div>
					<label>PW:</label>
					<input type="password" name="PW"/>
				</div>	
				<!-- Submit Button -->
				<button type="submit">SUBMIT</button>
			</form>
			<!-- Cancel Button to return Login page -->
			<form method="post" action="loginForm.jsp">
				<button type="submit">CANCEL</button>
			</form>
		</section>
	</body>
</html>

