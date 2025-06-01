/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author DELL
 */
@Getter
@Setter
public class TokenForgetPassword {    
    private int id;
    private boolean isUsed;
    private String token,user_id;
    private  LocalDateTime expiryTime;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(int id, boolean isUsed, String token, String user_id, LocalDateTime expiryTime) {
        this.id = id;
        this.isUsed = isUsed;
        this.token = token;
        this.user_id = user_id;
        this.expiryTime = expiryTime;
    }
    public TokenForgetPassword(boolean isUsed, String token, String user_id, LocalDateTime expiryTime) {
        this.isUsed = isUsed;
        this.token = token;
        this.user_id = user_id;
        this.expiryTime = expiryTime;
    }
    
    
}
