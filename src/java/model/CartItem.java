package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartItem {
        private String type;
    private String id;
    private String name;
    private double price;
    private String image;

    public CartItem(String type, String id, String name, double price, String image) {
        this.type = type;
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
    }

}