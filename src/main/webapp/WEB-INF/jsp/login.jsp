<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Ecom Vendor | Log in</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="dist/css/login/style.css">
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>

<body>

    <div class="splitLeft left">
        <!--<div class="centered">-->
        <img src="dist/img/vendorPortal.jpg" alt="Vendor Portal Logo" class="center brand-image" style="width: 80%;">
        <center>
            <h2 style="color: white;">Vendor Portal</h2>
            <br>
            <p style="color: white;">vendor portal is an internet-based
                system used to manage and connect with third party suppliers of
                goods or/and services. It is a secured management system adopted by
                organizations that network with multiple suppliers. This portal
                permits initial registration of suppliers as well as account
                management.</p>
        </center>
    </div>

    <div class="splitRight right">
        <img src="dist/img/ecom.png" alt="Ecom Logo" class="center" style="padding-top: 60px;">
        <center>
            <h5 style="margin: 10px; font-weight: 600; color: #467394;">————Vendor
                Portal————</h5>
            <h4 style="margin: 20px;">Sign in with your account</h4>
        </center>
        <form class="login-form" method="POST" action="${contextPath}/login">
            <div class=" form-group ${error != null ? 'has-error' : ''} ${message != null ? 'has-error' : ''}">
                <div><span style="color:red">${error} ${message}</span></div>
                <!-- <div class=" form-group  ">
				<div>
					<span style="color: red"> </span>
				</div> -->
                <label for="username" style="font-weight: bolder;">User ID</label> <input class="form-control" id="username" name="username" type="text" data-role="tagsinput" placeholder="User Id"><br> <label for="password" style="font-weight: bolder;">Password</label> <input class="form-control" id="password" name="password" type="password" placeholder="Password"><br> <input type="hidden" name="" value="" />
                <button type="submit" class="btn btn-primary">Login</button>
                <button type="button" class="btn btn-secondary" onclick="openRegister()">Register</button>
            </div>
        </form>
    </div>
    <script>
        function openRegister() {
            location.href = "registration";
        }

    </script>

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>

</body>

</html>
