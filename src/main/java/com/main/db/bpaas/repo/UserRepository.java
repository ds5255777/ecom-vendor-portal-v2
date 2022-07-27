package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);

	@Transactional
	@Modifying
	@Query(value = "update users set status=:status where id=:id ; ", nativeQuery = true)
	void updateStatusByUserid(@Param("status") String status, @Param("id") Integer id);

	User findByUsernameAndStatusNot(String username, String string);

	User findByUsernameAndStatusIn(String username, List<String> userStatusList);

	@Query(value = "select password from users where id=:id ; ", nativeQuery = true)
	String getUserPasswordById(@Param("id") Integer id);

	@Query(value = "select * from users where role_id !='2' and status in(:userStatusList) ; ", nativeQuery = true)
	List<User> findByStatusIn(List<String> userStatusList);

	// for postgress
	@Query(value = "select username from users where username ~*:username and status in(:userStatusList) ; ", nativeQuery = true)
	String checkForExistingUserName(@Param("username") String username,
			@Param("userStatusList") List<String> userStatusList);

	/*
	 * // for sql server
	 * 
	 * @Query(
	 * value="select username from users where username =:username COLLATE SQL_Latin1_General_CP1_CI_AS and status in(:userStatusList) ; "
	 * , nativeQuery=true) String checkForExistingUserName(@Param("username") String
	 * username, @Param("userStatusList") List<String> userStatusList);
	 * 
	 */
	User findByUsernameIgnoreCaseAndStatusIn(String username, List<String> userStatusList);

	@Query(value = "select u.id,u.username from users u ,roles r where r.id=u.role_id and r.role_name=:role ; ", nativeQuery = true)
	List<Object[]> getByRoleName(@Param("role") String role);

	@Query(value = "select u.* from users u, roles r where u.role_id=r.id and r.role_name=:role and u.status in(:userStatusList) ; ", nativeQuery = true)
	List<User> getUsersByRole(@Param("role") String role, @Param("userStatusList") List<String> userStatusList);

	List<User> findByRoleIdAndStatus(Integer roleId, String status);

	@Query(value = "select id from users where role_id=:roleId and status=:activeStatus ; ", nativeQuery = true)
	List<Integer> filterUserIdByRoleIdAndStatus(Integer roleId, String activeStatus);

	@Query(value = "select email_id from users u, roles r where u.email_id is not null and u.email_id !='' and u.role_id=r.id and u.status=:status and r.role_name=:role ; ", nativeQuery = true)
	List<String> getEmailIdByRole(@Param("role") String role, @Param("status") String status);

	@Query(value = "select u.* from users u, map_project_user mpu, roles r where  u.status in (:userStatusList) and u.role_id=r.id  and r.role_name=:role and mpu.userid=u.id  and mpu.project_foreign_key=:projectForeignKey and mpu.site_foreign_key=:siteForeignKey and mpu.status=:activeStatus ; ", nativeQuery = true)
	List<User> getUsersByRoleAndProjectAndSite(@Param("role") String roleInternalInspector,
			@Param("userStatusList") List<String> userStatusList, @Param("activeStatus") String activeStatus,
			@Param("projectForeignKey") Integer projectForeignKey, @Param("siteForeignKey") Integer siteForeignKey);

	@Query(value = "select u.* from users u,  roles r where  u.status in (:userStatusList) and u.role_id=r.id and r.role_name=:role and u.id not in(select distinct mpu.userid from map_project_user mpu where  mpu.status=:activeStatus ) ; ", nativeQuery = true)
	List<User> getUsersByRoleAndAllProjectAndSite(@Param("role") String role,
			@Param("userStatusList") List<String> userStatusList, @Param("activeStatus") String activeStatus);

	@Query(value = "select email_id from users where id=:id ; ", nativeQuery = true)
	String getemailIdById(@Param("id") Integer id);

	// Manish added
	@Query(value = "select count(*) from users where role_id !='2'; ", nativeQuery = true)
	int getCountForAllUsers();

	@Query(value = "select count(*) from users where status='1' and role_id !='2'; ", nativeQuery = true)
	int getCountForAllActiveUsers();

	@Query(value = "select count(*) from users where status='0' and role_id !='2'; ", nativeQuery = true)
	int getCountForAllInActiveUsers();

	@Query(value = "select count(*) from users where bp_code!='' and role_id ='2';", nativeQuery = true)
	int getAllVendorCount();

	@Query(value = "select count(*) from users where bp_code!='' and status in('1','3')  and role_id ='2' ; ", nativeQuery = true)
	int getAllActiveVendorCount();

	@Query(value = "select count(*) from users where bp_code!='' and status= '0'  and role_id ='2' ", nativeQuery = true)
	int getAllInActiveVendorCount();
	// End

	@Query(value = "select bp_code from users where username=:uname ; ", nativeQuery = true)
	String getBpCode(@Param("uname") String uname);

	@Transactional
	@Modifying
	@Query(value = "update users set status=:status where bp_code=:bpCode ; ", nativeQuery = true)
	void updateStatusOfVendorByBpCode(@Param("status") String status, @Param("bpCode") String bpcode);

	@Transactional
	@Modifying
	@Query(value = "update supdetails set flag=:flag where bp_code=:bpCode ; ", nativeQuery = true)
	void updateFlagOfVendorByBpCode(@Param("flag") String flag, @Param("bpCode") String bpcode);

	@Query(value = "select * from users where bp_code=:bpCode ; ", nativeQuery = true)
	List<User> getAllVendorStatus(@Param("bpCode") String bpCode);

	@Query(value = "select count(*) from supdetails ; ", nativeQuery = true)
	int getBpCode();

	/*
	 * @Query(value =
	 * "select id, username, vendor_name from users where role_id='2' order by id asc"
	 * , nativeQuery = true) List<Object[]> getVendorCodeVendorNameById(String
	 * vendorName);
	 */
	@Query(value = "select  id from Users where bp_code=:bpCode ", nativeQuery = true)
	Integer getUserId(String bpCode);

}
