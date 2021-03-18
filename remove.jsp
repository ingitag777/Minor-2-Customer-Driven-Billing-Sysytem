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
	
	<h1 style="text-align:center">Remove Item</h1>
	
	<form action="remove1.jsp" method="post">

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
	    	<td><input type="checkbox" name="rem" value="<%=rs.getString("Barcode")%>"><label for="rem"><%=rs.getString("Barcode")%></label></td>
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
	<br><input class="submit-button" type="submit" value="Remove!">

	</form>
	<body class="body-all" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	
	</body>
</html>