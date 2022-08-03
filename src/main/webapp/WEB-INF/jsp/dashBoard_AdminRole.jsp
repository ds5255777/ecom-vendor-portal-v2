<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Dashboard</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <style>
    tbody {
	font-size: 12.9px;
	}
	
	.table td, .table th {
		padding: 5px;
		vertical-align: top;
		border-top: 1px solid #dee2e6;
	}
    
    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Admin Dashboard" />

        <jsp:include page="sidebar_Admin.jsp?pagename=dashboard" />
            
			<div class="content-wrapper">
						<div class="content-header" style="padding: 0px;">
							<div class="container-fluid">
								<div class="row mb-2">
									<div class="col-sm-6">
									 <input type="hidden" id =uname  value="${uname}" />
									</div>
									<div class="col-sm-6"></div>
								</div>
							</div>
						</div>

            <section class="content">
                <div class="container-fluid">
                    <div class="row">
							
							<div class="col-lg-6 col-6">
                            <div class="small-box bg-white">
                                <div class="inner" style="height: 200px;">
                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom" >
                                      <a style="font-size: 30px;"> Total No of Users : </a><b style="font-size: 30px;">${getAllUserCount}</b></p>
                                       
                                       <p id="allActive" data-toggle="tooltip" data-placement="bottom"  style="font-size: 20px;">
                                       Active Users : <b>${totalActiveUser}</b></p>
                                       
                                       <p id="allInactive" data-toggle="tooltip" data-placement="bottom"  style="font-size: 20px;">
                                        In-Active Users : <b>${totalInActiveUser}</b></p>
                                </div>
                                <div class="icon">
                                <i class="fa fa-user" style="color: #FAA654;font-size: 150px; aria-hidden="true" ></i>
                                </div>
                                <a href="addUsers" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

						<div class="col-lg-6 col-6">
                            <!-- small box -->
                            <div class="small-box bg-white" >
                                <div class="inner" style="height: 200px;">
                                  

                                    <p id="vendors" data-toggle="tooltip" data-placement="bottom" >
                                       <a style="font-size: 30px;">Total No of Vendors : </a><b style="font-size: 30px;">${getAllVendorCount}</b></p>
                                       
                                     <p id="Actvendors" data-toggle="tooltip" data-placement="bottom"  style="font-size: 20px;">
                                       Active Vendors : <b>${allActiveVendorCount}</b></p>
                                
                                 	<p id="inactVendor" data-toggle="tooltip" data-placement="bottom"  style="font-size: 20px;">
                                       In-Active Vendors : <b>${allInActiveVendorCount}</b></p>
                                
                                       
                                </div>
                                <div class="icon">
                                    <!-- <i class="fas fa-file-invoice-dollar" style="color: #1F8BFF; font-size: 50px;"></i> -->
                                    <i class="fa fa-user-circle" aria-hidden="true" style="color: #1F8BFF;font-size: 160px; "></i>
                                </div>
                                <a href="vendorDetails" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
							

                        <!-- ./col -->
                    </div>
                    <!-- /.row -->
                    <!-- Main row -->

                    <!-- /.row (main row) -->
                </div>
                <!-- /.container-fluid -->
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-8">

                            <div class="card card-primary  card-outline ">
                                <div class="card-header">
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom" title="Top 15 Users">Top 15
                                        Users</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>
                                               
                                                    <th class="bg-primary" >User Name</th>
                                                     <th class="bg-primary" >First Name</th>
                                                     <th class="bg-primary" >Last Name</th>
                                                     <th class="bg-primary" >Role</th>
                                                     <th class="bg-primary" >Email</th>
													 <th class="bg-primary" >Contact No</th>
                                                     <!-- <th class="bg-primary" >Action</th> -->
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        </div>
                        <div class="col-md-4">
                            <!-- DONUT CHART -->
                            <div class="card card-primary  card-outline ">
                                <div class="card-body">
                                    <p><strong>User By Status</strong></p>
                                    <canvas id="unresolvedsts" style="min-height: 385px;  max-height: 377px; max-width: 100%;display: block;width: 401px;height: 459px;"></canvas>
                                </div>
                                <!-- /.card-body -->
                            </div>
                           
                        </div>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
        </aside>
        <!-- /.control-sidebar -->
    </div>
   
        <form role="form" id="changePassword1" autocomplete="off">
        <div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Change Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1">New Password</label>
                            <input type="hidden" id="passflag">
                            <input type="password" class="form-control p-input" id="password" name="password" placeholder="New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Confirm Password </label>
                            <input type="password" class="form-control p-input" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password" >
                        </div>
                        <div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="changePasswordButton" class="btn btn-primary" onclick="changePassword(document.getElementById('passwordConfirm').value)" disabled>Change Password</button>
                    </div>
                </div>
            </div>
        </div>
        </form>

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button);
        $.widget.bridge('uitooltip', $.ui.tooltip);

    </script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- ChartJS -->
    <script src="plugins/chart.js/Chart.min.js"></script>
    <!-- Sparkline -->
    <script src="plugins/sparklines/sparkline.js"></script>
    <!-- JQVMap -->
    <script src="plugins/jqvmap/jquery.vmap.min.js"></script>
    <script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
    <!-- daterangepicker -->
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->
    <!-- <script src="plugins/summernote/summernote-bs4.min.js"></script> -->
    <!-- overlayScrollbars -->
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
   <!--  <script src="dist/js/pages/dashboard.js"></script> -->
    <!-- AdminLTE for demo purposes -->
    <!-- <script src="dist/js/demo.js"></script> -->
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="dist/js/chart2.js"></script>
	<script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
	<script src="plugins/toastr/toastr.min.js"></script>
	<script src="plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="plugins/jquery-validation/additional-methods.min.js"></script>
		<script>
            $(document).ready(function () {
                //console.log(${userStatus});
                if (${userStatus} === 3) {
                    $('#changePassword').modal('show');
                }
            });
            
            
            $('#changePassword1').validate({
                rules: {
                	password: {
                        required: true
                    },
                    passwordConfirm: {
                        required: true
                    }
                },
	             errorElement: 'span',
	            errorPlacement: function(error, element) {
	                error.addClass('invalid-feedback');
	                element.closest('.form-group').append(error);
	            },
	            highlight: function(element, errorClass, validClass) {
	                $(element).addClass('is-invalid');
	                document.getElementById("passflag").value ="1";
	                
	            },
	            unhighlight: function(element, errorClass, validClass) {
	                $(element).removeClass('is-invalid');
	                document.getElementById("passflag").value ="0";
	            } 
       		 });
             
           /*  $(function() {
                $("#passwordConfirm").keyup(function() {
                    var password = $("#password").val();
                    if ($('#password').val() == $('#passwordConfirm').val()) {
            		    $('#divCheckPasswordMatch').html('Passwords match.').css('color', 'green');
            		    // Enable #x
            		    //$('#changePasswordButton').attr('disabled', false);
            		    
            		  } else 
            		    $('#divCheckPasswordMatch').html('Passwords do not match!').css('color', 'red');
                 // Disable #x
        		    $('#changePasswordButton').attr('disabled', true);
                    return;
                    
                  //  $("#divCheckPasswordMatch").html(password == $(this).val() ? "Passwords match." : "Passwords do not match!");
                });

            });  */
            
            $(function() {
                $("#passwordConfirm").keyup(function() {
                    var password = $("#password").val();
                    var passwordConfirm = $("#passwordConfirm").val();
                    var passflag = $("#passflag").val();
                    
                   
                     if ($('#password').val() == $('#passwordConfirm').val() && passflag!="1" ) {
            		    $('#divCheckPasswordMatch').html('Passwords match.').css('color', 'green');
            		    // Enable #x	
            		    $("#changePasswordButton").prop("disabled", false)
            		    
            		  } 
                     else {
            		    $('#divCheckPasswordMatch').html('Passwords do not match!').css('color', 'red');
                 // Disable #x
        		    $('#changePasswordButton').attr('disabled', true);
                    return;
            		  }
                  //  $("#divCheckPasswordMatch").html(password == $(this).val() ? "Passwords match." : "Passwords do not match!");
                });
            }); 
            
            const Toast = Swal.mixin({
    			toast : true,
    			position : 'top-end',
    			showConfirmButton : false,
    			timer : 3000
    		});
        </script>

    <script type="text/javascript">
        $(document).ready(function() {
            var bootstrapTooltip = $.fn.tooltip.noConflict();
            $.fn.bstooltip = bootstrapTooltip;
            $('#quickHelp').bstooltip();
            $('#oveTickets').bstooltip();
            $('#invdue').bstooltip();
            $('#opeTickets').bstooltip();
            $('#UnTickets').bstooltip();
            $('#iamwatch').bstooltip();
            $('#perTicket').bstooltip();
            $('#allActive').bstooltip();
            
            $('#allInactive').bstooltip();
            $('#noofinvoice').bstooltip();
            $('#proinvoice').bstooltip();
            $('#appinvoice').bstooltip();
            $('#vendors').bstooltip();
            $('#Actvendors').bstooltip();
            $('#inactVendor').bstooltip();
           
            
            
        })

    </script>




    <!-- table Data -->
    <script>
        var tabledata = $('#tabledata').DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": []
        });

        var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
        var unresolvedstsData = {
            labels: [
                'Active',
                'In-Active',
                
            ],//#FF0000(red),00a65a(inactive)
            datasets: [{
                data: [${totalActiveUser}, ${totalInActiveUser}],
                backgroundColor: ['#00a65a', '#FF0000'],
            }]
        }
        var unresolvedstsOptions = {
            maintainAspectRatio: false,
            responsive: true,
        }
        var unresolvedstsOptionsChart = new Chart(unresolvedsts, {
            type: 'doughnut',
            data: unresolvedstsData,
            options: unresolvedstsOptions
        })

        getDashBoardInformation();

        function getDashBoardInformation() {

            var id = "";
            var obj = {
                "id": id
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getActiveUsersData%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                	 if (data.msg == 'success') {

                         var lastName = "";
                         var result = data.data;
                         tabledata.clear();

                         for (var i = 0; i < result.length; i++) {

                             lastName = "";
                             if(!result[i].hasOwnProperty("username")){
    								result[i].username="";
    							}
                               if(!result[i].hasOwnProperty("firstName")){
         							result[i].firstName="";
         						}
								if(!result[i].hasOwnProperty("lastName")){
    								result[i].lastName="";
    							}
                                if(!result[i].hasOwnProperty("emailId")){
    								result[i].emailId="";
    							}
                                if(!result[i].hasOwnProperty("contactNo")){
     								result[i].contactNo="";
     							}
                                if(!result[i].hasOwnProperty("status")){
    								result[i].status="";
    							}
                                if(!result[i].hasOwnProperty("id")){
     								result[i].id="";
     							}if (result[i].hasOwnProperty("lastName")) {
                                    lastName = result[i].lastName;
                                }

                             tabledata.row.add([result[i].username, result[i].firstName, lastName, result[i].rolesObj.roleName, result[i].emailId, result[i].contactNo]);
				
                             let introByEmail="";
                             var uname = $("#uname").val();
                        	 if (uname === result[i].username) {
                        		 introByEmail=result[i].emailId
                        		//for introByEmail in Vendor Registrastion page
                        		 
                        	 }
                         }

                         tabledata.draw();
                         $("tbody").show();

                     } else {
                    	Toast.fire({
                            type: 'error',
                            title: 'Failed..not Load Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    alert("failed, please try again letter");
                }
            });
        }
        
        function changePassword(password){
        	console.log(document.getElementById('password').value);
        	console.log("my password "+"<%=GlobalUrl.changePassword%>"+"?password="+password);
        	
        	
        	$.ajax({
                 type: "POST",
                 data: "",
                 url: "<%=GlobalUrl.changePassword%>"+"?password="+password,
                 dataType: "json",
                 contentType: "application/json",
                 async: false,
                 
                 success: function(data) {
                	 $('.loader').hide();
                     $("#changePassword").modal('hide');
                     if (data.msg == "success") {
                         Swal.fire({
                             type: 'success',
                             title: 'Password Updated Successfully..'
                         })
                        
                     } else {
                    	 Swal.fire({
                             type: 'error',
                             title: 'Try Again...'
                         })
                     }
                 },
                 error: function(jqXHR, textStatue, errorThrown) {
                     alert("failed, please try again letter");
                 }
             });

        }

    </script>
    <!-- table Data -->



</body>

</html>
