/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.TicketFlight;
import model.TicketFlight_inter;

/**
 *
 * @author DELL
 */
public class TicketFlightDAO extends DBContext {
//lấy toàn bộ bảng category
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "select * from Categories";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt("id"), rs.getString("diemDi"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("e");
        }
        return list;
    }

    public Category getCategoryByID(int id) {
        String sql = "select * from Categories where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Category c = new Category(rs.getInt("id"), rs.getString("diemDi"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<TicketFlight> getAllTicketFlights(){
        List<TicketFlight> list = new ArrayList<>();
        String sql = "SELECT * FROM TicketFlights";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TicketFlight ticket = new TicketFlight();
                ticket.setId(rs.getString("id"));
                ticket.setDiemDi(rs.getString("diemDi"));
                ticket.setDiemHa(rs.getString("diemHa"));
                ticket.setThoiGian(rs.getString("thoiGian"));
                ticket.setGiaTien(rs.getDouble("giaTien"));
                ticket.setGiamGia(rs.getInt("giamGia"));
                Category c = getCategoryByID(rs.getInt("cid"));
                ticket.setCategory(c);
                list.add(ticket); 
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
    public List<TicketFlight_inter> getAllTicketFlights_inter(){
        List<TicketFlight_inter> list = new ArrayList<>();
        String sql = "SELECT * FROM TicketFlights";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TicketFlight_inter ticket = new TicketFlight_inter();
                ticket.setId(rs.getString("id"));
                ticket.setDiemDi(rs.getString("diemDi"));
                ticket.setDiemHa(rs.getString("diemHa"));
                ticket.setThoiGian(rs.getString("thoiGian"));
                ticket.setGiaTien(rs.getDouble("giaTien"));
                ticket.setGiamGia(rs.getInt("giamGia"));
                Category c = getCategoryByID(rs.getInt("cid"));
                ticket.setCategory(c);
                list.add(ticket); 
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
//    chon 1 category thi tra ve danh sach san pham
    public List<TicketFlight> getTicketFlightByCid(int cid){
        List<TicketFlight> list = new ArrayList<>();
        String sql = "SELECT [ID]\n"
                + "      ,[diemDi]\n"
                + "      ,[diemHa]\n"
                + "      ,[thoiGian]\n"
                + "      ,[giaTien]\n"
                + "      ,[giamgia]\n"
                + "      ,[cid]\n"
                + "  FROM [dbo].[TicketFlights]"
                + " where 1=1 ";
        if (cid != 0) {
            sql += " and cid =" + cid;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                TicketFlight ticket = new TicketFlight();
                ticket.setId(rs.getString("id"));
                ticket.setDiemDi(rs.getString("diemDi"));
                ticket.setDiemHa(rs.getString("diemHa"));
                ticket.setThoiGian(rs.getString("thoiGian"));
                ticket.setGiaTien(rs.getDouble("giaTien"));
                ticket.setGiamGia(rs.getInt("giamgia"));
                Category c = getCategoryByID(rs.getInt("cid"));
                ticket.setCategory(c);
                list.add(ticket); 
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
//    international
    public List<TicketFlight_inter> getTicketFlight_interByCid(int cid){
        List<TicketFlight_inter> list = new ArrayList<>();
        String sql = "SELECT [ID]\n"
                + "      ,[diemDi]\n"
                + "      ,[diemHa]\n"
                + "      ,[thoiGian]\n"
                + "      ,[giaTien]\n"
                + "      ,[giamgia]\n"
                + "      ,[cid]\n"
                + "  FROM [dbo].[TicketFlights_inter]"
                + " where 1=1 ";
        if (cid != 0) {
            sql += " and cid =" + cid;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                TicketFlight_inter ticket = new TicketFlight_inter();
                ticket.setId(rs.getString("id"));
                ticket.setDiemDi(rs.getString("diemDi"));
                ticket.setDiemHa(rs.getString("diemHa"));
                ticket.setThoiGian(rs.getString("thoiGian"));
                ticket.setGiaTien(rs.getDouble("giaTien"));
                ticket.setGiamGia(rs.getInt("giamgia"));
                Category c = getCategoryByID(rs.getInt("cid"));
                ticket.setCategory(c);
                list.add(ticket); 
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
    public List<TicketFlight> getTicketFlightsByFilter(int cid, String price) {
    List<TicketFlight> list = new ArrayList<>();
    String sql = "SELECT * FROM TicketFlights WHERE 1=1";
    if (cid != 0) {
        sql += " AND cid = " + cid;
    }
    if (price != null && !"all".equals(price)) {
        switch (price) {
            case "under1":
                sql += " AND giaTien < 1000000";
                break;
            case "1to3":
                sql += " AND giaTien >= 1000000 AND giaTien <= 3000000";
                break;
            case "above3":
                sql += " AND giaTien > 3000000";
                break;
        }
    }
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            TicketFlight ticket = new TicketFlight();
            ticket.setId(rs.getString("id"));
            ticket.setDiemDi(rs.getString("diemDi"));
            ticket.setDiemHa(rs.getString("diemHa"));
            ticket.setThoiGian(rs.getString("thoiGian"));
            ticket.setGiaTien(rs.getDouble("giaTien"));
            ticket.setGiamGia(rs.getInt("giamgia"));
            Category c = getCategoryByID(rs.getInt("cid"));
            ticket.setCategory(c);
            list.add(ticket);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }
    return list;
}

public List<TicketFlight_inter> getTicketFlightsInterByFilter(int cid, String price) {
    List<TicketFlight_inter> list = new ArrayList<>();
    String sql = "SELECT * FROM TicketFlights_inter WHERE 1=1";
    if (cid != 0) {
        sql += " AND cid = " + cid;
    }
    if (price != null && !"all".equals(price)) {
        switch (price) {
            case "under1":
                sql += " AND giaTien < 1000000";
                break;
            case "1to3":
                sql += " AND giaTien >= 1000000 AND giaTien <= 3000000";
                break;
            case "above3":
                sql += " AND giaTien > 3000000";
                break;
        }
    }
    System.out.println("SQL: " + sql);
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            TicketFlight_inter ticket = new TicketFlight_inter();
            ticket.setId(rs.getString("id"));
            ticket.setDiemDi(rs.getString("diemDi"));
            ticket.setDiemHa(rs.getString("diemHa"));
            ticket.setThoiGian(rs.getString("thoiGian"));
            ticket.setGiaTien(rs.getDouble("giaTien"));
            ticket.setGiamGia(rs.getInt("giamgia"));
            Category c = getCategoryByID(rs.getInt("cid"));
            ticket.setCategory(c);
            list.add(ticket);
        }
    } catch (SQLException e) {
        System.err.println(e);
    }
    return list;
}
    public static void main(String[] args) {
    TicketFlightDAO c=new TicketFlightDAO();
    List<Category> list=c.getAll();
    System.out.println(list.get(0).getDiemDi());
    }
}
