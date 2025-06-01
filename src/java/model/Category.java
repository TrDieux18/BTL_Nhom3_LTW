/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class Category {
//    ID [int] primary key,
//	[diemdi] nvarchar (50),
    private int id;
    private String diemDi ;

    public Category() {
    }

    public Category(int id, String diemDi) {
        this.id = id;
        this.diemDi = diemDi;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDiemDi() {
        return diemDi;
    }

    public void setDiemdi(String diemDi) {
        this.diemDi = diemDi;
    }
    
    
}
