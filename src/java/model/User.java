/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author DELL
 */
@Getter
@Setter
public class User {
    private Integer id;
    private String fullname,username,email,phonenumber,password,address,status;
    private int roleId;

    public User() {
    }

    public User(String fullname, String username, String email, String phonenumber, String password, String address, String status, int roleId) {
          
        this.fullname = fullname;
        this.username = username;
        this.email = email;
        this.phonenumber = phonenumber;
        this.password = password;
        this.address = address;
        this.status = status;
        this.roleId = roleId;
    }


}
