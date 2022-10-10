var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

     $( "#chngpass" ).bind( "click", function() {
                                changePassword(document.getElementById('passwordch').value);
                                });


	 $(document).ready(function () {
         if ('${userStatus}' === 3) {
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
         });
     });
	
	var userType = $("#vendorRole").val();
	
            var tabledata = $('#tabledata').DataTable({
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "info": true,
                "autoWidth": false,
                "aaSorting": []
            });

            if(userType == "Finance"){            
            var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
            var unresolvedstsData = {
                labels: [
                    'All Invoices',
                    'In-Review Trip Invoices',
                    'In-Review PO Invoices',
                    'Query'
                ],
                datasets: [{
                        data: [$("#allInvoice").val(),$("#inReviewInvoice").val(),$("#countForPendingForApprovalInvoice").val(), $("#queryCount").val()],
                        backgroundColor: ['#FAA654', '#1F8BFF','#28a745','#3010af'],
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
            }else{
	
	 var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
            var unresolvedstsData = {
                labels: [
                    'All Invoices',
                    'In-Review Trip Invoices',
                    'In-Review PO Invoices',
                    'Query'
                ],
                datasets: [{
                        data: [$("#allInvoice").val(),$("#inReviewInvoice").val(),$("#countForPendingForApprovalInvoice").val(), $("#queryCount").val()],
                        backgroundColor: ['#FAA654', '#1F8BFF','#28a745','#3010af'],
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
	
	
}
            
            if(userType == "Finance Head"){            
                var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
                var unresolvedstsData = {
                    labels: [
                        'All Invoices',
                        'Pending For Approval',
                        'Approved Invoices'
                    ],
                    datasets: [{
                            data: ['${allInvoice}',  '${countForPendingForApprovalInvoice}','${countForApprovedInvoice}'],
                            backgroundColor: ['#6610f2', '#28a745', '#1F8BFF'],
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
                }

            function changePassword(password) {
                console.log(document.getElementById('passwordch').value);
                console.log("my password" + password);

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(password),
                    url: "userController/changePassword",
                    dataType: "json",
                    headers: { 'X-XSRF-TOKEN': csrfToken },
                    contentType: "application/json",
                    success: function (data) {
                        if (data.msg == 'success') {

                            $("tbody").show();
                        } else {
                            Toast.fire({
                                type: 'error',
                                title: 'Failed.. Try Again..'
                            })
                        }
                    },
                    error: function (jqXHR, textStatue, errorThrown) {
                        alert("failed, please try again letter");
                    }
                });
            }
            getData();

            function getData() {

                $.ajax({
                    type: "POST",
                    data: "",
                    url: "dashboardController/getFinanceDashBoardDetails",
                    dataType: "json",
                    headers: { 'X-XSRF-TOKEN': csrfToken },
                    contentType: "application/json",
                    success: function(data) {

                        if (data.msg == 'success') {

                            var result = data.data;
                            tabledata.clear();
                            for (var i = 0; i < result.length; i++) {
                            	if (!result[i].hasOwnProperty("ecomInvoiceNumber")) {
                                    result[i].ecomInvoiceNumber = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceDate")) {
                                    result[i].invoiceDate = "";
                                }
                                if (!result[i].hasOwnProperty("vendorCode")) {
                                    result[i].vendorCode = "";
                                }
                                if (!result[i].hasOwnProperty("vendorName")) {
                                    result[i].vendorName = "";
                                }
                                if (!result[i].hasOwnProperty("taxableAmount")) {
                                    result[i].taxableAmount = "";
                                }
                                if (!result[i].hasOwnProperty("taxAmount")) {
                                    result[i].taxAmount = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceAmount")) {
                                    result[i].invoiceAmount = "";
                                }
                            	tabledata.row.add([result[i].ecomInvoiceNumber,result[i].invoiceDate,result[i].vendorCode,
                                	result[i].vendorName,result[i].taxableAmount,result[i].taxAmount,result[i].invoiceAmount]);
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
        