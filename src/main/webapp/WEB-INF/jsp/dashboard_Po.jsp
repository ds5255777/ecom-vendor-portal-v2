<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

        .table td,
        .table th {
            padding: 5px;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <div class="wrapper">

        <%
        String vendorType=(String)request.getAttribute("vendorType");
        
        String[] strArray =   null;
        		
      strArray = vendorType.split(",");  
       
      for (int i = 0; i< strArray.length; i++){  
      
      }  
     		  if(strArray.length ==1  ){
      	    	 System.out.println("vendor type1 : "+strArray); 
      	    	 %>

        <jsp:include page="navbar.jsp?pagename=PO Dashboard" />

        <% 
         		  	 	
      	    	 }
         	
     	   		else if(strArray.length==2){
         	    	 System.out.println("vendor type 2: "+strArray); 
         	    	 %>

        <jsp:include page="navbar_po.jsp?pagename= PO Dashboard" />

        <% 
            		  	 
         	     } 
     	   
      %>

        <jsp:include page="slidebar_Po.jsp?pagename=dashboard_PO" />


        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6"></div>
                    </div>
                </div>
            </div>
            <section class="content">
                <div class="container-fluid">
                    <div class="row">

                        <div class="col-lg-2 col-6">
                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${allPOcount}</h2>

                                    <p id="iamwatch" data-toggle="tooltip" data-placement="bottom">All PO</p>
                                </div>
                                <div class="icon">

                                    <i class="nav-icon fas fa-list" style="color: #FAA654; font-size:50px;"></i>
                                </div>
                                <a href="allPO" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>



                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalUnprocessPOCount}</h2>

                                    <p id="iamwatch" data-toggle="tooltip" data-placement="bottom">Unprocessed PO</p>
                                </div>
                                <div class="icon">

                                    <i class="fa fa-tasks" style="color: chocolate; font-size: 50px;"></i>
                                </div>
                                <a href="unprocessPO" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalProcessPoCount}</h2>

                                    <p id="UnTickets" data-toggle="tooltip" data-placement="bottom">Processed PO</p>
                                </div>
                                <div class="icon">

                                    <i class="fas fa fa-check" style="color: #28a745; font-size: 50px;"></i>
                                </div>
                                <a href="processPO" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>





                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalInvoiceCount}</h2>



                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom">All Invoice</p>
                                </div>
                                <div class="icon">

                                    <i class="fas fas fa-rupee-sign" style="color: #1F8BFF; font-size: 50px;"></i>
                                </div>
                                <a href="poInvoiceDetails" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalDraftInvoiceCount}</h2>

                                    <p id="invdue" data-toggle="tooltip" data-placement="bottom">Draft Invoice</p>
                                </div>
                                <div class="icon">

                                    <i class="nav-icon fab fa-firstdraft" style="color: #dc3545; font-size: 55px;"></i>
                                </div>
                                <a href="draftPO" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-2 col-6">

                            <div class="small-box bg-white">
                                <div class="inner">
                                    <h2>${totalQueryCount}</h2>

                                    <p id="allInactive" data-toggle="tooltip" data-placement="bottom">Query Invoice</p>
                                </div>
                                <div class="icon">

                                    <i class="fas fa-question" style="color: #fd7e14; font-size: 50px;"></i>
                                </div>
                                <a href="QueryPo" class="small-box-footer" style="background: #007bffe0; color: white !important;">More
                                    info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>


                    </div>


                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-8">

                            <div class="card card-primary  card-outline ">
                                <div class="card-header">
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom" title="Top 15 Users"><strong>Top 50
                                            Unprocessed PO</strong></h3>
                                </div>
                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">PO Number</th>
                                                <th class="bg-primary">Type</th>
                                                <th class="bg-primary">UOM</th>
                                                <th class="bg-primary">Quantity</th>
                                                <th class="bg-primary">Need By Date</th>
                                                <th class="bg-primary">Amount</th>

                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card card-primary  card-outline ">
                                <div class="card-body">
                                    <p>
                                        <strong>PO Status</strong>
                                    </p>
                                    <canvas id="unresolvedsts" style="min-height: 385px; max-height: 377px; max-width: 100%; display: block; width: 401px; height: 459px;"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>

    <form role="form" id="changePassword1" autocomplete="off">
        <div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Change
                            Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1">New Password</label> <input type="hidden" id="passflag"> <input type="password" class="form-control p-input" id="password" name="password" placeholder="New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Confirm Password </label> <input type="password" class="form-control p-input" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password">
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

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/chart.js/Chart.min.js"></script>
    <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <script src="dist/js/adminlte.js"></script>
    <script src="dist/js/demo.js"></script>
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="dist/js/chart2.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
    <script src="plugins/toastr/toastr.min.js"></script>
    <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
    <script src="plugins/jquery-validation/additional-methods.min.js"></script>

    <script src="js/dashboard_Po.js"></script>

</body>

</html>
