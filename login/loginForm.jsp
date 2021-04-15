<!-- Show LOGIN FORM -->
<%@ page contentType="text/html;charset=euc-kr"%>

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
			<form method="post" action="login.jsp">
				<!-- ID -->
				<div>
					<label>ID :</label>
					<input type="text" name="ID"/>
				</div>
				<!-- PW -->
				<div>
					<label>PW :</label>
					<input type="password" name="PW"/>
				</div>	
				<!-- Login Button -->
				<button type="submit">LOGIN</button>
			</form>
			<form method="post" action="signUpForm.jsp">
				<button type="submit">SIGN UP</button>
			</form>
		</section>
	</body>
</html>