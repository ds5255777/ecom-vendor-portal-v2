<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Ecom Vendor | Log in</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="dist/css/login/style.css">
    <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

</head>

<body>

    <div class="splitLeft left">
        <img src="dist/img/vendorPortal.jpg" alt="Vendor Portal Logo" class="center brand-image" style="width: 70%;">
        <div style="text-align: center;">
            <h2 style="color: white;">Vendor Portal</h2>
            <br> <br>
            <p style="color: white;">Vendor portal is an internet-based
                system used to manage and connect with third party suppliers of
                goods or/and services. It is a secured management system adopted by
                organizations that network with multiple suppliers. This portal
                permits initial registration of suppliers as well as account
                management.</p>
            <br>
            <p style="color: white;">
                <b>Powered By BPAAS Solutions Pvt. LTD.</b>
            </p>
        </div>
    </div>

    <div class="splitRight right">
        <img src="dist/img/logoECOM.png" alt="Ecom Logo" class="center" style="padding-top: 40px;">
        <div style="text-align: center;">
            <h5 style="margin: 5px; font-weight: 600; color: #467394;">————Vendor
                Portal————</h5>
            <h4 style="margin: 15px;">Sign in with your account</h4>
        </div>
        <form id="target" class="login-form" method="POST" action="${contextPath}/login" autocomplete="off">
            <div class=" form-group ${error != null ? 'has-error' : ''} ${message != null ? 'has-error' : ''}">
                <div>
                    <span style="color: red">${error} ${message}</span>
                    <p id="demo"></p>
                </div>
                <label for="username" style="font-weight: bolder;">User ID</label> <input class="form-control" id="username" name="username" type="text" data-role="tagsinput" placeholder="User Id" required><br>
                <label for="password" style="font-weight: bolder;">Password</label>
                <input class="form-control" id="password" name="password" type="password" placeholder="Password" required><br> <input type="hidden" name="" value="" />

                <div class="row">

                    <div class="col-sm-3">
                        <div id="captcha2" style="display: block; width: 50%; float: left;">
                            <canvas id="captcha2" width="120" height="50"></canvas>
                        </div>
                    </div>

                    <div class="col-sm-3">
                        <div style="display: block; width: 50%; float: left;">
                            <input type="text" class="form-control p-input" autocomplete="off" id="captchaInput" style="width: 120px; height: 41px;">
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-primary btn-xs" style="height: fit-content;cursor: pointer;" onclick="createCaptcha2()">
                            <i class="fa fa-refresh"></i>
                        </button>
                    </div>
                </div>


                <br>
                <button type="button" id="click" class="btn " value="Login" style="color: white; background-color: #204572;height: fit-content;cursor: pointer;" onclick="validateOnsubit();">Login</button>
            </div>
        </form>
    </div>
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="js/login.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script type="text/javascript">
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });

    </script>
</body>

</html>
