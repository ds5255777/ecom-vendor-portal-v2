var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');



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
        		    $('#changePasswordButton').attr('disabled', true);
                    return;
            		  }
                });
            }); 
            
            const Toast = Swal.mixin({
    			toast : true,
    			position : 'top-end',
    			showConfirmButton : false,
    			timer : 3000
    		});
   
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
                
            ],
            datasets: [{
                data: [$("#activeUser").val(),$("#inactiveUser").val()],
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
                url: "userController/getActiveUsersData",
                dataType: "json",
                headers: { 'X-XSRF-TOKEN': csrfToken },
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
                 headers: { 'X-XSRF-TOKEN': csrfToken },
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

