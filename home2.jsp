<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%> <%--import database package --%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.pqscan.barcodereader.BarcodeResult" %>
<%@ page import="com.pqscan.barcodereader.BarcodeScanner" %>
<%@ page import="com.pqscan.barcodereader.BarCodeType" %>
<!DOCTYPE html>
<htm>
	
	<%
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/c_d_b_s";
			String username="root";
			String password="root";
			
			HttpSession session1 = request.getSession();
			String user_num = (String)session1.getAttribute("user_num");
			
			BarcodeResult[] results = BarcodeScanner.Scan("C:\\Users\\500069156\\Documents\\Minors\\Minor 2\\sample_barcode.jpeg", BarCodeType.Code128);
			if(results.length != 1)
		    {
		        throw new Exception("Scanning Interrupted!");
		    }
			String barcode = results[0].getData();
			
			int quantity = 1;
			String query = "SELECT Quantity FROM cart_" + user_num + " WHERE Barcode = '" + barcode + "'";
			Connection conn=DriverManager.getConnection(url,username,password);
			Statement stmt = conn.createStatement();
			ResultSet result = stmt.executeQuery(query);
			if(result.next())
			{
				quantity += result.getInt("Quantity");
				query = "Update cart_" + user_num + " SET Quantity = " + quantity + " WHERE Barcode = '" + barcode + "'";
			}	
			else	query = "INSERT INTO cart_" + user_num + " VALUES ('" + barcode + "'," + quantity + ")";
			result.close();
			String query1 = "SELECT a.Barcode, IF(b.Quantity > " + quantity + ", \"Suffecient\", \"Excess\") FROM cart_" + user_num + " a, inventory b WHERE a.Barcode = b.Barcode";
			result = stmt.executeQuery(query1);
			boolean flag = false;
			Statement stmt1 = conn.createStatement();
			while(result.next())
			{
				if(result.getString(2).equals("Excess"))
				{
					flag = true;
					query1 = "DELETE FROM cart_" + user_num + " WHERE Barcode = '" + result.getString(1) + "'";
					stmt1.executeUpdate(query1);
					
				}
			}
			result.close();
			stmt1.close();
			stmt.close();
			if(flag)
				conn.close();
			else
			{
				stmt = conn.createStatement();
				stmt.executeUpdate(query);
		    	stmt.close();
		    	conn.close();
	%>
			<jsp:forward page="home.jsp"/>
	<%
			}
	 	}
		catch(Exception e)
		{
			//in case of any exception
			out.println("Problem encountered.<br> You cannot proceed further.<br>");
			e.printStackTrace();
	    }
	%>
	<head>
		<meta charset="ISO-8859-1">
	
		<title>Cart</title>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
	        //redirection to login page 
			function Redirect() {
	            window.location = "home.jsp";
	         }            
	         document.write("<b>Entered value of Item exceeded Current Stock Limit.</b><br> You will be redirected to Cart in 3 sec.");
	         setTimeout('Redirect()', 3000);
			 
	         //eliminating backtracking
	         window.history.forward();
			function noBack() { window.history.forward(); }
		</script>
	
	</head>
	<body class="body-all" id="withdraw-body" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	</body>
	
</html>