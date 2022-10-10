var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

function disableF5(e) {
            if ((e.which || e.keyCode) == 116) e.preventDefault();
        };
        $(document).on("keydown", disableF5);
        
        $("input[type=text]").prop('readonly', true);
        var tripLineArray = [];
        var tripIdArray=[];
        var totalFreight = 0;
        var lumpsomeamount = parseFloat(0);

        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });

        var prTable = $("#prTable").DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true,
            "pageLength": 15,
        });
        
        var tabledataQuery = $('#tabledataQuery').DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": false,
            "autoWidth": false,
            "aaSorting": []
        });
        
        function closeWin() {
            window.opener.refereshList();
            window.close()
        }
        
        function onValidateFileOne(id) {
            var fileInput3 = document.getElementById(id).value;
            var gst = document.getElementById(id);
            var allowedExtensions = /(\.pdf|\.doc|\.docx|\.xls|\.xlsx)$/i;

            if (typeof(gst.files) != "undefined") {

                const fsize = gst.files.item(0).size;
                const file = Math.round((fsize / 1024));
                if (file > '${maxFileSize}') {
                    swal.fire("", "File should less than 5 MB.", "warning");
                    $("#" + id).val("");
                } else {
                    var ext = fileInput3.split(".")[1];
                    if (ext == "pdf" || ext == "PDF" || ext == "docx" || ext == "DOCX" || ext == "doc" || ext == "DOC" ||  ext == "xls" || ext == "XLS" || ext == "xlsx" || ext == "XLSX") {} else {
                        swal.fire("", "Select Only DOC, XLSX & PDF File.", "warning");
                        $("#" + id).val("");
                        return false;
                    }
                }
            } else {
                alert("This browser does not support HTML5.");
            }
        }
        
        setInvoiceDetails();
        
        function setInvoiceDetails() {
        	 $('.loader').show();
        	var invoiceNumber = $("#ecomInvoiceNumber").val();
            var obj = {
                "ecomInvoiceNumber": invoiceNumber
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getQueryInvoice%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {
                	 $('.loader').hide();
                     if (data.msg == 'success') {
                    	 var result = data.data;
                    	 var action = "";
                         var textBox = "";
                         var taxableAmount = 0;
                    	 tripLineArray = data.data.invoiceLineItem;
                         var myForm = "";
                         myForm = document.getElementById("stepOneForm");
                         setData(myForm, result);
                          
                         showTableData();
                         $("#vendorName").val(result.vendorName);
                         $("#invoiceNumber").val(result.invoiceNumber);
                         $("#ecomInvoiceNumber").val(result.ecomInvoiceNumber);
                         getQueryData(result.invoiceNumber);
                    } else {
                        Toast.fire({
                            type: 'error',
                            title: 'Failed.. Try Again..'
                        })
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    Toast.fire({
                        type: 'error',
                        title: 'Failed.. Try Again..'
                    })
                }
            });
        }
        
       
		 
		 function getQueryData(invoiceNu){
			 $('.loader').show();
			 var obj ={
						"referenceid": invoiceNu,
						"type": "Invoice"
				}
				$.ajax({
					type : "POST",
					url : "<%=GlobalUrl.getQueryByTypeAndForeignKey%>",
					data :JSON.stringify(obj),
					dataType : "json",
					contentType : "application/json",
					success : function(response) {
						 $('.loader').hide();
						if (response.msg == "success") {
						
							if("data" in response){
							
								var result = response.data;												
								
							     	tabledataQuery.clear();
							     	var count=0;
				                        for (var i = 0; i < result.length; i++) {
				                        	if(!result[i].hasOwnProperty("raisedBy")){
				                               	result[i].raisedBy="";
				                               }
				                                             if(!result[i].hasOwnProperty("role")){
				                               	result[i].role="";
				                               }
				                                             if(!result[i].hasOwnProperty("raisedOn")){
				                               	result[i].raisedOn="";
				                               }
				                                             if(!result[i].hasOwnProperty("comment")){
				                               	result[i].comment="";
				                               }                    
				                        count++;
				                        tabledataQuery.row.add([count,result[i].raisedBy, result[i].role, result[i].raisedOn, result[i].comment]);
				                        }
				                        tabledataQuery.draw();
				                        $("tbody").show();
								}
						} else {
							Toast.fire({
								type : 'error',
								title : 'Failed ..'
							})
						}
					},
					error : function(jqXHR, textStatue, errorThrown) {
						
						Toast.fire({
							type : 'error',
							title : 'Failed Added try again..'
						})

					}
				}); 
		 }
        
		 
		 function showTableData(){
			 
			 var taxableAmount = 0;
			 
			 prTable.clear();
             for (var i = 0; i < tripLineArray.length; i++) {
            	 if (!tripLineArray[i].hasOwnProperty("runType")) {
                     tripLineArray[i].runType = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("tripID")) {
                     tripLineArray[i].tripID = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("route")) {
                     tripLineArray[i].route = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("standardKM")) {
                     tripLineArray[i].standardKM = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("ratePerKm")) {
                     tripLineArray[i].ratePerKm = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("currentFuelRate")) {
                     tripLineArray[i].currentFuelRate = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("fsBaseRate")) {
                     tripLineArray[i].fsBaseRate = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("standardVechicleType")) {
                     result[i].standardVechicleType = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("fsDiff")) {
                     tripLineArray[i].fsDiff = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("basicFreight")) {
                     tripLineArray[i].basicFreight = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("fs")) {
                     tripLineArray[i].fs = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("mileage")) {
                     result[i].mileage = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("actualKM")) {
                     tripLineArray[i].actualKM = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("totalFreight")) {
                     tripLineArray[i].totalFreight = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("lumpsomeamount")) {
                     tripLineArray[i].lumpsomeamount = "";
                 }
                 if (!tripLineArray[i].hasOwnProperty("lineLevelDescription")) {
                     tripLineArray[i].lineLevelDescription = "";
                 }
                 textBox = "<input type=\"text\" class=\"form-control\" id=\"form-control\" placeholder=\"Fill Description\" maxlength=\"100\" value=\""+tripLineArray[i].lineLevelDescription+"\" oninput=\"updateTextData('" + i + "',this.value)\" style=\" height: 25px;padding: 5px 5px 5px 1.5rem; \">";
                 action = "<button type=\"button\"  class=\"btn btn-primary btn-xs \" data-placement=\"bottom\"  data-original-title=\"Click To Delete\" onclick=\"deleteRow('" + tripLineArray[i].tripID + "')\"> <i class=\"nav-icon fas fa-trash\"> </i>  </button>";
                 prTable.row.add([i+1,tripLineArray[i].tripID, tripLineArray[i].runType, tripLineArray[i].route, 
                	 tripLineArray[i].standardKM, tripLineArray[i].ratePerKm, tripLineArray[i].currentFuelRate, tripLineArray[i].fsBaseRate, 
                	 tripLineArray[i].standardVechicleType, tripLineArray[i].fsDiff, tripLineArray[i].basicFreight, tripLineArray[i].fs, 
                	 tripLineArray[i].mileage,  tripLineArray[i].totalFreight,tripLineArray[i].lumpsomeamount, textBox,action]);
                 id = (tripLineArray[i].id);
                 taxableAmount += parseFloat(tripLineArray[i].totalFreight)+ parseFloat(tripLineArray[i].lumpsomeamount);
             }
            
             $("#taxableAmount").val(parseFloat(taxableAmount).toFixed(2));
             prTable.draw();
             $("tbody").show();
             calculateInvoice();
		 }
		 
        function handleFileSelect(evt, id) {
            var f = evt.target.files[0]; // FileList object
            var reader = new FileReader();
            // Closure to capture the file information.
            reader.onload = (function(theFile) {
                return function(e) {
                    var binaryData = e.target.result;
                    //Converting Binary Data to base 64
                    var base64String = window.btoa(binaryData);
                    //showing file converted to base64
                    $("#" + id).val(base64String);
                };
            })(f);
            reader.readAsBinaryString(f);
        }
        
       /*  function updateTextData(index, textValue) {
            tripLineArray[index].lineLevelDescription = textValue.trim();
        } */
        
        function deleteRow(tripID) {
            prTable
                .row($(tripID).parents('tr'))
                .remove()
                .draw();
            deleteThisTrip(tripID);
            setInvoiceDetails();
        }
        
        function deleteThisTrip(tripID) {
            var json = {
                "tripID": tripID
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.deleteTripQueryInvoice%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {

                    if (data.msg == 'success') {
                        Toast.fire({
                            type: 'success',
                            title: 'Deleted Successfully.'
                        })
                        	/* $("#taxAmount").val(''); */
                        getSelectTripList();
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
        
        getSelectTripList();
        var bpname = $("#vendorCode").val();
        

        function getSelectTripList() {
        	
        	$("#tripList ").empty();
        	$('#tripList').append($('<option/>').attr("value", "").text("Select Trip Id"));

            $.ajax({
                type: "POST",
                data: "",
                url: "<%=GlobalUrl.getTripDetailByTripId%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                        tripIdArray=result;
                        if (result.length !== 0) {
                            for (var i = 0; i < result.length; i++) {
                                $('#tripList').append($('<option/>').attr("value", result[i]).text(result[i]));
                            }
                        }
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
        
        function AddDocCheck() {
            var invoiceNumber = $("#ecomInvoiceNumber").val();
            var tripID = document.getElementById("tripList").value;
            console.log("-----------------",tripID);
            for (var i = 0; i < tripIdArray.length; i++) {
                if (tripIdArray[i] === tripID) {
                	tripIdArray.splice(i,tripID);
                }
            }
            
            console.log("************",tripIdArray,"*************");
            
			if(tripID != ''){
            var json = {
                "tripID": tripID,
                "invoiceNumber": invoiceNumber
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(json),
                url: "<%=GlobalUrl.addNewTripInQueryInvoice%>",
                dataType: "json",
                contentType: "application/json",
                success: function(data) {

                    if (data.msg == 'success') {
                        Toast.fire({
                            type: 'success',
                            title: 'Added Successfully.'
                        })
                        var result=data.data;
                        result.newAdded="1";
                        tripLineArray.push(result);
                        showTableData();
                        getSelectTripList();
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
        }
        
        function sendToServer(){
        	
        	var remarks = document.getElementById("remarks").value;
            if (remarks === "" || remarks === null || remarks === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Remarks field not blank'
                });
                document.getElementById("remarks").focus();
                return "";
            }
            
            var docOne = document.getElementById("DocumentFileOne").value;
            if (docOne === "" || docOne === null || docOne === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Upload Summary Sheet'
                });
                document.getElementById("docOne").focus();
                return "";
            }
            
            var docTwo = document.getElementById("DocumentFileTwo").value;
            if (docTwo === "" || docTwo === null || docTwo === '') {
                Toast.fire({
                    type: 'error',
                    title: 'Upload FS Calculation Sheet'
                });
                document.getElementById("docTwo").focus();
                return "";
            }
            if(tripLineArray.length === 0){
            	Toast.fire({
                    type: 'error',
                    title: 'Select More Then One Trips'
                });
                return "";
            }
            
            const finalObj = {
            		"remarks": $('#remarks').val(),
            		"ecomInvoiceNumber":$('#ecomInvoiceNumber').val(),
            		"taxableAmount":$('#taxableAmount').val(),
            		"invoiceAmount":$('#invoiceAmount').val(),
            		"invoiceNumber":$('#invoiceNumber').val(),
            		"assignTo":"<%=GlobalConstants.ROLE_FINANCE%>",
            		"invoiceStatus":"<%=GlobalConstants.INVOICE_STATUS_IN_REVIEW%>",
            		"vendorCode":$('#vendorCode').val()
            };
            
            if (document.getElementById("DocumentFileOne").files.length > 0) {
                finalObj.documentFileOneName = document.getElementById("DocumentFileOne").files.item(0).name;
                finalObj.documentFileOneText = $("#DocumentFileOneText").val();
            }
            if (document.getElementById("DocumentFileTwo").files.length > 0) {
                finalObj.documentFileTwoName = document.getElementById("DocumentFileTwo").files.item(0).name;
                finalObj.documentFileTwoText = $("#DocumentFileTwoText").val();
            }
            
            tripLineArray.forEach((item) => {
                item.id = null;
                
            });
			
            finalObj.invoiceLineItems = tripLineArray;
            
           //return;
            
            $.ajax({
                type: "POST",
                data: JSON.stringify(finalObj),
                url: "<%=GlobalUrl.updateInvoice%>",
                dataType: "json",
                contentType: "application/json",
                success: function(response) {

                    if (response.msg == 'success') {
                        swal.fire("", "Remarks/Documents Successfully Submitted", "success", "OK").then(function() {
                            window.opener.refereshList();
                            window.close();
                        });
                        setTimeout(function(response) {}, 2000);
                    } else {
                        alert("failed");
                    }
                },
                error: function(jqXHR, textStatue, errorThrown) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Something went wrong!',
                    })
                }
            });
        }
        
        function updateTextData(index, textValue) {
            tripLineArray[index].lineLevelDescription = textValue.trim();
        }
        
        function calculateInvoice() {
            var taxAmount = $("#taxAmount").val();
            var taxableAmount = $("#taxableAmount").val();
            var taxAmount= parseFloat(taxableAmount) *  (parseFloat(taxAmount) /100);
            var finalInvoiceAmount = parseFloat(taxableAmount) +  parseFloat(taxAmount) ;
            $("#invoiceAmount").val(parseFloat(finalInvoiceAmount).toFixed(2));
        } 
        