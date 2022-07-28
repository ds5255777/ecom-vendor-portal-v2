package com.main.email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class CommEmailFunction {
	
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
			// session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, parse);

			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MMM-dd HH:mm");
			message.setSubject(subject);
			message.setContent(content, "text/html");
			// send the message
			Transport.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
