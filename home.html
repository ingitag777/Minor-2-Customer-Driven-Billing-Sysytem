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
	<h1 style="text-align:center">Selected Item</h1>
	<form method="post">

	<table border="2">
	<tr>
	<td>Barcode</td>
	<td>Product Name</td>
	<td>Quantity</td>
	<td>Price(in Rs)</td>
	<td>Company</td>
	</tr>
	<%
	try
	{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/c_d_b_s";
	String username="root";
	String password="root";
	String barcode = request.getParameter("brcde");
	String query = "SELECT * FROM inventory WHERE Barcode = '" + barcode + "'";
	Connection conn=DriverManager.getConnection(url,username,password);
	Statement stmt=conn.createStatement();
	ResultSet rs=stmt.executeQuery(query);
	while(rs.next())
	{
	
	%>
	    <tr>
	    	<td><%=rs.getString("Barcode")%></td>
	    	<td><%=rs.getString("Product_Name")%></td>
	    	<td><%=rs.getInt("Quantity")%></td>
	    	<td><%=rs.getInt("Price(Rs)")%></td>
	    	<td><%=rs.getString("Company_Name")%></td>
	    </tr>
	<%
	
	}
	%>
	</table>
	<%
	    rs.close();
	    stmt.close();
	    conn.close();
	    }
	catch(Exception e)
	{
	    e.printStackTrace();
	    }
	
	
	
	
	%>

	</form>
	
	<body class="body-all" id="withdraw-body" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	</body>
	
</html>
