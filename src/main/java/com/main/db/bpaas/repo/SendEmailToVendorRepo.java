package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.SendEmailToVendor;

public interface SendEmailToVendorRepo extends JpaRepository<SendEmailToVendor, Integer> {

}
