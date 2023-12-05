package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "verifiers")
public class Verifier {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "verifier_name")
    private String verifierName;
    
    @Column(name = "email_id")
    private String emailId;
    
    @Column(name = "region_id")
    private Integer regionId;
    
    @Column(name = "region_name")
    private String regionName;
  
    @Column(name="status")
    private String status;

    @ManyToOne
    @JoinColumn(name = "region_id", referencedColumnName = "id", insertable = false, updatable = false)
    private Region region;

}
