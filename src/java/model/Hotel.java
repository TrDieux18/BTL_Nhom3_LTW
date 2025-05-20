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
    private Integer id;

    private String name, address, contact_info, rating, price_per_night, createdBy;

    public Hotel() {
    }

    public Hotel(String name, String address, String contact_info, String rating, String price_per_night) {
        this.name = name;
        this.address = address;
        this.contact_info = contact_info;
        this.rating = rating;
        this.price_per_night = price_per_night;
    }

}
