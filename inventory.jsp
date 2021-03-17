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
	<h1 style="text-align:center">INVENTORY</h1>
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
	String query="SELECT * FROM inventory";
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
	<body class="body-all" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
				
		<form action="add.html">
			<input class="home-button" type="submit" value="Add">
		</form>
		
		<form action="remove.jsp">
			<input class="home-button" type="submit" value="Remove">
		</form>
		
		<form action="update.jsp">
			<input class="home-button" type="submit" value="Update">
		</form>
		
	</body>
</html>
