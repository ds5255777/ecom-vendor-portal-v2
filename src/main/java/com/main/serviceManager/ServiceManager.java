package com.main.serviceManager;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.repo.AddressDetailsRepo;
import com.main.db.bpaas.repo.AdharLinkStatusRepo;
import com.main.db.bpaas.repo.AgreementMasterRepo;
import com.main.db.bpaas.repo.BusinessClassificationRepo;
import com.main.db.bpaas.repo.BusinessPartnerRepo;
import com.main.db.bpaas.repo.BusinessPartnerTypeRepo;
import com.main.db.bpaas.repo.CountryRepo;
import com.main.db.bpaas.repo.CurrencyRepo;
import com.main.db.bpaas.repo.DocumentRepo;
import com.main.db.bpaas.repo.EmailAuditLogsRepo;
import com.main.db.bpaas.repo.EmailConfigurationRepository;
import com.main.db.bpaas.repo.FinancialYearRepo;
import com.main.db.bpaas.repo.FlagRepo;
import com.main.db.bpaas.repo.InvoiceGenerationEntityRepo;
import com.main.db.bpaas.repo.InvoiceLineItemRepo;
import com.main.db.bpaas.repo.InvoiceNumberRepo;
import com.main.db.bpaas.repo.MailContentRepo;
import com.main.db.bpaas.repo.PaymentMethodRepo;
import com.main.db.bpaas.repo.PaymentTermRepo;
import com.main.db.bpaas.repo.PoDetailsRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;
import com.main.db.bpaas.repo.PoLineItemRepo;
import com.main.db.bpaas.repo.ProcessMaxLevelRepo;
import com.main.db.bpaas.repo.QueryRepo;
import com.main.db.bpaas.repo.RegionRepo;
import com.main.db.bpaas.repo.RolesRepository;
import com.main.db.bpaas.repo.SectionTypeRepo;
import com.main.db.bpaas.repo.SendEmailRepo;
import com.main.db.bpaas.repo.SendEmailToVendorRepo;
import com.main.db.bpaas.repo.StateRepo;
import com.main.db.bpaas.repo.SupDetailsRepo;
import com.main.db.bpaas.repo.TDSSectionCodeRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.db.bpaas.repo.UserLevelRepo;
import com.main.db.bpaas.repo.UserRepository;
import com.main.service.InvoiceServiceImpl;
import com.main.service.SecurityService;
import com.main.service.TripService;
import com.main.service.UserService;

@Service
public class ServiceManager {

	@Autowired
	public UserRepository userRepository;

	@Autowired
	public RolesRepository rolesRepository;

	@Autowired
	public EmailConfigurationRepository emailConfigurationRepository;

	@Autowired
	public SupDetailsRepo detailsRepo;

	@Autowired
	public SecurityService securityService;

	@Autowired
	public BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	public UserService userService;

	@Autowired
	public TripDetailsRepo tripDetailsRepo;

	@Autowired
	public InvoiceGenerationEntityRepo invoiceGenerationEntityRepo;

	@Autowired
	public InvoiceLineItemRepo invoiceLineItemRepo;

	@Autowired
	public TripService tripService;

	@Autowired
	public CurrencyRepo currencyRepo;

	@Autowired
	public BusinessPartnerTypeRepo businessPartnerTypeRepo;

	@Autowired
	public BusinessPartnerRepo businessPartnerRepo;

	@Autowired
	public BusinessClassificationRepo businessClassificationRepo;

	@Autowired
	public PaymentTermRepo paymentTermRepo;

	/*
	 * @Autowired public NatureOfTransactionRepo natureOfTransactionRepo;
	 */
	@Autowired
	public CountryRepo countryRepo;

	@Autowired
	public TDSSectionCodeRepo tDSSectionCodeRepo;

	@Autowired
	public FinancialYearRepo financialYearRepo;

	@Autowired
	public SupDetailsRepo supDetailsRepo;

	@Autowired
	public QueryRepo queryRepo;

	@Autowired
	public InvoiceServiceImpl invoiceServiceImpl;

	@Autowired
	public AgreementMasterRepo agreementMasterRepo;

	@Autowired
	public DocumentRepo documentRepo;

	@Autowired
	public PoInvoiceRepo poinvoiceRepo;

	@Autowired
	public PoDetailsRepo podetailsRepo;

	@Autowired
	public PoLineItemRepo poLineItemRepo;
	
	@Autowired
	public SendEmailRepo sendEmailRepo;
	
	@Autowired
	public EmailAuditLogsRepo emailAuditLogsRepo;
	
	@Autowired
	public MailContentRepo mailContentRepo;
	
	@Autowired
	public AddressDetailsRepo addressDetailsRepo;
	
	@Autowired
	public AdharLinkStatusRepo adharLinkStatusRepo;
	
	@Autowired
	public RegionRepo regionRepo;
	
	@Autowired
	public SectionTypeRepo sectionTypeRepo;
	
	@Autowired
	public PaymentMethodRepo paymentMethodRepo;
	
	@Autowired
	public FlagRepo flagRepo;
	
	@Autowired
	public StateRepo stateRepo;

	@Autowired
	public InvoiceNumberRepo invoiceNumberRepo;
	
	@Autowired
	public UserLevelRepo userLevelRepo;
	
	@Autowired
	public ProcessMaxLevelRepo processMaxLevelRepo;
	
	@Autowired
	public ModelMapper modelMapper;
	
	@Autowired
	public SendEmailToVendorRepo sendEmailToVendorRepo; 


	/*
	 * public void insertRecordIntoAuditEntry(HttpServletRequest request, String
	 * action, String actionType, String remarks, String ticketId, Integer
	 * ticketQueueId) {
	 * 
	 * String userName = (String) request.getSession().getAttribute("userName");
	 * Integer userId = (Integer) request.getSession().getAttribute("userId");
	 * 
	 * }
	 * 
	 * public void insertAddUpdateInMaster(HttpServletRequest request, String
	 * action, String actionType, String remarks, String newValue, String oldValue)
	 * {
	 * 
	 * String userName = (String) request.getSession().getAttribute("userName");
	 * Integer userId = (Integer) request.getSession().getAttribute("userId"); // }
	 */

}
