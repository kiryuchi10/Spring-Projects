/**
 * Creates a matrix of cells inside the HTML element with the ID 'calendar'.
 * 
 * @param {number} rows - Number of rows in the matrix.
 * @param {number} cols - Number of columns in the matrix.
 */
function createMatrix(rows, cols) {
    // Get the HTML element with the ID 'calendar'
    const calendar = document.getElementById('calendar');

    // Loop through each row
    for (let i = 0; i < rows; i++) {
        // Create a new table row element
        const tr = document.createElement('tr');

        // Loop through each column in the current row
        for (let j = 0; j < cols; j++) {
            // Create a new table cell element
            const td = document.createElement('td');
            
            // Add a click event listener to the cell
            td.addEventListener('click', () => {
                // Toggle the 'clicked' class on the cell
                td.classList.toggle('clicked');
            });

            // Append the cell to the row
            tr.appendChild(td);
        }

        // Append the row to the calendar (table body)
        calendar.appendChild(tr);
    }
}

// Call the function to create a 7x5 matrix
createMatrix(7, 5);
