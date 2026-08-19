

var coll = document.getElementsByClassName("instFileCollapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("instFileActive");
    var instFileContent = this.nextElementSibling;
    if (instFileContent.style.maxHeight){
      instFileContent.style.maxHeight = null;
    } else {
      instFileContent.style.maxHeight = instFileContent.scrollHeight + "px";
    } 
  });
}




var coll2 = document.getElementsByClassName("instBranchCollapsible");
var i2;

for (i2 = 0; i2 < coll2.length; i2++) {
  coll2[i2].addEventListener("click", function() {
    this.classList.toggle("instBranchActive");
    var instBranchContent = this.nextElementSibling;
    if (instBranchContent.style.maxHeight){
      instBranchContent.style.maxHeight = null;
    } else {
      instBranchContent.style.maxHeight = instBranchContent.scrollHeight + "px";
    } 
  });
}



var coll3 = document.getElementsByClassName("instCondCollapsible");
var i3;

for (i3 = 0; i3 < coll3.length; i3++) {
  coll3[i3].addEventListener("click", function() {
    this.classList.toggle("instCondActive");
    var instCondContent = this.nextElementSibling;
    if (instCondContent.style.maxHeight){
      instCondContent.style.maxHeight = null;
    } else {
      instCondContent.style.maxHeight = instCondContent.scrollHeight + "px";
    } 
  });
}

var coll4 = document.getElementsByClassName("instToggleCollapsible");
var i4;

for (i4 = 0; i4 < coll4.length; i4++) {
  coll4[i4].addEventListener("click", function() {
    this.classList.toggle("instToggleActive");
    var instToggleContent = this.nextElementSibling;
    if (instToggleContent.style.maxHeight){
      instToggleContent.style.maxHeight = null;
    } else {
      instToggleContent.style.maxHeight = instToggleContent.scrollHeight + "px";
    } 
  });
}

