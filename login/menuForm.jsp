<!-- Show menu tab -->
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
		<style>
			body {
			  margin: 0;
			  font-family: Arial, Helvetica, sans-serif;
			}	
			.navbar {
			  overflow: hidden;
			  background-color: #333;
			}
			.navbar a {
			  float: left;
			  font-size: 16px;
			  color: white;
			  text-align: center;
			  padding: 14px 16px;
			  text-decoration: none;
			}
			.subnav {
			  float: left;
			  overflow: hidden;
			}
			.subnav .subnavbtn {
			  font-size: 16px;  
			  border: none;
			  outline: none;
			  color: white;
			  padding: 14px 16px;
			  background-color: inherit;
			  font-family: inherit;
			  margin: 0;
			}
			.navbar a:hover, .subnav:hover .subnavbtn {
			  background-color: red;
			}
			.subnav-content {
			  display: none;
			  position: absolute;
			  left: 0;
			  background-color: red;
			  width: 100%;
			  z-index: 1;
			}
			.subnav-content a {
			  float: left;
			  color: white;
			  text-decoration: none;
			}
			.subnav-content a:hover {
			  background-color: #eee;
			  color: black;
			}
			.subnav:hover .subnav-content {
			  display: block;
			}
			</style>
		</head>
	<body>
		<div style="padding-left:16px">
		  <h2>Welcome back, USER "<%=currentUser%>"</h2>
		</div>
		<div class="navbar">
			<a href="#home">HOME</a>
			<div class="subnav">
				<button class="subnavbtn">BOARD</button>
				<div class="subnav-content">
					<a href="boardListRedirect.jsp">VIEW POST</a>
					<a href="boardWriteMenuForm.jsp">WRITE POST</a>
				</div>
			</div> 
			<div class="subnav">
				<button class="subnavbtn">MESSAGE</button>
				<div class="subnav-content">
					<a href="msgWriteForm.jsp">WRITE MESSAGE</a>
					<a href="msgReceivedForm.jsp">RECEIVED MESSAGE</a>
					<a href="msgSentForm.jsp">SENT MESSAGE</a>
				</div>
			</div> 
			<div class="subnav">
				<button class="subnavbtn">SETTING</button>
				<div class="subnav-content">
					<a href="userUpdateForm.jsp">UPDATE PW</a>
					<a href="userDeleteForm.jsp">DELETE ACCOUNT</a>
				</div>
			</div>
			<a href="logout.jsp">LOGOUT</a>
		</div>
	</body>
</html>


