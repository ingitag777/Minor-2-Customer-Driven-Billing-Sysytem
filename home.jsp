<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	
		<link rel="stylesheet" href="style.css">
		
		<script type="text/javascript">
	        //redirection to login page 
			function Redirect() {
	            window.location = "adminlogin.html";
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