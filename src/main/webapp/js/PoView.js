var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');



        var prTable = $("#prTable").DataTable({
            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "autoWidth": false,
            "aaSorting": [],
            "scrollX": true,
            "pageLength": 15,
        });
        
        function closeWin() {
            window.close()
        }
        var poNo = '${poNumber}';
        var tripLineArray = [];
        setInvoiceDetails();

        function setInvoiceDetails() {

            var obj = {
                "poNo": poNo
            }
            $.ajax({
                type: "POST",
                data: JSON.stringify(obj),
                url: "<%=GlobalUrl.getAllPODetailsByPoNo%>",
                dataType: "json",
           headers: { 'X-XSRF-TOKEN': csrfToken },
                contentType: "application/json",
                async: false,
                success: function(data) {

                    if (data.msg == 'success') {
                        var result = data.data;
                       var tripLineArray=result[0].poline;
                        var myForm = "";
                        myForm = document.getElementById("stepOneForm");
                        setData(myForm, result[0]);
                    
                        myForm = document.getElementById("stepTwoForm");
                        setData(myForm, result[0]);
                        
                        $('#org2').val(result[0].org)
                         $('#uom2').val(result[0].uom)
                          $('#shipTo2').val(result[0].shipTo)
                           $('#quantity2').val(result[0].quantity);
                        
                        $('#needByDate2').val(result[0].needByDate)
                        $('#chargeAccount2').val(result[0].chargeAccount)
                     
                        myForm = document.getElementById("stepThreeForm");
                        setData(myForm, result[0]);
                        $('#deliverTo3').val(result[0].deliverTo)
                        $('#chargeAccount3').val(result[0].chargeAccount)
                        
                  
                      
                        $('#prTable').DataTable().clear();
                         for (var i = 0; i < tripLineArray.length; i++) {
                            if (!tripLineArray[i].hasOwnProperty("lineNumber")) {
                                tripLineArray[i].lineNumber = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("itemType")) {
                                tripLineArray[i].itemType = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("item")) {
                                tripLineArray[i].item = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("category")) {
                                tripLineArray[i].category = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("description")) {
                                tripLineArray[i].description = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("uom")) {
                                tripLineArray[i].uom = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("quantity")) {
                                tripLineArray[i].quantity = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("price")) {
                                tripLineArray[i].price = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("needByDate")) {
                                tripLineArray[i].needByDate = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("amount")) {
                                tripLineArray[i].amount = "";
                            }
                            if (!tripLineArray[i].hasOwnProperty("chargeAccount")) {
                                tripLineArray[i].chargeAccount = "";
                            } if (!tripLineArray[i].hasOwnProperty("remaningQuatity")) {
                                tripLineArray[i].remaningQuatity = "";
                            }
                            
                            $('#prTable').DataTable().row.add([tripLineArray[i].lineNumber, tripLineArray[i].itemType, tripLineArray[i].item, tripLineArray[i].category, tripLineArray[i].description, tripLineArray[i].uom, tripLineArray[i].quantity,tripLineArray[i].remaningQuatity ,tripLineArray[i].price, tripLineArray[i].needByDate, tripLineArray[i].amount, tripLineArray[i].chargeAccount]);
                        }
                        $('#prTable').DataTable().draw();
                        $("tbody").show();
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
        
        function invoiceProcessing() {
        	var a=$("#poNo").val();
        	var b=$("#supplierSite").val();
        	var c=$("#shipTo").val();
        	var d=$("#billTo").val();
        	var e=$("#buyer").val();
        	var f=$("#currency").val();

        	var g=$("#uom").val();
        	var h=$("#quantity").val();
        	var i=$("#needByDate").val();
        	var j=$("#chargeAccount").val();
        	var k=$("#org").val();
        	var l=$("#deliverTo").val();

        	var m=$("#amount").val();
        	var n=$("#matchApprovalLevel").val();
        	var o=$("#invoiceMatchoption").val();
        	var p=$("#accrueatReceiptflag").val();
        	var q=$("#itemType").val();
        if(a==""|| a==null){
        a="Po Number,";
        }else{
        a="";
        }if(b==""|| b==null){
        b="Supplier Site,";
        }else{
        b="";
        }if(c==""|| c==null){
        c="Ship To,";
        }else{
        c="";
        }if(d==""|| d==null){
        d="Bill To,";
        }else{
        d="";
        }if(e==""|| e==null){
        e="Buyer,";
        }else{
        e="";
        }if(f==""|| f==null){
        f="Currency,";
        }else{
        f="";
        }if(g==""|| g==null){
        g="UOM,";;
        }else{
        g="";
        }if(h==""|| h==null){
        h="Quantity,";
        }else{
        h="";
        }if(i==""|| i==null){
        i="Need By Date,";
        }else{
        i="";
        }if(j==""|| j==null){
        j="Charge Account,";
        }else{
        j="";
        }if(k==""|| k==null){
        k="Org,";
        }else{
        k="";
        }if(l==""|| l==null){
        l="Deliver To,";
        }else{
        l="";
        }if(m==""|| m==null){
        m="Amount,";
        }else{
        m="";
        }if(n==""|| n==null){
        n="Match Approval Level,";
        }else{
        n="";
        }if(o==""|| o==null){
        o="Invoice Match Option,";
        }else{
        o="";
        }if(p==""|| p==null){
        p="Accrueat Receipt Flag,";
        }else{
        p="";
        }if(q==""|| q==null){
        q="Item Type,";
        }else{
        q="";
        }
        	
        	
	        	if(a==""|| a==null || b=="" || b==null || c==""|| c==null || d=="" || d==null || e==""|| e==null || f=="" || f==null ||
	        	g==""|| g==null || h=="" || h==null || i==""|| i==null || j=="" || j==null || k==""|| k==null || l=="" || l==null ||
	        	m==""|| m==null || n=="" || n==null || o==""|| o==null || p=="" || p==null || q==""|| q==null ){
	        		
	        		
	        			 
	        			 Swal.fire({
	        				  title: 'Are you sure to Confirm?',
	        		  		  text: ""+a+""+b+""+c+""+d+""+e+""+f+""+g+""+h+""+i+""+j+""+k+""+l+""+m+""+n+""+o+""+p+""+q+" Field(s) Vales Are Blank",
	        				  icon: 'warning',
	        				  showCancelButton: true,
	        				  confirmButtonColor: '#3085d6',
	        				  cancelButtonColor: '#d33',
	        				  confirmButtonText: 'Yes'
	        				}).then((result) => {
	        					
	        					let test=[1];
	        					test[0]=result;
	        					var val=Object.values(test[0])
	        				  if (val=="true") {
	        					  
	        					  $('#flipToInvoice').attr('disabled', false);
	        			        	
	        			            var table = document.getElementById('tabledata');
	        			            
	        			            $('.loader').hide();
	        			            var urlOftripsDetail = "poInvoiceGenerate?id=" + poNo;
	        			            window.open(urlOftripsDetail, "poInvoiceGenerate", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
	        			      		
	        			            $('#flipToInvoice').attr('disabled', true);
	        				  }
	        		 });
	        	}
        }
        
        function refreshParent() 
        {
            window.opener.location.reload(true);
            window.close();
        }
          
    