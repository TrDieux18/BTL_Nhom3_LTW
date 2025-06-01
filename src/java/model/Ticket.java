package model;

import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Ticket {

    private Integer id;
    private String airline;
    private String origin;
    private String destination;
    private LocalDateTime departuretime;
    private LocalDateTime arrivetime;
    private String type;
    private String price;
    private String estimatedtime;
    private String image;
    private LocalDateTime modifiedDate;
    private String createdBy;

    public Ticket() {
    }

    public Ticket(String airline, String origin, String destination, LocalDateTime departuretime, LocalDateTime arrivetime, String type, String price) {
        this.airline = airline;
        this.origin = origin;
        this.destination = destination;
        this.departuretime = departuretime;
        this.arrivetime = arrivetime;
        this.type = type;
        this.price = price;
    }

    public Ticket(String airline, String origin, String destination, LocalDateTime departuretime, LocalDateTime arrivetime, String type, String price, String image) {
        this.airline = airline;
        this.origin = origin;
        this.destination = destination;
        this.departuretime = departuretime;
        this.arrivetime = arrivetime;
        this.type = type;
        this.price = price;
        this.image = image;
    }
    
}
