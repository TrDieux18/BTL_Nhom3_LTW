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
public class Hotel {

    private Integer id, roomsAvailable;

    private String name, address, contact_info, rating, createdBy, image;
    
    private Long price_per_night;

    public Hotel() {
    }

    public Hotel(String name, String address, String contact_info, String rating, Long price_per_night, String image, Integer roomsAvailable) {
        this.name = name;
        this.address = address;
        this.contact_info = contact_info;
        this.rating = rating;
        this.price_per_night = price_per_night;
        this.roomsAvailable = roomsAvailable;
    }

}
