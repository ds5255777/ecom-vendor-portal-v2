package com.main.service;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	public static synchronized String generateRandomPassword() throws NoSuchAlgorithmException {

		final Random rand = SecureRandom.getInstanceStrong();
		int password = 8;
		String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%&";

		StringBuilder sb = new StringBuilder(password);

		for (int i = 0; i < password; i++)
			sb.append(chars.charAt(rand.nextInt(chars.length())));
		
		return sb.toString();
	}

	@Override
	public void save(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		userRepository.save(user);
	}

	@Override
	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	@Override
	public User Update(User user, Integer id) {

		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		User save = userRepository.save(user);
		
		return save;
	}
}
