package com.main.email;

import java.time.format.DateTimeFormatter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.main.controller.SchedularController;

public class CommEmailFunction {

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(SchedularController.class);
	public static void sendEmail(String commaSeparatedEamilName, String subject, String content, String smtpPort,
			String username, String password, String host) {

		try {

			InternetAddress[] parse = InternetAddress.parse(commaSeparatedEamilName, true);

			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", smtpPort);
			props.put("mail.smtp.starttls.enable", "true");
			Session session = Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			});

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, parse);

			message.setSubject(subject);
			message.setContent(content, "text/html");
			Transport.send(message);

		} catch (Exception e) {
			logger.error("error : " + e);
		}

	}
}
