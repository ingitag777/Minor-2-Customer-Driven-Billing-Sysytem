<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> <%--import database package --%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">

		<title>Inventory</title>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
			//eliminating backtracking
			window.history.forward();
			function noBack() { window.history.forward(); }
		</script>
	
	</head>
	
	<h1 style="text-align:left">INVENTORY</h1>
	<form method="post">
		<table border="2">
			<tr>
				<th>Barcode</th>
				<th>Product Name</th>
				<th>Quantity</th>
				<th>Price(in Rs)</th>
				<th>Company</th>
			</tr>
		<%
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				String url="jdbc:mysql://localhost:3306/c_d_b_s";
				String username="root";
				String password="root";
				String query="SELECT * FROM inventory";
				Connection conn=DriverManager.getConnection(url,username,password);
				Statement stmt=conn.createStatement();
				ResultSet res=stmt.executeQuery(query);
				while(res.next())
				{		
		%>
		    <tr>
		    	<td><%=res.getString("Barcode")%></td>
		    	<td><%=res.getString("Product_Name")%></td>
		    	<td><%=res.getInt("Quantity")%></td>
		    	<td><%=res.getInt("Price_perPiece_Rs")%></td>
		    	<td><%=res.getString("Company_Name")%></td>
		    </tr>
		<%
				}
		%>
		</table>
		<br>
		<%
			    res.close();
			    stmt.close();
			    conn.close();
		    }
			catch(Exception e)
			{
			    e.printStackTrace();
		    }
		%>
	</form>
	
	<body class="body-all" >
		<br>		
		<form action="add.html">
			<input class="home-button" type="submit" value="Add">
		</form>
		
		<form action="remove.jsp">
			<input class="home-button" type="submit" value="Remove">
		</form>
		
		<form action="update.jsp">
			<input class="home-button" type="submit" value="Update">
		</form>
		
		<form action="index.html" method="post" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">	
			<p class="text"><input class="bill-button" type="submit" value="Log Out">
		</form>
		
	</body>
</html>