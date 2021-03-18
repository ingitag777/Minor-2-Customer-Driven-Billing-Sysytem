<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> <%--import database package --%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>

<!DOCTYPE html>
<html>

<%
	Connection conn =null;
	Statement stmt =null;
	ResultSet res = null;
	
	//query to be executed
	String query = "SELECT * from customer_details";
	try
	{
		//storing credentials entered by user
		long login_num = Long.parseLong(request.getParameter("u_num"));
		
		//registering the driver class
		Class.forName("com.mysql.jdbc.Driver");
		//connection to the database
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c_d_b_s","root","root");
		stmt = conn.createStatement();
		//executing query to fetch the database records
		res =stmt.executeQuery(query);
		boolean condition = true;
		//checking if existing customer if not then add in record
		for(int i=1; res.next(); i++)
		{
			//getting user number from database
			long user_num = res.getLong(1);
			
			if(user_num == login_num)
				condition = false;
		}
		if(condition)
		{
			query = "INSERT INTO customer_details VALUES(" + login_num + ")";
			//executing query to update the database records
			stmt.executeUpdate(query);
		}
		res.close();
		stmt.close();
		conn.close();
		
	%>
	<jsp:forward page="home.html"/>
	<%
	}
	
	catch(Exception e)
	{
		//in case of any exception
		out.println("Problem encountered.<br> You cannot proceed further.<br>");
	}
	
%>
  



	<head>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
	        //redirection to login page 
			function Redirect() {
	            window.location = "index.html";
	         }            
	         document.write("You will be redirected to main page in 5 sec.");
	         setTimeout('Redirect()', 5000);
			 
	         //eliminating backtracking
	         window.history.forward();
			function noBack() { window.history.forward(); }
		</script>
	
	</head>
	
	<body class="body-all" id="withdraw-body" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	</body>
	
</html>
