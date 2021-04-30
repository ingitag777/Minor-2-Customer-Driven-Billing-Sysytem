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
		
		try
		{
			//storing credentials entered by user
			long login_num = Long.parseLong(request.getParameter("u_num"));
			String login_name = request.getParameter("u_name");
			//query to be executed
			String query;
			//registering the driver class
			Class.forName("com.mysql.jdbc.Driver");
			//connection to the database
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/c_d_b_s","root","root");
			stmt = conn.createStatement();
			if(!login_name.isEmpty())
			{
				query = "UPDATE customer_details SET User_Name = '" + login_name + "' WHERE Phone_No = " + login_num + " AND User_Name = 'User'";
				stmt.executeUpdate(query);
				stmt.close();
				stmt = conn.createStatement();
			}
			query = "SELECT EXISTS(SELECT * FROM customer_details WHERE Phone_No = "+ login_num + ")";
			//executing query to check if records exists im database
			res =stmt.executeQuery(query);
			res.next();
			//checking if existing customer if not then add in record
			if(res.getInt(1) == 0 )
			{
				res.close();
				stmt.close();
				stmt = conn.createStatement();
				query = "INSERT INTO customer_details VALUES(" + login_num + "" + ( login_name.isEmpty() ? "" : ",'" + login_name + "')");		
				//executing query to update the database records
				stmt.executeUpdate(query);
				query = "CREATE TABLE IF NOT EXISTS cart_" + login_num + "(" +
						"Barcode varchar(14) NOT NULL," +
						"Quantity decimal(5,0) unsigned NOT NULL," +
						"PRIMARY KEY (Barcode)" +
						")";
				stmt.executeUpdate(query);
				query = "ALTER TABLE cart_" + login_num + 
						" ADD FOREIGN KEY (Barcode) REFERENCES inventory(Barcode)";
				stmt.executeUpdate(query);
				query = "CREATE VIEW vcart_" + login_num + " AS " + 
						"(SELECT a.Barcode, a.Product_Name, a.Company_Name, a.Price_perPiece_Rs, b.Quantity FROM inventory a, cart_" + login_num + " b WHERE a.Barcode = b.Barcode)";
				stmt.executeUpdate(query);
			}
			query = "TRUNCATE TABLE cart_" + login_num + "";
			stmt.executeUpdate(query);
			stmt.close();
			conn.close();
			HttpSession session1 = request.getSession();
			//This method binds an object to this session, using the name specified.
			session1.setAttribute("user_num", ""+login_num+"");
			
	%>
	
	<jsp:forward page="home.jsp"/>
	
	<%
		}
		catch(Exception e)
		{
			//in case of any exception
			out.println("Problem encountered.<br> You cannot proceed further.<br>");
			e.printStackTrace();
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
