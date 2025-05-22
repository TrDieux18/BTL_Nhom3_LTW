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
public class BookingHistory {

    private Integer id;

    private Integer userId;

    private String userName;

    private Integer ticketId;

    private String origin, destination, typeTicket;

    private String payment, orderStatus;

    private Integer quantity;

    public BookingHistory() {
    }

    public BookingHistory(Integer userId, String userName, Integer ticketId, String origin, String destination, String typeTicket, String payment, String orderStatus, Integer quantity) {

        this.userId = userId;
        this.userName = userName;
        this.ticketId = ticketId;
        this.origin = origin;
        this.destination = destination;
        this.typeTicket = typeTicket;
        this.payment = payment;
        this.orderStatus = orderStatus;
        this.quantity = quantity;
    }

}
