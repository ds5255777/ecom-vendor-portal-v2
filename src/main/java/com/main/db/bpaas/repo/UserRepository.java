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

	@Query(value = "select failed_attempt from users where username=:username ; ", nativeQuery = true)
	int failedAttemptCount(@Param("username") String username);

	@Transactional
	@Modifying
	@Query(value = "update users set failed_attempt=:count  where username=:username ; ", nativeQuery = true)
	void updateAttemptCount(String username, int count);

	@Transactional
	@Modifying
	@Query(value = "update users set status=:inactiveStatus  where username=:username ; ", nativeQuery = true)
	void updateUserStatus(String username, String inactiveStatus);

	User findByUsernameAndStatusNot(String username, String string);

	User findByUsernameAndStatusIn(String username, List<String> userStatusList);

	@Query(value = "select password from users where id=:id ; ", nativeQuery = true)
	String getUserPasswordById(@Param("id") Integer id);

	@Query(value = "select * from users where role_id !='2' and status in(:userStatusList) ; ", nativeQuery = true)
	List<User> findByStatusIn(List<String> userStatusList);

	// for postgress
	@Query(value = "select username from users where  LOWER(username)=LOWER(:username) ; ", nativeQuery = true)
	String checkForExistingUserName(@Param("username") String username);

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

	@Query(value = "select count(*) from users where role_id !='2'; ", nativeQuery = true)
	int getCountForAllUsers();

	@Query(value = "select count(*) from users where status='1' and role_id !='2'; ", nativeQuery = true)
	int getCountForAllActiveUsers();

	@Query(value = "select count(*) from users where status='0' and role_id !='2'; ", nativeQuery = true)
	int getCountForAllInActiveUsers();

	@Query(value = "select count(*) from supdetails where ven_status in('Approved','Update');", nativeQuery = true)
	int getAllVendorCount();

	@Query(value = "select count(*) from supdetails where ven_status in('Approved','Update') and flag='Active' ; ", nativeQuery = true)
	int getAllActiveVendorCount();

	@Query(value = "select count(*) from supdetails where ven_status in('Approved','Update') and flag='In-Active' ", nativeQuery = true)
	int getAllInActiveVendorCount();

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

	@Query(value = "select  id from Users where bp_code=:bpCode ", nativeQuery = true)
	Integer getUserId(String bpCode);

	@Transactional
	@Modifying
	@Query(value = "update users set password=:password, email_id=:emailId, contact_no=:contactNo, status=:status where id=:id and username=:username ;", nativeQuery = true)
	public void updateUserDetails(@Param("password") String password, @Param("emailId") String emailId,
			@Param("contactNo") String contactNo, @Param("status") String status, @Param("id") Integer id,
			@Param("username") String username);

	@Query(value = "select users.status from users where users.bp_code=:bpCode ; ", nativeQuery = true)
	String getVendorStatus(String bpCode);

	@Query(value = "select username from users where username ILIKE :bpCode ", nativeQuery = true)
	String checkUserName(String bpCode);

	@Query(value = "select email_id from users where username=:username ", nativeQuery = true)
	String getUserMailId(String username);

	@Query(value = "SELECT email_id FROM public.users where role_id=:i", nativeQuery = true)
	List<String> findbyRoleId(int i);
	
	@Transactional
	@Modifying
	@Query(value = "update users set password=:passwordUser where username=:bpCode and bp_code=:bpCode", nativeQuery = true)
	void updateVendorPassword(@Param("bpCode") String bpCode, @Param("passwordUser") String passwordUser);

	User findByBpCode(String bpCode);

}
