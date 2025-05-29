/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class TicketFlight {
    private String id;
    private String diemDi;
    private String diemHa;
    private String thoiGian;
    private double giaTien;
    private int giamGia;
    private Category category;

    // Constructors
    public TicketFlight() {}

    public TicketFlight(String id, String diemDi, String diemHa, String thoiGian, double giaTien, int giamGia, Category category) {
        this.id = id;
        this.diemDi = diemDi;
        this.diemHa = diemHa;
        this.thoiGian = thoiGian;
        this.giaTien = giaTien;
        this.giamGia = giamGia;
        this.category = category;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getDiemDi() {
        return diemDi;
    }
    public void setDiemDi(String diemDi) {
        this.diemDi = diemDi;
    }

    public String getDiemHa() {
        return diemHa;
    }
    public void setDiemHa(String diemHa) {
        this.diemHa = diemHa;
    }

    public String getThoiGian() {
        return thoiGian;
    }
    public void setThoiGian(String thoiGian) {
        this.thoiGian = thoiGian;
    }

    public double getGiaTien() {
        return giaTien;
    }
    public void setGiaTien(double giaTien) {
        this.giaTien = giaTien;
    }

    public int getGiamGia() {
        return giamGia;
    }
    public void setGiamGia(int giamGia) {
        this.giamGia = giamGia;
    }
}
