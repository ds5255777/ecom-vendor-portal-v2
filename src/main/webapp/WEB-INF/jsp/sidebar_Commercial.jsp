<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

	<a href="dashboard" class="brand-link"> <img src="${logoPath}"
		alt="AdminLTE Logo" class="brand-image navbar-brand brand-logo-mini">
		<span class="brand-text font-weight-light">${sideLogoName}</span>
	</a>

	<div class="sidebar">
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">


				<ul class="nav nav-pills nav-sidebar flex-column"
					data-widget="treeview" role="menu" data-accordion="false">

					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/"
						class="nav-link
                                        <% if (request.getParameter("pagename").equalsIgnoreCase("triggerEmail")) {
                                                out.print("active");
                                            }%>
                                        ">
							<i class="nav-icon fas fa-tachometer-alt"> </i>
							<p>Dashboard</p>
					</a>
						<hr></li>


					<%-- <li class="nav-item"><a href="vendorRegistrastion"
						target="_blank" rel="noopener noreferrer"
						class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("vendorRegistrastion")) {
	out.print("active");
}%>                            
                            ">


							<i class="nav-icon fas fa-registered"></i>

							<p>Vendor Registrastion</p>
					</a></li> --%>



					 <li class="nav-item"><a href="supplierRegistration"
						target="_blank" rel="noopener noreferrer"
						class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("supplierRegistration")) {
	out.print("active");
}%>                            
                            ">


							<i class="nav-icon fas fa-registered"></i>

							<p>Supplier Registrastion</p>
					</a></li> 


					<li class="nav-item"><a href="vendorList"
						class="nav-link
                            <%if (request.getParameter("pagename").equalsIgnoreCase("commercialTeam")) {
	out.print("active");
}%>                            
                            ">
							<i class="nav-icon fa fa-user-circle"></i>
							<p>Vendor-List</p>
					</a>
						<hr></li>




				</ul>
		</nav>
	</div>
</aside>
