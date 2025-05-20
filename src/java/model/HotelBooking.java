/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author pc
 */
@Getter 
@Setter
public class HotelBooking {
    
    private Integer id;
    
    private Integer userId;
    
    private String userName;
    
    private Integer hotelId;
    
    private String hotelName;
    
    private String checkInDate, checkOutDate;
    
    private Integer roomQuantity;
    
    private Long totalPrice;
    
    private String status;
    
    private String bookingDate;
    
    private String notes;
    
}
