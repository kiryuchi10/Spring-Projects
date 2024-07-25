<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>본사 관리 시스템</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/admins.css'/>">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        th {
            background-color: #f4f4f4;
            cursor: pointer;
            text-align: center;
        }

        th button {
            border: none;
            background: none;
            color: #007bff;
            font-size: 16px;
            cursor: pointer;
            padding: 10px;
            border-radius: 4px;
        }

        th button:hover {
            background-color: #e1e1e1;
            text-decoration: underline;
        }

        .branchId-btn {
            background-color: #e57373;
            color: white;
        }

        .bookCode-btn {
            background-color: #81c784;
            color: white;
        }

        .totalQuantity-btn {
            background-color: #ffb74d;
            color: white;
        }

        .table-container {
            max-height: 200px; /* Adjust height as needed */
            overflow-y: auto;
            margin-bottom: 20px;
            position: relative;
        }

        .table-container table {
            width: 100%;
            border-collapse: collapse;
            position: relative;
        }

        .table-container thead {
            position: -webkit-sticky; /* For Safari */
            position: sticky;
            top: 0;
            z-index: 10; /* Ensures the header is above other content */
            background-color: #f4f4f4;
        }

        .summary-table {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            padding: 10px;
            z-index: 1000;
        }

        .summary-table table {
            border: none;
            width: 100%;
        }

        .summary-table th, .summary-table td {
            border: none;
            padding: 4px;
        }

        .summary-table th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin_includes/navigation.jsp"%>
    <div class="content">
        <h1>승인된 발주서 요약</h1>

        <h3 class="parent" style="text-align: left;">
            <a href="<c:url value='/admin/ordercheck/list'/>">발주 리스트 돌아가기</a>
        </h3>

        <c:if test="${empty orderList}">
            <p>No data available.</p>
        </c:if>

        <c:if test="${not empty orderList}">
            <!-- Buttons -->
            <div style="margin-bottom: 20px;">
                <button id="download-csv" style="padding: 10px 20px; font-size: 16px; color: white; background-color: #007bff; border: none; border-radius: 4px; cursor: pointer;">
                    Download CSV
                </button>
                <button id="go-to-calendar" style="padding: 10px 20px; font-size: 16px; color: white; background-color: #28a745; border: none; border-radius: 4px; cursor: pointer;">
                    Go to Calendar
                </button>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 25%;">
                                <button class="branchId-btn" onclick="location.href='<c:url value='/admin/ordercheck/summary/branchId' />'">Order ID</button>
                            </th>
                            <th style="width: 25%;">
                                <button class="bookCode-btn" onclick="location.href='<c:url value='/admin/ordercheck/summary/bookCode' />'">Branch ID</button>
                            </th>
                            <th style="width: 25%;">
                                <button class="branchId-btn" onclick="location.href='#'">Book Name</button>
                            </th>
                            <th style="width: 25%;">
                                <button class="totalQuantity-btn" onclick="location.href='#'">Quantity</button>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="data-table-body">
                        <c:forEach items="${orderList}" var="item">
                            <tr>
                                <td>${item.orderId}</td>
                                <td>${item.branchId}</td>
                                <td>${item.bookName}</td>
                                <td>${item.quantity}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <!-- Summary Table Placeholder -->
        <div id="summary-table" class="summary-table">
            <table>
                <thead>
                    <tr>
                        <th>Branch ID</th>
                        <th>Total Quantity</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/admin_includes/footer.jsp"%>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Function to download table data as CSV
            function downloadCSV() {
                const rows = Array.from(document.querySelectorAll("#data-table-body tr"));
                let csvContent = "data:text/csv;charset=utf-8,";

                // Add header row
                csvContent += "Order ID,Branch ID,Book Name,Quantity\n";

                rows.forEach(row => {
                    const cols = row.querySelectorAll("td");
                    const rowData = Array.from(cols).map(col => col.textContent).join(",");
                    csvContent += rowData + "\n";
                });

                // Create a link element and trigger a download
                const encodedUri = encodeURI(csvContent);
                const link = document.createElement("a");
                link.setAttribute("href", encodedUri);
                link.setAttribute("download", "branch_list_summary.csv");
                document.body.appendChild(link); // Required for Firefox
                link.click();
                document.body.removeChild(link); // Clean up
            }

            // Add event listener to the download button
            document.getElementById("download-csv").addEventListener("click", downloadCSV);

            // Add event listener to the calendar button
            document.getElementById("go-to-calendar").addEventListener("click", function() {
                window.location.href = '<c:url value="/admin/ordercheck/calendar" />';
            });
        });
    </script>
</body>
</html>
