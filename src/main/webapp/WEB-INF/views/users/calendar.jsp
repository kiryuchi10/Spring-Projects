<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>July 2024 Calendar</title>
<style>
body {
    display: flex;
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

.sidebar {
    width: 200px;
    padding: 20px;
    background-color: #f4f4f4;
    border-right: 1px solid #ddd;
    overflow-y: auto;
    position: fixed; /* Keep sidebar fixed */
    height: 100vh; /* Full height */
}

.content {
    flex: 1;
    padding: 20px;
    margin-left: 270px; /* Leave space for fixed sidebar */
}

table {
    width: 100%;
    border-collapse: collapse;
}

td {
    width: 14.28%;
    height: 80px;
    text-align: center;
    border: 1px solid #ddd;
    vertical-align: top;
    position: relative;
}

.header {
    background-color: #f4f4f4;
    font-weight: bold;
}

.clickable {
    cursor: pointer;
}

.event-indicator {
    width: 100%;
    height: 5px;
    background-color: #ff5722;
    position: absolute;
    bottom: 0;
    left: 0;
    border-radius: 3px;
}

.event-tooltip {
    display: none;
    position: absolute;
    background: #fff;
    border: 1px solid #ddd;
    padding: 10px;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    max-width: 200px;
    overflow: auto;
}

.event-tooltip.active {
    display: block;
}

.button-container {
    margin-bottom: 20px;
}

.calendar-buttons button, .return-button {
    margin-right: 10px;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.calendar-buttons button:hover, .return-button:hover {
    background-color: #0056b3;
}

.return-button {
    background-color: #28a745;
}

.note-form {
    display: none;
    position: fixed;
    top: 20px;
    left: 270px;
    width: 300px;
    background: #fff;
    border: 1px solid #ddd;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    z-index: 1000;
}

.note-form.active {
    display: block;
}

.note-form textarea {
    width: 100%;
    height: 100px;
    margin-bottom: 10px;
}

.note-form button {
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.note-form button:hover {
    background-color: #0056b3;
}

#sidebar-notes {
    max-height: calc(100vh - 120px); /* Adjust height as needed */
    overflow-y: auto; /* Enable vertical scrolling */
}

.order-details {
    display: none;
    position: fixed;
    top: 20px;
    left: 270px;
    width: 300px;
    background: #fff;
    border: 1px solid #ddd;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    z-index: 1000;
}

.order-details.active {
    display: block;
}
</style>
<script>
    async function fetchOrderDetails(date, cell) {
        var tooltip = cell.querySelector('.event-tooltip');
        tooltip.classList.add('active');

        try {
            const response = await fetch(`/calendar/detail/${date}`, {
                method: 'GET',
            });
            const data = await response.json();

            let orderList = '<ul>';
            data.forEach(order => {
                orderList += `<li><a href="#" onclick="showOrderDetails(${order.orderId})">Order ID: ${order.orderId}, Branch ID: ${order.branchId}, Checked: ${order.checked}</a></li>`;
            });
            orderList += '</ul>';
            tooltip.innerHTML = orderList;
        } catch (error) {
            tooltip.innerHTML = '<p>Error loading orders.</p>';
        }
    }

    function hideOrderDetails(cell) {
        var tooltip = cell.querySelector('.event-tooltip');
        tooltip.classList.remove('active');
    }

    async function fetchNotes(date) {
        try {
            const response = await fetch(`/notes/${date}`, {
                method: 'GET',
            });
            const data = await response.json();
            
            let notesList = '<ul>';
            data.notes.forEach(note => {
                notesList += `<li><a href="#" onclick="showOrderDetails(${note.orderId})">${note.content}</a></li>`;
            });
            notesList += '</ul>';
            document.querySelector('#sidebar-notes').innerHTML = notesList;
        } catch (error) {
            document.querySelector('#sidebar-notes').innerHTML = '<p>Error loading notes.</p>';
        }
    }

    function showNoteForm(date) {
        const form = document.querySelector('.note-form');
        form.classList.add('active');
        form.querySelector('#note-date').value = date;
    }

    async function saveNote() {
        const date = document.querySelector('#note-date').value;
        const content = document.querySelector('#note-content').value;
        
        try {
            await fetch(`/notes/${date}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ content: content })
            });
            document.querySelector('.note-form').classList.remove('active');
            fetchNotes(date); // Refresh notes in the sidebar
        } catch (error) {
            alert('Error saving note.');
        }
    }

    function hideNoteForm() {
        document.querySelector('.note-form').classList.remove('active');
    }

    async function showOrderDetails(orderId) {
        const detailsDiv = document.querySelector('.order-details');
        try {
            const response = await fetch(`/orders/${orderId}`, {
                method: 'GET',
            });
            const data = await response.json();

            let orderTable = `
                <h3>Order Details</h3>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Branch ID</th>
                            <th>Order Date</th>
                            <th>Checked</th>
                        </tr>
                    </thead>
                    <tbody>
            `;
            data.forEach(order => {
                orderTable += `
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.branchId}</td>
                        <td>${order.orderDate}</td>
                        <td>${order.checked}</td>
                    </tr>
                `;
            });
            orderTable += `
                    </tbody>
                </table>
                <button onclick="hideOrderDetailsTable()">Close</button>
            `;
            detailsDiv.innerHTML = orderTable;
            detailsDiv.classList.add('active');
        } catch (error) {
            detailsDiv.innerHTML = '<p>Error loading order details.</p>';
            detailsDiv.classList.add('active');
        }
    }

    function hideOrderDetailsTable() {
        document.querySelector('.order-details').classList.remove('active');
    }

    function filterBy(calendarId) {
        switch(calendarId) {
            case 'Calendar 1':
                window.location.href = '/admin/ordercheck/calendar';
                break;
            case 'Calendar 2':
                window.location.href = '/WEB-INF/views/calendar/calendar2.jsp';
                break;
            case 'Calendar 3':
                window.location.href = '/WEB-INF/views/calendar/calendar3.jsp';
                break;
            case 'Calendar 4':
                window.location.href = '/WEB-INF/views/calendar/calendar4.jsp';
                break;
            default:
                console.error('Unknown calendar ID');
        }
    }

    function returnToOrderCheck() {
        window.location.href = 'http://localhost:8080/projectA/main';
    }
</script>
</head>
<body>
    <div class="sidebar">
        <h2>Event Management</h2>
        <p>Manage your calendar events from here.</p>
        <div id="sidebar-notes">
            <!-- Notes will be dynamically inserted here -->
        </div>
    </div>

    <div class="content">
        <h1>July 2024</h1>

        <div class="button-container">
            <div class="calendar-buttons">
                <button onclick="filterBy('Calendar 1')">Calendar 1</button>
                <button onclick="filterBy('Calendar 2')">Calendar 2</button>
                <button onclick="filterBy('Calendar 3')">Calendar 3</button>
                <button onclick="filterBy('Calendar 4')">Calendar 4</button>
            </div>
        </div>

        <table>
            <tr>
                <td class="header">Sun</td>
                <td class="header">Mon</td>
                <td class="header">Tue</td>
                <td class="header">Wed</td>
                <td class="header">Thu</td>
                <td class="header">Fri</td>
                <td class="header">Sat</td>
            </tr>
            <%
            int daysInMonth = 31;
            int startDayOfWeek = 1; // Adjust this based on the actual start day of July 2024

            int day = 1;
            for (int row = 0; row < 6; row++) {
                out.print("<tr>");
                for (int col = 0; col < 7; col++) {
                    if (row == 0 && col < startDayOfWeek - 1) {
                        out.print("<td></td>");
                    } else if (day <= daysInMonth) {
                        String date = String.format("2024-07-%02d", day);
                        out.print("<td class='clickable' onmouseover='fetchOrderDetails(\"" + date
                                + "\", this)' onmouseout='hideOrderDetails(this)' onclick='showNoteForm(\"" + date + "\")'>" + day
                                + "<div class='event-indicator'></div><div class='event-tooltip'></div></td>");
                        day++;
                    } else {
                        out.print("<td></td>");
                    }
                }
                out.print("</tr>");
                if (day > daysInMonth)
                    break;
            }
            %>
        </table>

        <hr />
        <h2>Order Details</h2>
        <%-- Display order details if available --%>
        <c:if test="${not empty orderDetail}">
            <table border="1">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Branch ID</th>
                        <th>Order Date</th>
                        <th>Checked</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderDetail}" var="order">
                        <tr>
                            <td><c:out value="${order.orderId}" /></td>
                            <td><c:out value="${order.branchId}" /></td>
                            <td><c:out value="${order.orderDate}" /></td>
                            <td><c:out value="${order.checked}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <!-- "Go to Check Order" button -->
        <div class="button-container">
            <button class="return-button" onclick="returnToOrderCheck()">Go
                to Check Order</button>
        </div>
    </div>

    <!-- Note Form -->
    <div class="note-form">
        <h3>Add Note</h3>
        <input type="hidden" id="note-date">
        <textarea id="note-content" placeholder="Enter your note here..."></textarea>
        <button onclick="saveNote()">Save</button>
        <button onclick="hideNoteForm()">Cancel</button>
    </div>

    <!-- Order Details Table -->
    <div class="order-details">
        <!-- Order details will be dynamically inserted here -->
    </div>
</body>
</html>
