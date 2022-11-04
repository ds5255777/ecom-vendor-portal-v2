var csrfToken = document.cookie.replace(/(?:(?:^|.*;\s*)XSRF-TOKEN\s*\=\s*([^;]*).*$)|^.*$/, '$1');



                            $(document).ready(function () {
                                if ('${userStatus}' === 3) {
                                    $('#changePassword').modal('show');
                                }
                            });

                            $(function () {
                                $("#conpassword").keyup(function () {
                                    var password = $("#passwordch").val();
                                    if ($('#passwordch').val() == $('#conpassword').val()) {
                                        $('#divCheckPasswordMatch').html('Passwords match.').css('color', 'green');
                                    } else
                                        $('#divCheckPasswordMatch').html('Passwords do not match!').css('color', 'red');

                                });

                            });
        
            var tabledata = $('#tabledata').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "info": true,
                "autoWidth": false,
                "aaSorting": []
            });

            var unresolvedsts = $('#unresolvedsts').get(0).getContext('2d')
            var unresolvedstsData = {
                labels: [
                    'Approved Trips',
                    'Pending Approval',
                    'Query Trips',
                    'Closed(Adhoc) Trips'
                ],
                datasets: [{
                        data: [$("#TripsCount").val(),$("#ToBeApproved").val(),$("#TripCountForQueryAdhoc").val(),$("#ClosedTripCountForAdhoc").val() ],
                        backgroundColor: ['#00a65a', '#8d4f55', '#C422F4','#1477B0' ],
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

           

            function changePassword(password) {

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

       