<%@ page import="com.main.commonclasses.GlobalUrl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName} | Email Configuration</title>

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
            padding: 5px;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

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
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Email Configuration" />

        <jsp:include page="sidebar_Admin.jsp?pagename=emailConfig" />

        <div class="content-wrapper">
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <div class="input-group-prepend">
                            </div>
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
                                    <h3 class="card-title">Add Email</h3>
                                </div>
                                <form role="form" id="addForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Email</label> <input type="text" name="userName" class="form-control" id="userName" maxlength="50" >
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Password</label> <input type="password" name="password" maxlength="50" class="form-control" id="password" >
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Host Name</label> <input type="text" name="serverName" maxlength="50" class="form-control" id="serverName" >
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Port</label> <input type="text" name="smtpPort" maxlength="5" class="form-control" id="smtpPort" >
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Active Data</h3>
                                </div>
                                <div class="card-body">
                                    <table id="tabledata" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Email</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">SMTP Host Name</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">SMTP Port</th>
                                               <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;"> Edit</th>
                                                <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Delete</th>
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

    <div class="modal fade" id="userModal" role="dialog">
        <div class="modal-dialog " style="max-width: 1300px;">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Update</h3>
                                </div>
                                <form role="form" id="updateForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Email</label> <input type="text" name="userName" class="form-control" id="userNameEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Password</label> <input type="password" name="password" class="form-control" id="passwordEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Host Name</label> <input type="text" name="serverName" class="form-control" id="serverNameEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">SMTP Port</label> <input type="text" name="smtpPort" class="form-control" id="smtpPortEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" class="btn btn-primary">Update</button>
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

    <script>
        function myFunction() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

        function filterFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            div = document.getElementById("myDropdown");
            a = div.getElementsByTagName("a");
            for (i = 0; i < a.length; i++) {
                txtValue = a[i].textContent || a[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }
    
        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": true,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });


        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });


        $.validator.setDefaults({
            submitHandler: function() {
                addFormData();
            }
        });
        $('#addForm').validate({

            rules: {
                userName: {
                    required: true,
                    email: true
                },
                password: {
                    required: true

                },
                serverName: {

                    required: true

                },
                smtpPort: {
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

        $.validator.setDefaults({
            submitHandler: function() {
                updateFormData();
            }
        });
        $('#updateForm').validate({

            rules: {
                userName: {
                    required: true,
                    email: true
                },
                password: {
                    required: true

                },
                serverName: {

                    required: true

                },
                smtpPort: {
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


        var id = "";
        var status = "";

        function editData(id2) {
            id = "";
            id = id2;
            status = "";

            var json = {

                "id": id2
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.getEmailCofigurationDataById%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {

                        var result = data.data;

                        $("#smtpPortEdit").val(result.smtpPort);
                        $("#userNameEdit").val(result.userName);
                        $("#passwordEdit").val(result.password);
                        $("#serverNameEdit").val(result.serverName);


                        $("#userModal").modal('show');

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



        function addFormData() {



            var json = {

                "serverName": $("#serverName").val(),
                "password": $("#password").val(),
                "userName": $("#userName").val(),
                "smtpPort": $("#smtpPort").val(),
                "isActive": "1"
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.saveUpdateEmailData%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {

                        $('#addForm')[0].reset();

                        Toast.fire({
                            type: 'success',
                            title: 'Saved Successfully..'
                        })

                        getData();
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

        function updateFormData() {



            var json = {
                "id": id,
                "serverName": $("#serverNameEdit").val(),
                "password": $("#passwordEdit").val(),
                "userName": $("#userNameEdit").val(),
                "smtpPort": $("#smtpPortEdit").val(),
                "isActive": "1"
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.saveUpdateEmailData%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {

                        Toast.fire({
                            type: 'success',
                            title: 'Updated Successfully..'
                        })
                        $("#userModal").modal('hide');

                        getData();
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

        getData();

        function getData() {
            var json = {
                "isActive": "1"
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.getEmailCofigurationDataByStatus%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {
                    if (data.msg == 'success') {
                        var result = data.data;
                        tabledata.clear();
                        for (var i = 0; i < result.length; i++) {
                         	if(!result[i].hasOwnProperty("userName")){
                         	result[i].userName="";
                         	}
                         	if(!result[i].hasOwnProperty("serverName")){
                         	result[i].serverName="";
                         	}
                         	if(!result[i].hasOwnProperty("smtpPort")){
                         	result[i].smtpPort="";
                         	}
                         	if(!result[i].hasOwnProperty("id")){
                         	result[i].id="";
                         	}
                            var inactive = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"inactiveActiveDeleteData(" + result[i].id + ")\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                            var edit = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" style=\"width: 43px;\"  onclick=\"editData(" + result[i].id + ")\"><i class=\"nav-icon fas fa-edit\"> </i> </button>";

                            tabledata.row.add([result[i].userName, result[i].serverName, result[i].smtpPort, edit, inactive]);
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

        function inactiveActiveDeleteData(id) {

            var json = {
                "id": id,
                "isActive": "0"
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.updateEmailConfigurationSatatusByid%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {
                    if (data.msg == 'success') {
                        Toast.fire({
                            type: 'success',
                            title: 'Deleted Successfully..'
                        })
                        getData();
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

    </script>

</body>


</html>
