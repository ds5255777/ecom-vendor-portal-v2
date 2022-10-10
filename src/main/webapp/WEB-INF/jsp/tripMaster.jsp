<!DOCTYPE html>
<%@page import="com.main.commonclasses.GlobalConstants"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|MasterCheckList</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
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
        label {
            font-weight: 500;
            margin-bottom: 1px;
        }

        .form-control {
            height: 35px;
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

    </style>

    <style>
        .select2-container--default .select2-purple .select2-selection--multiple .select2-selection__choice,
        .select2-purple .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #006fe6;
            border-color: #006fe6;
            color: #fff;
        }

        .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected],
        .select2-container--default .select2-purple .select2-results__option--highlighted[aria-selected]:hover,
        .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected],
        .select2-purple .select2-container--default .select2-results__option--highlighted[aria-selected]:hover {
            background-color: #006fe6;
            color: #fff;
        }

    </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed sidebar-collapse">
    <%
	String adminRole = GlobalConstants.ROLE_ADMIN;
	String financeRole = GlobalConstants.ROLE_FINANCE;

	request.setAttribute("adminRole", adminRole);
	request.setAttribute("financeRole", financeRole);
	%>
    <jsp:include page="loader.jsp" />
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Trip Master" />

        <%
		String rolename = (String) request.getSession().getAttribute("role");
		out.print(rolename);
		%>
        <c:choose>
            <c:when test="<%=rolename.equalsIgnoreCase(adminRole)%>">
                <jsp:include page="sidebar_Admin.jsp?pagename=masterEvaluationCriteria" />
            </c:when>
            <c:when test="<%=rolename.equalsIgnoreCase(financeRole)%>">
                <jsp:include page="slidebar_Finance.jsp?pagename=masterEvaluationCriteria" />
            </c:when>
        </c:choose>

        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <div class="input-group-prepend"></div>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Trip Master Details</h3>
                                </div>
                                <form role="form" id="addForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <label>Route</label> <input type="text" name="route" class="form-control" id="route" maxlength="50">
                                            </div>
                                            <div class="col-md-2">
                                                <label>Vendor Name</label> <input type="text" name="vendorName" class="form-control" id="vendorName" maxlength="50">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Vendor Code</label> <input type="text" name="vendorCode" class="form-control" id="vendorCode">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Type</label> <select class="form-control" id="type" name="type">
                                                    <option value="">-- Select --</option>
                                                    <option value="Line Haul">Line Haul</option>
                                                </select>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Origin</label> <input type="text" name="city" class="form-control" id="city" maxlength="3">
                                            </div>

                                            <div class="col-md-2">
                                                <label>City Name</label> <input type="text" name="cityName" class="form-control" id="cityName">
                                            </div>

                                            <div class="col-md-2">
                                                <label>State</label> <input type="text" name="state" class="form-control" id="state">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Vehicle Type</label> <input type="text" name="vehicleType" class="form-control" id="vehicleType" maxlength="50">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Trip Cost</label> <input type="number" name="tripCost" class="form-control" id="tripCost" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Rate </label> <input type="number" name="rate" class="form-control" id="rate" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Base Rate</label> <input type="number" name="baseRate" class="form-control" id="baseRate" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Std. Mileage/KM</label> <input type="number" name="stdMileagePerKm" class="form-control" id="stdMileagePerKm" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Max KMS</label> <input type="number" name="maxKms" class="form-control" id="maxKms" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Agreement Made Date</label> <input type="date" name="agreementMadeDate" class="form-control" id="agreementMadeDate">
                                            </div>


                                            <div class="col-md-2">
                                                <label>Agreement Expiry date</label> <input type="date" name="agreementExpiryDate" class="form-control" id="agreementExpiryDate">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Current Fuel Rate</label> <input type="number" name="currentFuelRate" class="form-control" id="currentFuelRate" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>FS Diff</label> <input type="number" name="fsDiff" class="form-control" id="fsDiff">
                                            </div>

                                        </div>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" class="btn btn-primary" id="submitBtn">Submit</button>
                                        <div class="btn btn-default btn-file" style="background-color: #007bff; color: white;">

                                            <a href="excel/MasterCheckList.xlsx" download style="color: white;"> <i class="fas fa-download"></i>
                                                Download Template
                                            </a>
                                        </div>

                                        <div class="btn btn-default btn-file" style="background-color: #007bff; color: white;">
                                            <i class="fas fa-paperclip"></i> Upload Excel <input type="file" style="cursor: pointer;" id="readExcel" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" name="attachment">
                                        </div>

                                        <!-- <div class="btn btn-default btn-file"
											style="background-color: #007bff; color: white;">
											<i class="fas fa-paperclip"></i> Upload Excel (Update) <input
												type="file" style="cursor: pointer;" id="readExcelUpdate" onchange="handleFileSelectForExcelUpdate(event)"
												accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"
												name="attachmentUpdate">
										</div> -->
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Active Master</h3>
                                </div>
                                <div class="card-body">
                                    <form role="form" id="addForm" autocomplete="off">
                                        <div class="row">

                                            <div class="col-md-2">
                                                <div class="dropdown">
                                                    <button type="button" class="btn btn-primary dropdown-toggle" style="margin-bottom: 10px; margin-right: 5px; height: 30px; padding: 2px 10px 2px 10px;" data-toggle="dropdown">Export Details</button>
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
                                                        <input type="text" name="searchData" placeholder="Search" class="form-control" id="searchData">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <table id="tabledata" class="table table-bordered table-hover display nowrap">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">
                                                </th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Route</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
                                                    Name</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vendor
                                                    Code</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Type</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Origin</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">City
                                                    Name</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">State</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Vehicle
                                                    Type</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Trip
                                                    Cost</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Rate</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Base
                                                    Rate</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Mileage/Km</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Max
                                                    Kms</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Fuel
                                                    Rate</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">FS
                                                    Diff</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Agreement
                                                    Made Date</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Agreement
                                                    Expiry Date</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Agreement
                                                    Action</th>

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
        <aside class="control-sidebar control-sidebar-dark"></aside>
    </div>

    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog " style="max-width: 1300px;">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Update Master Detail</h3>
                                </div>

                                <form role="form" id="updateMDMData" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">

                                            <div class="col-md-2">
                                                <label>Route</label> <input type="text" name="route" class="form-control" id="routeEdit" maxlength="50">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Vendor Name</label> <input type="text" name="vendorName" class="form-control" id="vendorNameEdit" maxlength="50">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Vendor Code</label> <input type="text" name="vendorCode" class="form-control" id="vendorCodeEdit">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Type</label> <select class="form-control" id="typeEdit" name="type">
                                                    <option value="">-- Select --</option>
                                                    <option value="Line Haul">Line Haul</option>
                                                    <option value="Milk Run">Milk Run</option>
                                                </select>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Origin</label> <input type="text" name="cityEdit" class="form-control" id="cityEdit" maxlength="3">
                                            </div>

                                            <div class="col-md-2">
                                                <label>City Name</label> <input type="text" name="cityName" class="form-control" id="cityNameEdit">
                                            </div>

                                            <div class="col-md-2">
                                                <label>State</label> <input type="text" name="state" class="form-control" id="stateEdit">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Vehicle Type</label> <input type="text" name="vehicleType" class="form-control" id="vehicleTypeEdit" maxlength="50">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Trip Cost</label> <input type="number" name="tripCost" class="form-control" id="tripCostEdit" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Rate </label> <input type="number" name="rate" class="form-control" id="rateEdit" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Base Rate</label> <input type="number" name="baseRate" class="form-control" id="baseRateEdit" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Std. Mileage/KM</label> <input type="number" name="stdMileagePerKmEdit" class="form-control" id="stdMileagePerKmEdit" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Max KMS</label> <input type="number" name="maxKms" class="form-control" id="maxKmsEdit" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>Agreement Made Date</label> <input type="date" name="agreementMadeDateEdit" class="form-control" id="agreementMadeDateEdit">
                                            </div>


                                            <div class="col-md-2">
                                                <label>Agreement Expiry date</label> <input type="date" name="agreementExpiryDateEdit" class="form-control" id="agreementExpiryDateEdit">
                                            </div>

                                            <div class="col-md-2">
                                                <label>Current Fuel Rate</label> <input type="number" name="currentFuelRate" class="form-control" id="currentFuelRateEdit" maxlength="10" min=0>
                                            </div>

                                            <div class="col-md-2">
                                                <label>FS Diff</label> <input type="number" name="fsDiff" class="form-control" id="fsDiffEdit">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-footer" align="center">
                                        <button type="submit" id="updateBtn" class="btn btn-primary">Update</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="excelUploadModal" role="dialog">
        <div class="modal-dialog " style="max-width: 1050px;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-body">

                    <div class="col-md-12">
                        <div class="table-reponsive">

                            <table id="tabledataExcelUpload" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="bg-primary">Route</th>
                                        <th class="bg-primary">Vendor Name</th>
                                        <th class="bg-primary">Vendor Code</th>
                                        <th class="bg-primary">Type</th>
                                        <th class="bg-primary">Origin</th>
                                        <th class="bg-primary">City Name</th>
                                        <th class="bg-primary">State</th>
                                        <th class="bg-primary">Vehicle Type</th>
                                        <th class="bg-primary">Trip Cost</th>
                                        <th class="bg-primary">Rate</th>
                                        <th class="bg-primary">Base Rate</th>
                                        <th class="bg-primary">Mileage/Km</th>
                                        <th class="bg-primary">Max Kms</th>
                                        <th class="bg-primary">Fuel Rate</th>
                                        <th class="bg-primary">FS Diff</th>
                                        <th class="bg-primary">Agreement Made Date</th>
                                        <th class="bg-primary">Agreement Expiry Date</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" id="excelUploadSaveBtn">Submit</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                </div>
            </div>
        </div>
    </div>


    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

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
    <script src="js/jszip.js"></script>
    <script src="js/xlsx.js"></script>
    <script src="plugins/pdfmake/pdfmake.min.js"></script>
    <script src="plugins/pdfmake/vfs_fonts.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
    <script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>



    <script src="js/tripMaster.js"></script>
    <script src="js/commonFunctions.js"></script>
    <script src="js/common.js"></script>



</body>

</html>
