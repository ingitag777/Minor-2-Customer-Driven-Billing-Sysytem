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

		<title>Cart</title>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
			//eliminating backtracking
			window.history.forward();
			function noBack() { window.history.forward(); }
		</script>
	
	</head>
	<h1 style="text-align:left">Items in Cart</h1><br>
	<form method="post">
		<table border="2">
			<tr>
				<th>S No.</th>
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
				HttpSession session1 = request.getSession();
				String user_num = (String)session1.getAttribute("user_num");
				String query = "SELECT * FROM vcart_" + user_num + "";
				Connection conn=DriverManager.getConnection(url,username,password);
				Statement stmt=conn.createStatement();
				ResultSet rs=stmt.executeQuery(query);
				for(int i=1; rs.next(); i++)
				{
		
		%>
		    <tr>
		    	<td><%=i%></td>
		    	<td><%=rs.getString("Barcode")%></td>
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
				//in case of any exception
				out.println("Problem encountered.<br> You cannot proceed further.<br>");
				e.printStackTrace();
		    }
		%>
	
	</form>
	
	<form action="home1.jsp" method="post">	
		<p class="text">Barcode : <input class="input-bar" type="text" name="brcde" maxlength=14 required><br>
		<p class="text">Quantity : <input class="input-bar" type="text" name="qty" value="1" required><br>
		<p class="text"><input class="submit-button" type="submit" value="Add Item to Cart">
	</form>
	
	<form action="home2.jsp" method="post">
		<p class="text"><input class="submit-button" type="submit" value="Scan Item"><br>
	</form>
	
	<form action="bill.jsp" method="post">
		<p class="text"><input class="bill-button" type="submit" value="Generate Bill">
	</form>
	
	<body class="body-all" id="withdraw-body" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">	
	</body>
		
</html>