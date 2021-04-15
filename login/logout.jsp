<!-- LOGOUT -->
<%
	session.invalidate();
	response.sendRedirect("../login/loginForm.jsp");
%>


		