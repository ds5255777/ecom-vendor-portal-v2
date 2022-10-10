var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');

$( "#invalidateForm" ).on( "click", function() {
	 document.forms['logoutForm'].submit();
});

function GetSelectedTextValue() {
	var tripStatus=$("#selectTripStatus").val();
	var selectStatus=$("#selectStatus").val();
	var selectPaymentStatus=$("#selectPaymentStatus").val();
	var vendorCode = $("#vendorCode").val();
    var obj={
    		"runStatus":tripStatus,
    		"vendorTripStatus":selectStatus,
    		"paymentStatus":selectPaymentStatus,
    		"vendorCode": vendorCode
    }
 console.log("Select Status : ",obj);

    $('.loader').show();
    $.ajax({
        type: "POST",
        url:"<%=GlobalUrl.status%>",
        dataType: "json",
           headers: { 'X-XSRF-TOKEN': csrfToken },
        contentType: "application/json",
        data: JSON.stringify(obj),
        success: function(data) {

        	console.log("data : ",data);

            $('.loader').hide();
            if (data.msg == "success") {
                var result = data.data;
                tabledata.clear();
                for (var i = 0; i < result.length; i++) {
                	var view = "<a href=\"#\" data-toggle=\"modal\" data-target=\"#tripValue\" onclick=\"setTripStatus('" + result[i].tripID + "')\" >" + result[i].tripID + "</button>";
                    var statustemp_payment_success = '<span class=\"right badge badge-success\">Approved</span>';
                    var statustemp_payment_Pending = '<span class=\"right badge badge-warning\">Pending</span>';
                    var statustemp_payment_No = '<span class=\"right badge badge-primary\">NA</span>';

                    var statustemp_runststus_Intransit = '<span class=\"right badge badge-warning\">In-Transit</span>';
                    var statustemp_runststus_Closed = '<span class=\"right badge badge-success\">Closed</span>';

                    var statustemp_pending = '<span class=\"right badge badge-warning\">Yet To Be Approved</span>';
                    var statustemp_approved = '<span class=\"right badge badge-success\">Approved</span>';
                    var statustemp_Invoicing = '<span class=\"right badge badge-primary\">Invoicing</span>';
                    var statustemp_Draft_Invoicing = '<span class=\"right badge badge-danger\">Draft-Invoicing</span>';
                    var statustemp_query = '<span class=\"right badge badge-warning\"  style=\"background-color: violet;\">Query</span>';

                    var paymentStatus = "";
                    var runStatus = "";
                    var vendorTripStatus = "";

                    var tempString = [view, result[i].route, result[i].runType, runStatus, status, result[i].actualDeparture, result[i].actualKM, result[i].standardKM, result[i].originHub, result[i].destHub, paymentStatus];

                    if (result[i].paymentStatus == "Pending") {
                        tempString[10] = statustemp_payment_Pending;
                    } else if (result[i].paymentStatus == "Approved") {
                        tempString[10] = statustemp_payment_success;
                    } else if (result[i].paymentStatus == "NA") {
                        tempString[10] = statustemp_payment_No;
                    }

                    if (result[i].vendorTripStatus == "Yet To Be Approved") {
                        tempString[4] = statustemp_pending;
                    } else if (result[i].vendorTripStatus == "Approved") {
                        tempString[4] = statustemp_approved;
                    } else if (result[i].vendorTripStatus == "Invoicing") {
                        tempString[4] = statustemp_Invoicing;
                    } else if (result[i].vendorTripStatus == "Query") {
                        tempString[4] = statustemp_query;
                    } else if (result[i].vendorTripStatus == "Draft-Invoicing") {
                        tempString[4] = statustemp_Draft_Invoicing;
                    }

                    if (result[i].runStatus == "In-Transit") {
                        tempString[3] = statustemp_runststus_Intransit;
                    } else if (result[i].runStatus == "Closed") {
                        tempString[3] = statustemp_runststus_Closed;
                    }
                    
                    tabledata.row.add(tempString);
                }
                tabledata.draw();
                $("tbody").show();
            } else {
                alert("failed");
            }
        },
        error: function(jqXHR, textStatue, errorThrown) {
            alert("failed, please try again");
        }
    });
}


function goToNewPage()
{
	
    var url = document.getElementById('list').value;
    if(url != 'none') {
        window.location = url;
    }
}

