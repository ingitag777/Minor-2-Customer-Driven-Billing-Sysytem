<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> <%--import database package --%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>

<%
	Connection conn =null;
	Statement stmt =null;
	
	try
	{
		//storing credentials entered by user
		String barcode[] = request.getParameterValues("rem");
		
		//registering the driver class
		Class.forName("com.mysql.jdbc.Driver");
		//connection to the database
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c_d_b_s","root","root");
		stmt = conn.createStatement();
		for(int i=0; barcode.length > i ;i++)
		{
			//query to be executed
			String query = "DELETE FROM inventory WHERE Barcode = '" + barcode[i] + "'";
			//executing query to fetch the database records
			stmt.executeUpdate(query);
		}
	    stmt.close();
	    conn.close();
	}
	
	catch(Exception e)
	{
		e.printStackTrace();
		//in case of any exception
		out.println("Problem encountered.<br> You cannot proceed further.<br>");
	}
	
%>
  

<!DOCTYPE html>
<html>

	<head>
	
		<link rel="stylesheet" href="style.css">
		
		<title>Inventory</title>
		
		<script type="text/javascript">
			
			//redirection to login page 
			function Redirect() {
	            window.location = "inventory.jsp";
	         }            
	         setTimeout('Redirect()', 1000);
         
	         //eliminating backtracking
	         window.history.forward();
			function noBack() { window.history.forward(); }
		</script>
	
	</head>
	
	<body class="body-all" id="withdraw-body" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	</body>
	
</html>