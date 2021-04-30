<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> <%--import database package --%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">

		<title>Bill</title>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
			//eliminating backtracking
			window.history.forward();
			function noBack() { window.history.forward(); }
			//redirection to login page 
			function Redirect() {
	            window.location = "index.html";
	         }
		</script>
	
	</head>
	<h1 style="text-align:left">BILL</h1><br>
	<form method="post">
		<%
			try
			{
				
				Class.forName("com.mysql.jdbc.Driver");
				String url="jdbc:mysql://localhost:3306/c_d_b_s";
				String username="root";
				String password="root";
				
				HttpSession session1 = request.getSession();
				String user_num = (String)session1.getAttribute("user_num");
				
				String query = "SELECT * FROM bill_register";
				int bill_no = 1;
				
				Connection conn=DriverManager.getConnection(url,username,password);
				Statement stmt=conn.createStatement();
				ResultSet result= stmt.executeQuery(query);
				if(result.next())
				{
					result.last();
					bill_no += result.getInt("Bill_Number");
				}
				result.close();
				
				query = "SELECT a.Barcode, a.Quantity - b.Quantity AS Quantity FROM inventory a, cart_" + user_num + " b WHERE a.Barcode = b.Barcode";
				result = stmt.executeQuery(query);
				Statement stmt1 = conn.createStatement();
				while(result.next())
				{
					query = "UPDATE inventory SET Quantity = " + result.getInt("Quantity") + " WHERE Barcode = '" + result.getString("Barcode") + "'";
					stmt1.executeUpdate(query);
				}
				stmt1.close();
				stmt.close();
		%>
		
		<p class="text">Bill No. : <%=bill_no%><br>
		<table border="2">
			<tr>
				<th>S No.</th>
				<th>Product Name</th>
				<th>Quantity</th>
				<th>Price(in Rs)</th>
			</tr>
		
		<%
				query = "CREATE TABLE IF NOT EXISTS bill_" + bill_no + "(" +
						"Barcode varchar(14) NOT NULL," +
						"Product_Name varchar(30) NOT NULL," +
						"Quantity decimal(5,0) unsigned NOT NULL," +
						"Price_Rs decimal(4,0) unsigned NOT NULL," +
						"PRIMARY KEY (Barcode)" +
						")";
				stmt = conn.createStatement();
				stmt.executeUpdate(query);
				query = "ALTER TABLE bill_" + bill_no + 
						" ADD FOREIGN KEY (Barcode) REFERENCES inventory(Barcode)";
				stmt.executeUpdate(query);
				query = "INSERT INTO bill_" + bill_no + " SELECT Barcode, Product_Name, Quantity, Quantity*Price_perPiece_Rs FROM vcart_" + user_num + "";
				stmt.executeUpdate(query);
				stmt.close();
				stmt = conn.createStatement();
				query = "SELECT SUM(Price_Rs) FROM bill_" + bill_no + "";
				result = stmt.executeQuery(query);
				result.next();
				query = "INSERT INTO bill_register(User, Total_Amount) Values(" + user_num + "," + result.getLong("SUM(Price_Rs)") + ")";
				stmt.close();
				stmt = conn.createStatement();
				stmt.executeUpdate(query);
				stmt.close();
				query = "SELECT * FROM bill_" + bill_no + "";
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				for(int i=1; rs.next(); i++)
				{
		
		%>
		    <tr>
		    	<td><%=i%></td>
		    	<td><%=rs.getString("Product_Name")%></td>
		    	<td><%=rs.getInt("Quantity")%></td>
		    	<td><%=rs.getInt("Price_Rs")%></td>
		    </tr>
		<%
				}
				rs.close();
				query = "SELECT Total_Amount FROM bill_register where Bill_Number = " + bill_no + "";
				result = stmt.executeQuery(query);
				result.next();
		%>
		</table><br>	
	</form>
	
	<form method="post">	
		<p class="text">Payable Amount : <input class="input-bar" type="text" name="amount" value="<%=result.getLong("Total_Amount")%>" readonly><br>
	</form><br>
	<form action="index.html" method="post">	
			<p class="text"><input class="submit-button" type="submit" value="Checkout">
	</form>
		
		<%
				result.close();
			    stmt.close();
			    conn.close();
		 	}
			catch(Exception e)
			{
				//in case of any exception
				out.println("Problem encountered.<br> You cannot proceed further.<br>");
				e.printStackTrace();
		    }
		%>
	
	<body class="body-all" id="withdraw-body" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">	
	</body>
		
</html>