package com.main.commonclasses;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.main.db.bpaas.entity.EmailConfiguration;

public class CommanFunction {

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(CommanFunction.class);

	public static void sendEmail(EmailConfiguration emailObj, String commaSeparatedEamilName,
			String commaSeparatedCCEamilID, String commaSeparatedBCCEamilID, String subject, String content) {

		try {

			String toEmail = "";
			String ccEmail = "";

			toEmail = commaSeparatedEamilName;
			ccEmail = commaSeparatedCCEamilID;

			InternetAddress[] parseToEmail = InternetAddress.parse(toEmail, true);

			Properties props = new Properties();
			props.put("mail.smtp.host", emailObj.getServerName());
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", emailObj.getSmtpPort());
			props.put("mail.smtp.starttls.enable", "true");
			Session session = Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(emailObj.getUserName(), emailObj.getPassword());
				}
			});

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(emailObj.getUserName()));
			message.setRecipients(Message.RecipientType.TO, parseToEmail);
			if (!"".equalsIgnoreCase(ccEmail)) {

				InternetAddress[] parseccEmail = InternetAddress.parse(ccEmail, true);
				message.setRecipients(Message.RecipientType.CC, parseccEmail);
			}

			if (!"".equalsIgnoreCase(commaSeparatedBCCEamilID)) {

				InternetAddress[] parseBccEmail = InternetAddress.parse(commaSeparatedBCCEamilID, true);
				message.setRecipients(Message.RecipientType.BCC, parseBccEmail);
			}

			message.setSubject(subject);
			message.setContent(content, "text/html");
			Transport.send(message);

		} catch (Exception e) {
			logger.error("error : " + e);
		}

	}

	public static void sendEmailWithAttachment(EmailConfiguration emailObj, String commaSeparatedEamilName,
			String commaSeparatedCCEamilID, String commaSeparatedBCCEamilID, String subject, String content,
			List<String> filenameAndPathList, List<String> filenameList) {

		try {

			String toEmail = "";
			String ccEmail = "";

			toEmail = commaSeparatedEamilName;
			ccEmail = commaSeparatedCCEamilID;

			InternetAddress[] parseToEmail = InternetAddress.parse(toEmail, true);

			Properties props = new Properties();
			props.put("mail.smtp.host", emailObj.getServerName());
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", emailObj.getSmtpPort());
			props.put("mail.smtp.starttls.enable", "true");
			Session session = Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(emailObj.getUserName(), emailObj.getPassword());
				}
			});
			// session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(emailObj.getUserName()));
			message.setRecipients(Message.RecipientType.TO, parseToEmail);
			if (!"".equalsIgnoreCase(ccEmail)) {

				InternetAddress[] parseccEmail = InternetAddress.parse(ccEmail, true);
				message.setRecipients(Message.RecipientType.CC, parseccEmail);
			}

			if (!"".equalsIgnoreCase(commaSeparatedBCCEamilID)) {

				InternetAddress[] parseBccEmail = InternetAddress.parse(commaSeparatedBCCEamilID, true);
				message.setRecipients(Message.RecipientType.BCC, parseBccEmail);
			}

			message.setSubject(subject);
			Multipart multipart = new MimeMultipart();
			BodyPart messageBodyPart = new MimeBodyPart();

			messageBodyPart.setContent(content, "text/html");
			multipart.addBodyPart(messageBodyPart);

			for (int i = 0; i < filenameAndPathList.size(); i++) {

				messageBodyPart = new MimeBodyPart();

				DataSource source = new FileDataSource(filenameAndPathList.get(i));
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(filenameList.get(i));
				multipart.addBodyPart(messageBodyPart);

			}
			message.setContent(multipart);
			Transport.send(message);

		} catch (Exception e) {
			logger.error("error : " + e);
		}

	}
}
