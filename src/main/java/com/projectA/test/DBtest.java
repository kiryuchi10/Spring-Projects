package com.projectA.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBtest {

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Adjust to your DB URL
    private static final String JDBC_USER = "project2"; // Replace with your Oracle username
    private static final String JDBC_PASSWORD = "project2"; // Replace with your Oracle password

    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish connection
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            statement = connection.createStatement();

            // Query to fetch data from book_order table and related tables
            String query = "SELECT " +
                           "bo.ORDER_ID, " +
                           "bo.BRANCH_ID, " +
                           "bo.ORDER_DATE, " +
                           "bl.BOOK_NAME, " +
                           "od.QUANTITY, " +
                           "bo.CHECKED " +
                           "FROM book_order bo " +
                           "LEFT JOIN order_detail od ON bo.ORDER_ID = od.ORDER_ID " +
                           "LEFT JOIN book_list bl ON od.BOOK_CODE = bl.BOOK_CODE " +
                           "WHERE bo.CHECKED = '2' " +
                           "ORDER BY bo.ORDER_DATE";

            // Execute query
            resultSet = statement.executeQuery(query);

            // Process the result set
            System.out.printf("%-10s | %-10s | %-12s | %-30s | %-8s | %-7s%n",
                              "Order ID", "Branch ID", "Order Date", "Book Name", "Quantity", "Checked");
            System.out.println("-------------------------------------------------------------------------------");

            while (resultSet.next()) {
                Long orderId = resultSet.getLong("ORDER_ID");
                String branchId = resultSet.getString("BRANCH_ID");
                java.sql.Date orderDate = resultSet.getDate("ORDER_DATE");
                String bookName = resultSet.getString("BOOK_NAME");
                int quantity = resultSet.getInt("QUANTITY");
                String checked = resultSet.getString("CHECKED");

                System.out.printf("%-10d | %-10s | %-12s | %-30s | %-8d | %-7s%n",
                                  orderId, branchId, orderDate.toString(), bookName, quantity, checked);
            }
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found. Make sure to include the Oracle JDBC driver in your classpath.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("SQL error occurred.");
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }
    }
}
