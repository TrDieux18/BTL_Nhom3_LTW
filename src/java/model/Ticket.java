package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    private LocalDateTime modifiedDate;
    private String createdBy;
    private String image;

    public Ticket() {
    }

    public Ticket(String airline, String origin, String destination, LocalDateTime departuretime, String image,LocalDateTime arrivetime, String type, String price) {
        this.airline = airline;
        this.origin = origin;
        this.destination = destination;
        this.departuretime = departuretime;
        this.arrivetime = arrivetime;
        this.type = type;
        this.price = price;
    }
    
    public String getDeparturetimeString() {
    if (departuretime == null) return "";
    return departuretime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"));
}

}
