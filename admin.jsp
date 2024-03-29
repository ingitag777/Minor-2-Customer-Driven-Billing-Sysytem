<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> <%--import database package --%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>

<%
	Connection con =null;
	Statement stmt =null;
	ResultSet res = null;
	
	//query to be executed
	String query = "select * from admin_details";
	try
	{
		//storing credentials entered by user
		String loginId = request.getParameter("uname");
		String loginPass = request.getParameter("pass");
		
		//registering the driver class
		Class.forName("com.mysql.jdbc.Driver");
		//connection to the database
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/c_d_b_s","root","root");
		stmt = con.createStatement();
		//executing query to fetch the database records
		res =stmt.executeQuery(query);
		
		//validation of credentials
		while(res.next())
		{
			//getting account id and pin from database
			String admin_id = res.getString(1);
			String password = res.getString(2);
			
			if(admin_id.equals(loginId))
			{
				if(password.equals(loginPass)) //credentials verified
				{
					//passing control to home page
					//RequestDispatcher reqdisp1 = request.getRequestDispatcher("home.jsp");
					//reqdisp1.forward(request, response);
					response.sendRedirect("inventory.jsp");
				}
			}
		}
		
		out.println("Wrong Credentials!!<br>");
	}
	
	catch(Exception e)
	{
		//in case of any exception
		out.println("Problem encountered.<br> You cannot proceed further.<br>");
	}	
%>
	
	<%--//redirection to login page--%>

<!DOCTYPE html>
<html>

	<head>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
	        //redirection to login page 
			function Redirect() {
	            window.location = "adminlogin.html";
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