<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|All PO</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery-ui.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">

    <!-- <script>
        var statusObject = {
            "In-Transit": {
                "Yet To Be Approved": ["NA"],
                "Query": ["NA"],
            },
            "Closed": {
                "Yet To Be Approved": ["NA"],
                "Approved": ["Pending"],
                "Draft-Invoicing": ["Pending"],
                "Invoicing": ["Pending", "Approved"],
            }
        }
        window.onload = function() {
            var tripStatus = document.getElementById("selectTripStatus");
            var status = document.getElementById("selectStatus");
            var paymentStatus = document.getElementById("selectPaymentStatus");
            for (var x in statusObject) {
                tripStatus.options[tripStatus.options.length] = new Option(x, x);
            }
            tripStatus.onchange = function() {
                //empty Chapters- and Topics- dropdowns
                paymentStatus.length = 1;
                status.length = 1;
                //display correct values
                for (var y in statusObject[this.value]) {
                    status.options[status.options.length] = new Option(y, y);
                }
                GetSelectedTextValue();
            }
            status.onchange = function() {
                //empty Chapters dropdown
                paymentStatus.length = 1;
                //display correct values
                var z = statusObject[tripStatus.value][this.value];
                for (var i = 0; i < z.length; i++) {
                    paymentStatus.options[paymentStatus.options.length] = new Option(z[i], z[i]);
                }
                GetSelectedTextValue();
            }
        }

    </script>
 -->    <style>
        custom-file-input {
            height: 25px;
            font-size: 14px;
        }

        .custom-file {
            height: 25px;
            font-size: 14px;
            padding-bottom: 35px;
            font-size: 14px;
        }

        .custom-file-label::after {
            height: auto !important;
        }

        .custom-file-label {
            padding-bottom: 23px;
            height: 25px;
            font-size: 14px;
        }

        .tableheading {
            font-size: 15px;
            font-weight: bold;
        }

        label {
            font-weight: 500;
            margin-bottom: 1px;
        }

        .form-control {
            height: 25px;
            font-size: 14px;
        }

        tbody {
            font-size: 12.9px;
        }

        .table td,
        .table th {
            vertical-align: top;
            border-top: 1px solid #dee2e6;
            padding: 5px 5px 0px 1.5rem;
        }

        .observedScoreheading {
            width: 60px !important;
        }

        .serialNoheading {
            width: 60px !important;
        }

        .documentheading {
            width: 500px;
        }

        .attachmentheading {
            width: 500px;
        }

        .helpheading {
            width: 60px !important;
        }

        .tooltip.show p {
            text-align: left;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <jsp:include page="loader.jsp" />
    <div class="wrapper">

        <!-- Navbar -->
        <jsp:include page="navbar.jsp?pagename=All PO" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        
			       <jsp:include page="slidebar_Po.jsp?pagename=All PO" /> 
		
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6">
                            <!-- <ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Dashboard v1</li>
						</ol> -->
                        </div>

                    </div>
                </div>
            </div>

            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content mt-2">
                <div class="container-fluid">

                    <div class="row">
                        <!-- <div class="col-md-12"> -->
                        <div class="col-md-12" style="font-size: 14px;">
                            <!-- general form elements -->
                            <div class="card card-primary ">
                                <div class="card-header">
                                     <h3 class="card-title" style="font-size: 15px;">PO
                                            Details</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body ">
                                  
                                    <table class="table table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
												 <th style="padding: 5px 5px 5px 1.5rem;">PO Number</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Type</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">UOM</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Quantity</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Need By Date</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Amount</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Status</th>
                                               
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Control Sidebar -->
            <!-- <aside class="control-sidebar control-sidebar-dark">
			Control sidebar content goes here
		</aside>
		/.control-sidebar -->
        </div>
        <!-- ./wrapper -->








        <!-- Model Start -->
               <!-- model Start -->

        <script src="plugins/jquery/jquery.min.js"></script>
        <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
            $.widget.bridge('uibutton', $.ui.button);
            $.widget.bridge('uitooltip', $.ui.tooltip);

        </script>
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="js/commonFunctions.js"></script>
        <script src="plugins/sparklines/sparkline.js"></script>
        <script src="plugins/moment/moment.min.js"></script>
        <script src="plugins/daterangepicker/daterangepicker.js"></script>
        <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
        <script src="dist/js/adminlte.js"></script>
        <script src="dist/js/demo.js"></script>
        <script src="js/moment.min.js"></script>
        <script src="plugins/select2/js/select2.full.min.js"></script>
        <script src="plugins/jquery-validation/jquery.validate.min.js"></script>
        <script src="plugins/jquery-validation/additional-methods.min.js"></script>
        <script src="plugins/datatables/jquery.dataTables.js"></script>
        <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
        <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
        <script src="plugins/toastr/toastr.min.js"></script>

        <script src="plugins/datatables/jquery.dataTables.js"></script>
        <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
        <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
        <script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
        <script src="plugins/jszip/jszip.min.js"></script>
        <script src="plugins/pdfmake/pdfmake.min.js"></script>
        <script src="plugins/pdfmake/vfs_fonts.js"></script>
        <script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
        <script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
        <script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

        <script type="text/javascript">
        
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });
        
        
        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": true,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });
        
        getData();

        function getData() {

            var jsArray = [];
            $('.loader').show();

            $.ajax({
                type: "POST",
                data: JSON.stringify(jsArray),
                url: "<%=GlobalUrl.getAllPODetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    $('.loader').hide();
                    if (data.msg == 'success') {

                        var result = data.data;
                        tabledata.clear();
                        console.log("result" + result);
                        
                        var poLineDetails = result[0].poLineDetails;
                     
                        for (var i = 0; i < result.length; i++) {
                        	
                        	if(!result[i].hasOwnProperty("id")){
 								result[i].id="";
 							}
                        	if(!result[i].hasOwnProperty("poNo")){
 								result[i].poNo="";
 							}
                             if(!result[i].hasOwnProperty("type")){
 								result[i].type="";
 							}
                              if(!result[i].hasOwnProperty("uom")){
 								result[i].uom="";
 							}
                             if(!result[i].hasOwnProperty("quantity")){
 								result[i].quantity="";
 							}
                             if(!result[i].hasOwnProperty("needByDate")){
  								result[i].needByDate="";
  							} 
                             if(!result[i].hasOwnProperty("amount")){
  								result[i].ammount="";
  							}
                             if(!result[i].hasOwnProperty("status")){
 								result[i].status="";
 							}
                             
							 var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getPoDataFormDataByPoNumber('" +  result[i].poNo + "')\" >" + result[i].poNo + "</button>";
                            var unprocess_status = '<span class=\"right badge badge-warning\">UnProcess</span>';
                            var process_status = '<span class=\"right badge badge-success\">Process</span>';
                             var postatus="";                       
                            var  DraftInvoicing_status='<span class=\"right badge badge-danger\">Draft-Invoicing</span>';
                            var inReview_status = '<span class=\"right badge badge-primary\">In-Review</span>';
                         if (result[i].status == "Process") {
                        	 postatus = process_status;

                              } else if(result[i].status == "Unprocess"){
                            	  postatus = unprocess_status;
                              } else if(result[i].status == "Draft-Invoicing"){
                            	  postatus = DraftInvoicing_status;
                              }  else if(result[i].status == "In-Review"){
                            	  postatus = inReview_status;
                              } 
                         
                            tabledata.row.add([view ,result[i].type,result[i].uom,result[i].quantity,result[i].needByDate,result[i].amount,postatus ]);  				        	
                        
                        }
                        tabledata.draw();
                        $("tbody").show();
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    alert("failed, please try again");
                }
            });
        }

        function getPoDataFormDataByPoNumber(id) {
            $('.loader').show();
            var urlOftripsDetail = "PoView?id=" + id;
            window.open(urlOftripsDetail, "PoView", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
            $('.loader').hide();
        }
        
        $('#fromDate').datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,

        });

        $('#toDate').datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,

        });
        
        $.validator.setDefaults({
            submitHandler: function() {
                getFilterData();

                //alert("insode add");
            }
        });

        $("#refreshDashboardButton").click(function(e) {
            e.preventDefault();
            $('#refreshDashboardButton').attr('disabled', 'disabled');
            getData();
            $('#refreshDashboardButton').removeAttr('disabled');
            $("#fromDate").val("");
            $("#toDate").val("");
        })
        
        
        function getFilterData() {


            var fromDate = $("#fromDate").val();
            var toDate = $("#toDate").val();
           



            if (fromDate == "" || fromDate == null) {
                //alert("plaese select from date"+fromDate);
                Toast.fire({
                    type: 'error',
                    title: 'Please Select Start Date..'
                });
                document.getElementById("fromDate").focus();
                return;
            }

            if (toDate == "" || toDate == null) {
                //alert("plaese select from date"+fromDate);
                Toast.fire({
                    type: 'error',
                    title: 'Please Select End Date..'
                });
                document.getElementById("toDate").focus();
                return;
            }
            $('.loader').show();

        

            $.ajax({
                type: "GET",
                data: {
                    "actualDeparture": fromDate.concat(" ","00:00:00"),
                    "actualArrival": toDate.concat(" ","23:59:59")
                   
                },
                url: "<%=GlobalUrl.filterPoDetails%>",
                dataType: "json",
                contentType: "application/json",

                success: function(data) {
                    $('.loader').hide();
                    if (data.msg == 'success' ) {
                    	
						
                        var result = data.data;
                       
                        tabledata.clear();
                        console.log("result" + result);
                        
                        if(result.length!=0 ){
                        	
                        var poLineDetails = result[0].poLineDetails;
                     
                        for (var i = 0; i < result.length; i++) {
                        	for(var k = 0; k< poLineDetails.length; k++){
                        	if(!result[i].hasOwnProperty("id")){
 								result[i].id="";
 							}
                        	if(!result[i].hasOwnProperty("poNo")){
 								result[i].poNo="";
 							}
                             if(!result[i].hasOwnProperty("type")){
 								result[i].type="";
 							}
                              if(!result[i].poLineDetails[k].hasOwnProperty("uom")){
 								result[i].poLineDetails[k].uom="";
 							}
                             if(!result[i].poLineDetails[k].hasOwnProperty("quantity")){
 								result[i].poLineDetails[k].quantity="";
 							}
                             if(!result[i].hasOwnProperty("needByDate")){
  								result[i].needByDate="";
  							} 
                             if(!result[i].poLineDetails[k].hasOwnProperty("amount")){
  								result[i].poLineDetails[k].ammount="";
  							}
                             if(!result[i].hasOwnProperty("status")){
 								result[i].poLineDetails[i].status="";
 							}
                             
							 var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getPoDataFormDataByPoNumber('" +  result[i].poNo + "')\" >" + result[i].poNo + "</button>";
                            var unprocess_status = '<span class=\"right badge badge-warning\">UnProcess</span>';
                            var process_status = '<span class=\"right badge badge-success\">Process</span>';
                             var postatus="";                       
                         if (result[i].status == "Process") {
                        	 postatus = process_status;

                              } else if(result[i].status == "Unprocess"){
                            	  postatus = unprocess_status;
                              } 
                            tabledata.row.add([view ,result[i].type,result[i].poLineDetails[k].uom,result[i].poLineDetails[k].quantity,result[i].needByDate,result[i].poLineDetails[k].amount,postatus ]);  				        	
                        }
                        }
                        tabledata.draw();
                        $("tbody").show();
                        }else{
                        	tabledata.clear();
                        	
                            tabledata.draw();
                        	 Toast.fire({
                        		 type: 'error',
                                 title: 'No.. Data Found !..'
                             })
                        }
                    } else {
                        console.log(data);
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }

                },
                error: function(jqXHR, textStatue, errorThrown) {
                    $('.loader').hide();
                    Toast.fire({
                        type: 'error',
                        title: '.. Try Again..'
                    })
                }

            });

        }

        </script>
</body>

</html>
