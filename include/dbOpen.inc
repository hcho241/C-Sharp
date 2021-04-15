<%
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
conn=DriverManager.getConnection("jdbc:sqlserver://localhost:51486;databasename=userDB;user=hp2;password=1234;");
%>