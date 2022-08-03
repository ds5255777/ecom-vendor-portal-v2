<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Approved Invoice</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="dist/css/ionicons.min.css">
	 <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
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

        <jsp:include page="navbar.jsp?pagename=Approved Invoices" />

         <jsp:include page="slidebar_Finance.jsp?pagename=processInvoiceFinance" />

        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>

            <section class="content mt-2">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12" style="font-size: 14px;">
                            <div class="card card-primary ">
                                
                                <div class="card-body ">
                                <form role="form" id="addForm" autocomplete="off">
										<div class="row">
											<div class="col-md-2">
												<div class="dropdown">
													<button type="button"
														class="btn btn-primary dropdown-toggle"
														style="  margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;"
														data-toggle="dropdown">Export Details</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="#" id="exportLinkPdf">Download
															PDF</a> <a class="dropdown-item" href="#" id="exportLink">Download
															Excel</a>
													</div>
												</div>
											</div>
											<div class="col-md-8"></div>
											<div class="col-md-2">
												<div class="form-group row">
													<label class="col-md-4">Search : </label>
													<div class="col-md-8">
														<input type="text" name="searchData" placeholder="Search"
															class="form-control" id="searchData">
													</div>
												</div>
											</div>
										</div>
									</form>
                                    <table class="table table-bordered table-hover" id="tabledata">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">ECOM Invoice Number</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor Invoice Number</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor Code</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor Name</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Invoice Receiving Date</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Invoice Date</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Total Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
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

            var dataLimit='${dataLimit}';
    		dataLimit=parseInt(dataLimit);
    		
            var tabledata = $('#tabledata').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": true,
                "info": true,
                "autoWidth": false,
                "aaSorting": [],
                "scrollX": true,
                "pageLength": dataLimit,
                dom: 'Bfrtip',
                buttons: [

                    {
                        extend: 'excelHtml5',

                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6],
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'A4',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5,6 ],
                        },
                        customize: function(doc) {

                            var tblBody = doc.content[1].table.body;
                            for (var i = 0; i < tblBody[0].length; i++) {
                                tblBody[0][i].fillColor = '#FFFFFF';
                                tblBody[0][i].color = 'black';
                            }

                            var objLayout = {};
                            objLayout['hLineWidth'] = function(i) {
                                return .5;
                            };
                            objLayout['vLineWidth'] = function(i) {
                                return .5;
                            };
                            objLayout['hLineColor'] = function(i) {
                                return '#aaa';
                            };
                            objLayout['vLineColor'] = function(i) {
                                return '#aaa';
                            };
                            objLayout['paddingLeft'] = function(i) {
                                return 4;
                            };
                            objLayout['paddingRight'] = function(i) {
                                return 4;
                            };
                            doc.content[1].layout = objLayout;
                            var obj = {};
                            obj['hLineWidth'] = function(i) {
                                return .5;
                            };
                            obj['hLineColor'] = function(i) {
                                return '#aaa';
                            };
                        }
                    }
                ],
                initComplete: function() {
                    var $buttons = $('.dt-buttons').hide();
                    $('#exportLink').on('click', function() {
                        var btnClass = "excel" ?
                            '.buttons-' + "excel" :
                            null;
                        if (btnClass) $buttons.find(btnClass).click();
                    })

                    $('#exportLinkPdf').on('click', function() {
                        var btnClass = "pdf" ?
                            '.buttons-' + "pdf" :
                            null;
                        if (btnClass) $buttons.find(btnClass).click();
                    })
                }
            });
            
            $('#searchData').on( 'keyup', function () {
            	tabledata.search( this.value ).draw();
            } );
            
            $('#tabledata_filter').css("display","none");

            getData();

            function getData() {
                $('.loader').show();
                $.ajax({
                    type: "POST",
                    data: "",
                    url: "<%=GlobalUrl.viewAllProcessInvoiceForFinanceTeam%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        $('.loader').hide();
                        if (data.msg == 'success') {
                            var result = data.data;
                            tabledata.clear();
                            for (var i = 0; i < result.length; i++) {
                                if (!result[i].hasOwnProperty("invoiceNumber")) {
                                    result[i].invoiceNumber = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceDate")) {
                                    result[i].invoiceDate = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceAmount")) {
                                    result[i].invoiceAmount = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceReceivingDate")) {
                                    result[i].vehicleNumber = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceStatus")) {
                                    result[i].invoiceStatus = "";
                                }
                                if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
                                    result[i].invoiceStatus = "";
                                }
                                var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"getInvoiceDataFormDataByInvoiceNumber('" + result[i].ecomInvoiceNumber + "','Processed Invoice')\" >" + result[i].ecomInvoiceNumber + "</button>";

                                tabledata.row.add([view, result[i].invoiceNumber, result[i].vendorCode, result[i].vendorName, result[i].invoiceReceivingDate,  result[i].invoiceDate, result[i].invoiceAmount]);
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
                        alert("failed, please try again leter");
                    }
                });
            }

            function getInvoiceDataFormDataByInvoiceNumber(id, type) {
                $('.loader').show();

                var urlOftripsDetail = "invoiceViewFinance?id=" + id+"&type="+type;
                window.open(urlOftripsDetail, "invoiceViewFinance", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
                $('.loader').hide();
            }

        </script>

       </body>

</html>
