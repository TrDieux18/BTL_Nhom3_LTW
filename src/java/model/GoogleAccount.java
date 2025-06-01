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
public class GoogleAccount {
    private String id;
    private String email;
    private String name; // từ trường "name" Google trả về

    public GoogleAccount(String id, String email, String name) {
        this.id = id;
        this.email = email;
        this.name = name;
    }

    @Override
    public String toString() {
        return "GoogleAccount{" + "id=" + id + ", email=" + email + ", name=" + name + '}';
    }
    
    
}

