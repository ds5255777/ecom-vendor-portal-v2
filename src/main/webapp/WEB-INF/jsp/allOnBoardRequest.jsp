<!DOCTYPE html>
<%@ page import="com.main.commonclasses.GlobalConstants" %>
<%@ page import="com.main.commonclasses.GlobalUrl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|All Request</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="dist/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="plugins/summernote/summernote-bs4.css">
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

        <jsp:include page="navbar.jsp?pagename=All On-Board Request" />

        <jsp:include page="slidebar_Finance.jsp?pagename=All On-Board Request" />

        <div class="content-wrapper">
            <section class="content">
                <div class="container-fluid">
                    <div class="content-header" style="padding: 0px;">
                        <div class="container-fluid">
                            <div class="row mb-2">
                                <div class="col-sm-6"></div>
                                <div class="col-sm-6"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">

                            <div class="card card-primary  card-outline ">
                                <div class="card-header">
                                    <h3 class="card-title" id="lastInvoice" data-toggle="tooltip" data-placement="bottom"></h3>
                                </div>
                                <div class="card-body table-responsive p-0" style="height: 420px;">
                                    <table class="table table-head-fixed" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary">Process Id</th>
                                                <th class="bg-primary">introduced by email id</th>
                                                <th class="bg-primary">Introduced By Name</th>
                                                <th class="bg-primary">Business Partner Name</th>
                                                <th class="bg-primary">Business Partner Type</th>
                                                <th class="bg-primary">Status</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script>
        $.widget.bridge('uibutton', $.ui.button);
        $.widget.bridge('uitooltip', $.ui.tooltip);

    </script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/chart.js/Chart.min.js"></script>
    <script src="plugins/sparklines/sparkline.js"></script>
    <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="plugins/summernote/summernote-bs4.min.js"></script>
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

    <script>
		const Toast = Swal.mixin({
			toast : true,
			position : 'top-end',
			showConfirmButton : false,
			timer : 3000
		});
		var tabledata = $('#tabledata').DataTable({
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"info" : false,
			"autoWidth" : false,
			"aaSorting" : []
		});
		
		var globalProcessId = "";
		
pendingRequest();
        function pendingRequest() {
            $('.loader').show();
            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getAllRequest%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                    $('.loader').hide();
                    if (data.msg == 'success') {
                        var result = data.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                            var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#vendorValue\" onclick=\"setVenRegStatus('" + result[i].pid + "','Vendor View')\" >" + result[i].pid + "</button>";
                            tabledata.row.add([
                            	view, 
                            	result[i].introducedByEmailID,
                            	result[i].introducedByName, 
                            	result[i].suppName,
                            	result[i].vendorType,
                            	result[i].venStatus]);
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
        
        function setVenRegStatus(pid){
        	globalProcessId = "";
        	globalProcessId = pid;
        	console.log(globalProcessId);
        }
        
        function setVenRegStatus(pid, status) {
            $('.loader').show();
            var urlOftripsDetail = "vendorView?pid=" +btoa(pid)+"&status="+btoa(status);
            window.open(urlOftripsDetail, "vendorView", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
            $('.loader').hide();
        }
        
        
        </script>

</body>

</html>
