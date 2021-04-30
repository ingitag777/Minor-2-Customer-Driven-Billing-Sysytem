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

		<title>Inventory</title>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
			//eliminating backtracking
			window.history.forward();
			function noBack() { window.history.forward(); }
		</script>
	
	</head>
	
	<h1 style="text-align:center">Update Item</h1>
	<form action="update1.jsp" method="post">
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
				ResultSet rs=stmt.executeQuery(query);
				int i=0;
				while(rs.next())
				{
					i++;
		%>
		
		    <tr>
		    	<td><input type="radio" name="update" value="<%=rs.getString("Barcode")%>"><label for="rem"><%=rs.getString("Barcode")%></label></td>
		    	<td><%=rs.getString("Product_Name")%></td>
		    	<td><%=rs.getInt("Quantity")%></td>
		    	<td><%=rs.getInt("Price_perPiece_Rs")%></td>
		    	<td><%=rs.getString("Company_Name")%></td>
		    </tr>
		    
		<%
				}
		%>
		
		</table><br>
		
	    <%
			    stmt.close();
			    conn.close();
	    	}
			catch(Exception e)
			{
			    e.printStackTrace();
		    }
		%>
		
		<p class="text">Quantity : <input class="input-bar" type="text" name="quantity" required><br>
		<input class="submit-button" type="submit" value="Update!">
	</form>
	
	<body class="body-all" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	</body>
</html>