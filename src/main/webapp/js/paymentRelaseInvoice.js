var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');



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
                "pageLength": 100,
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
                var jsArray = [];
                $('.loader').show();
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsArray),
                    url: "poController/getAllInvoiceDetails",
                    dataType: "json",
                    headers: { 'X-XSRF-TOKEN': csrfToken },
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
                            	 if (!result[i].hasOwnProperty("poNumber")) {
                                     result[i].poNumber = "";
                                 }
                            	 if (!result[i].hasOwnProperty("vendorInvoiceNumber")) {
                                     result[i].vendorInvoiceNumber = "";
                                 }
                                if (!result[i].hasOwnProperty("vendorCode")) {
                                    result[i].vendorCode = "";
                                }
                                if (!result[i].hasOwnProperty("vendorName")) {
                                    result[i].vendorName = "";
                                }
                                if (!result[i].hasOwnProperty("supplierSite")) {
                                    result[i].supplierSite = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceDate")) {
                                    result[i].invoiceDate = "";
                                }
                                if (!result[i].hasOwnProperty("invoiceAmount")) {
                                    result[i].invoiceAmount = "";
                                }
                                 if (!result[i].hasOwnProperty("status")) {
                                    result[i].status = "";
                                }
                               
                          	
                                var view = "<a href=\"#\" data-toggle=\"modal\" class=\"paymentinvnum\"  data-target=\"#tripValue\" onclick=\"getInvoiceDataFormDataByInvoiceNumber('" + result[i].invoiceNumber + "')\" >" + result[i].invoiceNumber + "</button>";

                                tabledata.row.add([view,result[i].poNumber,result[i].vendorInvoiceNumber,result[i].vendorCode,  result[i].supplierSite, result[i].invoiceDate,result[i].invoiceAmount,result[i].status]);
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

            function getInvoiceDataFormDataByInvoiceNumber(id) {
                $('.loader').show();
            	var status="In-Review";
				var ob =[];
				ob.push(id);
				ob.push(status);
                
                var urlOftripsDetail = "invoiceViewPo?ob=" + ob;
                window.open(urlOftripsDetail, "invoiceViewPo", 'height=' + (screen.height - 110) + ',width=' + (screen.width - 15) + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
                $('.loader').hide();
            }
            
            $('#tabledata tbody').on('click', ".paymentinvnum", function() {
	var row = $(this).parents('tr')[0];
	//console.log(row.cells[0].innerText);
	//console.log(tabledata.row(row).data().id);
	getInvoiceDataFormDataByInvoiceNumber(row.cells[0].innerText);
    });
        