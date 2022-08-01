<%@page import="com.main.commonclasses.GlobalUrl"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${titleName}|Users</title>

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
    <jsp:include page="loader.jsp" />
    <div class="wrapper">

        <jsp:include page="navbar.jsp?pagename=Users" />

        <jsp:include page="sidebar_Admin.jsp?pagename=addUsers" />
       
		<input type="hidden" id =uname value=${uname } />
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header" style="padding: 0px;">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <div class="input-group-prepend">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- general form elements -->
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Add User, Not Applicable For Vendor</h3>
                                </div>
                                <form role="form" id="addForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">User Name</label> <input type="text" name="username" class="form-control" id="username" maxlength="70" pattern="[a-zA-Z][a-zA-Z0-9]+">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Password</label> <input type="password" name="password" class="form-control" id="password" maxlength="70" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">First Name</label> <input type="text" name="firstName" class="form-control" id="firstName" maxlength="70" pattern="[a-zA-Z]+">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Last Name</label> <input type="text" name="lastName" class="form-control" id="lastName" maxlength="70" pattern="[a-zA-Z]+">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Role</label> <select class="form-control" id="roleId" style="height: 34px;">
                                                          <c:forEach items="${role}" var="roleName">
															<option value="${roleName.id}">${roleName.roleName}</option>
														</c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Email</label> <input type="text" name="emailId" class="form-control" maxlength="70" id="emailId">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Contact No.</label> <input type="text" name="contactNo" maxlength="10" class="form-control" id="contactNo" pattern="^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$" title="Enter Valid mobile number ex.9811111111">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group"></div>
                                            </div>
                                        </div>
                                        <br>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" id="submitBtn" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Active Users</h3>
                                </div>
                                <div class="card-body">
                                    <table id="tabledata" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">User Name</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">First Name</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Last Name</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Role</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Email</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Contact No</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Status</th>
                                                 <th class="bg-primary" style="padding: 5px 5px 5px 1.5rem;">Action</th> 
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
                                    <h3 class="card-title">Update User</h3>
                                </div>
                                <form role="form" id="updateForm" autocomplete="off">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">User Name</label> <input type="text" name="username" class="form-control" readonly="readonly" id="usernameEdit" >
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Password</label> <input type="password"maxlength="70" name="password" class="form-control" id="passwordEdit" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">First Name</label> <input type="text"maxlength="70" name="firstName" class="form-control" id="firstNameEdit" pattern="[a-zA-Z]+">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Last Name</label> <input type="text" maxlength="70"name="lastName" class="form-control" id="lastNameEdit" pattern="[a-zA-Z]+">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Role</label> <select class="form-control" id="roleIdEdit" style="height: 34px;">
                                                        <c:forEach items="${role}" var="roleName">

															<option value="${roleName.id}">${roleName.roleName}</option>
														</c:forEach>
                                                       
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Email</label> <input type="text" name="emailId" maxlength="70"class="form-control" id="emailIdEdit">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Contact No</label> <input type="text" name="contactNo" maxlength="10"  class="form-control" id="contactNoEdit" pattern="^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$" title="Enter Valid mobile number ex.9811111111">
                                                </div>
                                            </div>
                                             <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="exampleInputserverName1">Status</label> <select class="form-control" id="statusEdit" style="height: 34px;">
                                                            <option value="1">Active</option>
                                                        	<option value="0">In-Active</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer" align="center">
                                        <button type="submit" id="updateBtn" class="btn btn-primary">Update</button>
                                        <button type="button" class="btn btn-primary" id="closePopBtn" data-dismiss="modal">Close</button>
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
    <script src="plugins/moment/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <script src="dist/js/adminlte.js"></script>
    <script src="dist/js/demo.js"></script>
    <script src="js/moment.min.js"></script>
    <script src="plugins/select2/js/select2.full.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            var bootstrapTooltip = $.fn.tooltip.noConflict();
            $.fn.bstooltip = bootstrapTooltip;
            $('.quickHelp').bstooltip();
        })

    </script>
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

    </script>

    <script type="text/javascript">
        var mappingTableArray = [];

        var tabledata = $('#tabledata').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": true,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });

        var tabledata2 = $('#tabledata2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true
        });

        var tabledata3 = $('#tabledata3').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": []

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
                firstName: {
                    required: true

                },
                lastName: {
                    required: true

                },
                emailId: {
                    email: true,
                    required: true

                },
                contactNo: {
                    required: true

                },
                username: {
                    required: true

                },
                password: {
                    required: true

                },
                roleId: {
                    required: true

                },
                licenseType: {
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
                firstName: {
                    required: true

                },
                lastName: {
                    required: true

                },
                emailId: {
                    email: true,
                    required: true

                },
                contactNo: {
                    required: true

                },
                
                username: {
                    required: true

                },

                roleId: {
                    required: true

                },
                licenseTypeEdit: {
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
                url: "<%=GlobalUrl.getUserById%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {
                    if (data.msg == 'success') {

                        var result = data.data;

                        $("#roleIdEdit").val(result.roleId);
                        $("#usernameEdit").val(result.username);
                        $("#contactNoEdit").val(result.contactNo);
                        $("#emailIdEdit").val(result.emailId);
                        $("#lastNameEdit").val(result.lastName);
                        $("#firstNameEdit").val(result.firstName);
                        status = result.status;

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

            var usernameCheckStatus = checkForExistingUserName();

            if (usernameCheckStatus == "false") {

                return;
            }

            $("#submitBtn").prop("disabled", true);
            $('.loader').show();

            var json = {

                "roleId": $("#roleId").val(),
                "password": $("#password").val(),
                "username": $("#username").val(),
                "contactNo": $("#contactNo").val(),
                "emailId": $("#emailId").val(),
                "lastName": $("#lastName").val(),
                "firstName": $("#firstName").val(),
                "status": "1",

            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.saveUpdateUserDetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {

                        $("#submitBtn").prop("disabled", false);
                        $('.loader').hide();
                        Toast.fire({
                            type: 'success',
                            title: 'Submitted Successfully..'
                        })
                        $("#addForm")[0].reset();

                        getData();
                    } else {
                        $("#submitBtn").prop("disabled", false);
                        $('.loader').hide();

                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }

                },
                error: function(jqXHR, textStatue, errorThrown) {
                    $("#submitBtn").prop("disabled", false);
                    $('.loader').hide();
                    alert("failed, please try again");
                }

            });

        }

        function updateFormData() {

            var json = {
                "id": id,
                "roleId": $("#roleIdEdit").val(),
                "password": $("#passwordEdit").val(),
                "username": $("#usernameEdit").val(),
                "contactNo": $("#contactNoEdit").val(),
                "emailId": $("#emailIdEdit").val(),
                "lastName": $("#lastNameEdit").val(),
                "firstName": $("#firstNameEdit").val(),
                "status": $("#statusEdit").val(), 

            }


            $("#updateBtn").prop("disabled", true);
            $('.loader').show();

            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.saveUpdateUserDetails%>",
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function(data) {

                    $("#updateBtn").prop("disabled", false);
                    $('.loader').hide();

                    if (data.msg == 'success') {

                        Toast.fire({
                            type: 'success',
                            title: 'Updated Successfully..'
                        })
                        $("#userModal").modal('hide');
                        getData();
                    } else {
                        $("#updateBtn").prop("disabled", false);
                        $('.loader').hide();
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }

                },
                error: function(jqXHR, textStatue, errorThrown) {
                    $("#updateBtn").prop("disabled", false);
                    $('.loader').hide();
                    alert("failed, please try again");
                }

            });

        }

        getData();

        function getData() {

            $.ajax({
                type: "POST",
                data: "",
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
        							}
                                  


                            var inactive = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"inactiveActiveDeleteData('" + result[i].id + "' ,'" +result[i].username+ "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                        
                            var edit = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"   data-original-title=\"Click To Edit\" style=\"width: 43px;\"  onclick=\"editData(" + result[i].id + ")\"><i class=\"nav-icon fas fa-edit\"> </i> </button>";
                            lastName = "";
                            if (result[i].hasOwnProperty("lastName")) {
                                lastName = result[i].lastName;
                            }
							var status="";
                            if(result[i].status==1){
                            	status="Active";
                            }else if(result[i].status==0){
                            	status="In-Active";
                            }
                            tabledata.row.add([result[i].username, result[i].firstName, lastName, result[i].rolesObj.roleName, result[i].emailId, result[i].contactNo,status, edit + " " + inactive]);

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


        function inactiveActiveDeleteData(userid , name) {
        	var uname = $("#uname").val();
        	 if (uname === name) {
        		 swal.fire("Alert", "Can not delete current user ! ", "warning");
                 return false;
        		 
        	 } 
        	 let text="Are You sure to delete "+name;
        	 if (confirm(text) != true) {
        		 
        		    
        		    return false;
        		  } 
        	 
        	 
        	
            var json = {
                "id": userid,
                "status": "0"
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.setStatusOfUserById%>",
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

        $("#username").focusout(function() {

            checkForExistingUserName();

        });


        function checkForExistingUserName() {

            var usernameCheckStatus = "false";

            if ($("#username").val() != "") {

                var json = {
                    "username": $("#username").val(),

                }
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(json),
                    url: "<%=GlobalUrl.checkForExistingUserName%>",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function(data) {

                        if (data.msg == 'exist') {

                            Toast.fire({
                                type: 'warning',
                                title: 'UserName Already Exists..'
                            })

                            $("#username").val('');

                        } else if (data.msg == 'success') {
                            usernameCheckStatus = "true";
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

            return usernameCheckStatus;
        }

    </script>
</body>

</html>
