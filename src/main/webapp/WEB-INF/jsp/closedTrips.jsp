<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Closed Trips</title>

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
    <style>
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
        <jsp:include page="navbar.jsp?pagename=Closed Trips" />
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <jsp:include page="slidebar.jsp?pagename=closedTrips" />

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
                        <div class="col-md-12" style="font-size: 14px;">
                            <!-- general form elements -->
                            <div class="card card-primary ">
                                <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                    <h3 class="card-title" style="font-size: 15px;">Closed Trips</h3>
                                </div>
                                <!-- /.card-header -->
                               
                                <div class="card-body ">
                                
                                  <form role="form" id="addForm" autocomplete="off">
                                            <div class="row">
                                            <div class="col-md-2">
												<!-- <label>From Date</label> --> <input type="text" name="fromDate"
													class="form-control" id="fromDate" style="height: 34px;">
											</div>
											<div class="col-md-2">
												<!-- <label>To Date</label> --> <input type="text" name="toDate"
													class="form-control" id="toDate" style="height: 34px;">
											</div>
                                                <div class="col-md-6">
												 <!-- <label for="exampleInputserverName1"
													style="visibility: hidden;"></label> -->
												<button type="submit" class="btn btn-primary">Search</button>
											</div>

                                            </div>
                                        </form> 
                                
                                  
                                    <table class="table table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
                                                
                                                <th style="padding: 5px 5px 5px 1.5rem;">Trip Id</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Run Type</th>
                                                <!-- <th style="padding: 5px 5px 5px 1.5rem;">Trip Status</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Payment Status</th> -->
                                                <th style="padding: 5px 5px 5px 1.5rem;">Actual KM</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Standard KM</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Mode</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Actual Departure (ATD)</th>
                                                <th style="padding: 5px 5px 5px 1.5rem;">Actual Arrival (ATA)</th>
                                                <!-- <th style="padding: 5px 5px 5px 1.5rem;">Origin Hub</th>
												<th style="padding: 5px 5px 5px 1.5rem;">Destination Hub</th> -->

                                            </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                                <!-- <div class="modal-footer">

                                    <input id="flipToInvoice" type="submit" class="submit-input" onclick="invoiceProcessing()" value="Flip to Invoice " />
                                </div> -->
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

        <!-- Modal -->
        <div class="modal fade" id="tripValue" role="dialog">
            <div class="modal-dialog " style="max-width: 1200px;">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-body" style="overflow-y: auto;">
                        <div class="container-fluid panel2" id="headerLineItemForm">
                            <div class="row">
                                <div class="col-md-12 propTableContainer" style="overflow-y: auto; height: 620px;">
                                    <input type="hidden" id="headerDetailsId" class="form-control">
                                    <!-- <table class="table " id="property-desc"> -->
                                    <div class="card card-primary">
                                         <div class="card-header" style="padding: 4px 0px 4px 4px;">
                                            <h3 class="card-title" style="font-size: 15px;">Trip Details</h3>
                                        </div>


                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <form role="form" id="tripForm">
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Trip ID</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="tripID" name="tripID" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Route</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="route" name="route" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Run Type</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="runType" name="runType" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Mode</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="mode" name="mode" autocomplete="off" disabled>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Vehicle Number</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="vehicleNumber" name="vehicleNumber" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Vendor Name</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="vendorName" name="vendorName" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual Vehicle Type</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="actualVechicleType" name="actualVechicleType" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Standard Payload Capacity</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="standardPayloadCapacity" name="standardPayloadCapacity" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Standard Shipment Capacity</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="standardShipmentCapacity" name="standardShipmentCapacity" autocomplete="off" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Run Status</label>
                                                            <div class="form-group">
                                                                <input type="text" class="form-control" style="height: 30px;" id="runStatus" name="runStatus" autocomplete="off" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Origin Hub</label>
                                                            <div class="form-group">
                                                                <input type="text" class="form-control" autocomplete="off" style="height: 30px;" id="originHub" name="originHub" disabled>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Origin Region</label>
                                                            <input type="text" class="form-control" autocomplete="off" style="height: 30px;" placeholder="Enter" id="originRegion" name="originRegion" disabled>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Dest Hub</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="destHub" name="destHub" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual Departure (ATD)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualDeparture" name="actualDeparture" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual Arrival (ATA)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualArrival" name="actualArrival" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Actual KM</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="actualKM" name="actualKM" disabled>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Standard KM</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" autocomplete="off" id="standardKM" name="standardKM" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Mileage</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="mileage" name="mileage" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Rate per km</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="ratePerKm" name="ratePerKm" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Bilable KM</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="routeKms" name="routeKms" disabled>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">FS Base Rate</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fsBaseRate" name="fsBaseRate" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Current Fuel Rate</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="currentFuelRate" name="currentFuelRate" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">FS Diff</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fsDiff" name="fsDiff" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Basic Freight</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="basicFreight" name="basicFreight" disabled>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">FS</label>
                                                            <input type="text" class="form-control numberWithDecimalcheck" style="height: 30px;" placeholder="Enter" autocomplete="off" id="fs" name="fs" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <!-- text input -->
                                                        <div class="form-group">
                                                            <label style="margin-bottom: 1px;">Total Freight (Total Trip Cost)</label>
                                                            <input type="text" class="form-control" style="height: 30px;" placeholder="Enter" id="totalFreight" name="totalFreight" disabled>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
									<div class="container">
										<div class="col-md-12 text-center" style="padding-top: 0px;">
	                       					 <button type="button" class="btn btn-primary" id="closeModal" data-dismiss="modal">Close</button>
	                  			    	</div>
                  			    	</div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!-- model End -->

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

        <script type="text/javascript">
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });

            var tabledata = $('#tabledata').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": false,
                "autoWidth": false,
                "aaSorting": []
            });
            
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
            
            $('#addForm').validate({

                rules: {
                    toDate: {
                        required: true
                    },
                    fromDate: {
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
                },
                unhighlight: function(element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                }
            });



            $(function() {
                //Enable check and uncheck all functionality
                $('.checkbox-toggle').click(function() {
                    var clicks = $(this).data('clicks')
                    if (clicks) {
                        //Uncheck all checkboxes
                        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', false)
                        $('.checkbox-toggle .far.fa-check-square').removeClass('fa-check-square').addClass('fa-square')
                    } else {
                        //Check all checkboxes
                        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', true)
                        $('.checkbox-toggle .far.fa-square').removeClass('fa-square').addClass('fa-check-square')
                    }
                    $(this).data('clicks', !clicks)
                })
                //Handle starring for glyphicon and font awesome
                $('.mailbox-star').click(function(e) {
                    e.preventDefault()
                    //detect type
                    var $this = $(this).find('a > i')
                    var glyph = $this.hasClass('glyphicon')
                    var fa = $this.hasClass('fa')

                    //Switch states
                    if (glyph) {
                        $this.toggleClass('glyphicon-star')
                        $this.toggleClass('glyphicon-star-empty')
                    }

                    if (fa) {
                        $this.toggleClass('fa-star')
                        $this.toggleClass('fa-star-o')
                    }
                })
            })
            
           /*  var arr=[];
              document.getElementById('flipToInvoice').onclick = function() {
            	$('input[name="option"]:checked').each(function() {
            		   //	console.log(this.value); 
            		   var table = document.getElementById('tabledata');
                       
                       
                       for (var r = 1, n = table.rows.length; r < n; r++) {
                               arr.push(table.rows[r].cells[1].innerText);
                       } 
                       
            		});	
            	let values = arr.toString();
                console.log(values);
				}  */

				
             function invoiceProcessing() {
                var table = document.getElementById('tabledata');
                var arr=[];
                
                for (var r = 1, n = table.rows.length; r < n; r++) {
                        arr.push(table.rows[r].cells[1].innerText);
                } 
                let values = arr.toString();
                console.log(values);
                
                $('.loader').show();
                
                var urlOftripsDetail = "tripsInvoiceGenerate?id="+values;
                window.open(urlOftripsDetail, "tripsInvoiceGenerate", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
               
                
                $('.loader').hide();
               
				} 
				
            getData();

            function getData() {
                var jsArray = [];
                $('.loader').show();

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsArray),
                    url: "<%=GlobalUrl.getCloseTripsDetails%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {
                        $('.loader').hide();
                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();

                            for (var i = 0; i < result.length; i++) {
                                //var viewData = "<button type=\"button\" class=\"btn btn-primary btn-xs\" onclick=\"viewCheckList('" + result[i].siteQualityId + "','" + result[i].checkListId + "','"+result[i].url+"')\"><i class='fa fa-eye ' ></i></button>";
                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";
                                //var checkbox = "<div class=\"mailbox-messages\"><input type=\"checkbox\" name=\"option\" value=\""+result[i].tripID+"\" ><\div>";
                                
                                var statustemp_runType_Scheduled = '<span class=\"right badge badge-warning\">Scheduled</span>';
                                var statustemp_runType_AdHoc = '<span class=\"right badge badge-success\">Ad-Hoc</span>';

                                var statustemp_mode_MilkRun = '<span class=\"right badge badge-warning\">Milk Run</span>';
                                var statustemp_mode_LineHaul = '<span class=\"right badge badge-success\">Line Haul</span>';
                                
                                var runType = "";
                                var mode = "";
                                
                                
                               // tabledata.row.add([checkbox, view, result[i].route, result[i].runType, result[i].actualKM, result[i].standardKM, result[i].mode, result[i].actualDeparture, result[i].actualArrival, result[i].status]);
                                var tempString=[ view, result[i].route, runType, result[i].actualKM, result[i].standardKM, mode, result[i].actualDeparture, result[i].actualArrival, result[i].status];
                                
                                if (result[i].runType == "Scheduled") {
                                    tempString[2] = statustemp_runType_Scheduled;

                                } else if (result[i].runType == "Ad-Hoc") {
                                    tempString[2] = statustemp_runType_AdHoc;

                                }
                                
                                if (result[i].mode == "Milk Run") {
                                    tempString[5] = statustemp_mode_MilkRun;

                                } else if (result[i].mode == "Line Haul") {
                                    tempString[5] = statustemp_mode_LineHaul;

                                }
                                
                                tabledata.row.add(tempString);
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

            /* function setTripStatus(tripId){
				 console.log("try to oepn checklist");
				 console.log("tripid : "+tripId);
							 
			 } */

            function setTripStatus(tripId) {
                console.log("Trip od" + tripId);
                //	 tripId =  $("#tripID").val();		

                var json = {
                    "tripID": tripId
                }

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.tripDetailByTripId%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        if (data.msg == 'success') {
                            var result = data.data;

                            /* jsondata=JSON.parse(result) */
                            ;
                            var myForm = "";
                            myForm = document.getElementById("tripForm");
                            setData(myForm, result);

                            $("#tripID").val(result.tripID);


                        } else {
                            Toast.fire({
                                type: 'error',
                                title: 'Failed.. Try Again..'
                            })
                        }
                    },
                    error: function(jqXHR, textStatue, errorThrown) {
                        //alert("failed, please try again");
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }

                });
            }
			 
				function getFilterData(){
					$('.loader').show();
					var fromDate = $("#fromDate").val();
					var toDate = $("#toDate").val();
					
					var obj={
							"actualDeparture":fromDate,
							"actualArrival":toDate
					}

					$.ajax({
					      	type: "POST",
					      	data: JSON.stringify(obj), 
						    url: "<%=GlobalUrl.filterTripDetails%>",
							dataType : "json",
							contentType : "application/json",
							
							success : function(data) {
								$('.loader').hide();
							if (data.msg == 'success') {
								alert("Hiii");
								console.log(data);
							} else {
								console.log(data);
								Toast.fire({
									type : 'error',
									title : 'Failed.. Try Again..'
								})
							}

						},
						error : function(jqXHR, textStatue, errorThrown) {
							$('.loader').hide();
							Toast.fire({
								type : 'error',
								title : '.. Try Again..'
							})
						}

					});

				} 

        </script>
</body>

</html>
