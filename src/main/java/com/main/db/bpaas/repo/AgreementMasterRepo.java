package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.AgreementMaster;

public interface AgreementMasterRepo extends JpaRepository<AgreementMaster, Long> {
	@Query(value = "select  * from agreement_master where vendor_code=:Vendor_Code and route=:Route", nativeQuery = true)
	AgreementMaster getAllTripsByVendorCode(@Param("Vendor_Code") String vendorCode, @Param("Route") String route);

	AgreementMaster findByVendorCodeAndRouteAndVehicleTypeIgnoreCaseAndStatusIgnoreCase(String vendorCode, String route, String vehicleType,
			String status);

}
