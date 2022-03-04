package com.main.db.bpaas.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "WIHistory")

@NamedQueries({ 
    @NamedQuery(name = "WIHistory.findComHis", query = "select t from WIHistory t where t.wiId = :wiId ORDER BY t.addedOn DESC")
})
public class WIHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long wiId;
    private String comment;
    private String status;
    private String byuser;
    private String touser;
    private Date addedOn = new Date();
    
    @JsonIgnore
    @ManyToOne
    @JoinColumn
    private SupDetails supDetails;

    public SupDetails getSupDetails() {
        return supDetails;
    }

    public void setSupDetails(SupDetails supDetails) {
        this.supDetails = supDetails;
    }
    
    

    public Long getWiId() {
        return wiId;
    }

    public void setWiId(Long wiId) {
        this.wiId = wiId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getByuser() {
        return byuser;
    }

    public void setByuser(String byuser) {
        this.byuser = byuser;
    }

    public String getTouser() {
        return touser;
    }

    public void setTouser(String touser) {
        this.touser = touser;
    }

    public Date getAddedOn() {
        return addedOn;
    }

    public void setAddedOn(Date addedOn) {
        this.addedOn = addedOn;
    }

}
