var coll = document.getElementsByClassName("fileCollapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("fileActive");
    var fileContent = this.nextElementSibling;
    if (fileContent.style.maxHeight){
      fileContent.style.maxHeight = null;
    } else {
      fileContent.style.maxHeight = fileContent.scrollHeight + "px";
    } 
  });
}


var coll2 = document.getElementsByClassName("fileBranchCollapsible");
var i2;

for (i2 = 0; i2 < coll2.length; i2++) {
  coll2[i2].addEventListener("click", function() {
    this.classList.toggle("fileBranchActive");
    var fileBranchContent = this.nextElementSibling;
    if (fileBranchContent.style.maxHeight){
      fileBranchContent.style.maxHeight = null;
    } else {
      fileBranchContent.style.maxHeight = fileBranchContent.scrollHeight + "px";
    } 
  });
}


var coll3 = document.getElementsByClassName("fileCondCollapsible");
var i3;

for (i3 = 0; i3 < coll3.length; i3++) {
  coll3[i3].addEventListener("click", function() {
    this.classList.toggle("fileCondActive");
    var fileCondContent = this.nextElementSibling;
    if (fileCondContent.style.maxHeight){
      fileCondContent.style.maxHeight = null;
    } else {
      fileCondContent.style.maxHeight = fileCondContent.scrollHeight + "px";
    } 
  });
}


var coll4 = document.getElementsByClassName("fileToggleCollapsible");
var i4;

for (i4 = 0; i4 < coll4.length; i4++) {
  coll4[i4].addEventListener("click", function() {
    this.classList.toggle("fileToggleActive");
    var fileToggleContent = this.nextElementSibling;
    if (fileToggleContent.style.maxHeight){
      fileToggleContent.style.maxHeight = null;
    } else {
      fileToggleContent.style.maxHeight = fileToggleContent.scrollHeight + "px";
    } 
  });
}



function sortTable(i, n) {
  var table, rows, switching, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("sortable" + i);
  switching = true;
  dir = "asc"; // Set the sorting direction to ascending by default

  while (switching) {
    switching = false;
    rows = table.rows;

    // Loop through all table rows (except the first, which contains table headers)
    for (var j = 1; j < (rows.length - 1); j++) {
      shouldSwitch = false;
      x = rows[j].getElementsByTagName("TD")[n];
      y = rows[j + 1].getElementsByTagName("TD")[n];

      // Try to parse the content of the cells as numbers
      var xContent = parseFloat(x.innerHTML) || x.innerHTML.toLowerCase();  // Try to convert to a number, fallback to string
      var yContent = parseFloat(y.innerHTML) || y.innerHTML.toLowerCase();  // Try to convert to a number, fallback to string

      // Handle ascending sort
      if (dir == "asc") {
        if (xContent > yContent) {
          shouldSwitch = true;
          break;
        }
      // Handle descending sort
      } else if (dir == "desc") {
        if (xContent < yContent) {
          shouldSwitch = true;
          break;
        }
      }
    }

    if (shouldSwitch) {
      // Perform the switch and mark that a switch has been done
      rows[j].parentNode.insertBefore(rows[j + 1], rows[j]);
      switching = true;
      switchcount++;
    } else {
      // If no switch has been made and the direction is "asc", switch to "desc"
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}
