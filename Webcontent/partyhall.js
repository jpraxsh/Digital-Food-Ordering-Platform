function myFunction(){
var cat=document.getElementById("food_category");
var f1=document.getElementById("nonveg_stat");
var f2=document.getElementById("vegstat");
var f3=document.getElementById("Soup");
var f4=document.getElementById("Briyani");
var f5=document.getElementById("Rotis");
var f6=document.getElementById("Rice and Noodles");
var f7=document.getElementById("Curies");
var f8=document.getElementById("Dessert");
var f9=document.getElementById("Drinks and Beverages");

switch(cat.value)
{
    case "Non Veg Starters" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                             f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.remove("js-hidden");
                            break;
    case "Veg Starters" :f2.classList.remove("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                             f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                   break;  
    case "Soups" :f2.classList.add("js-hidden"); f3.classList.remove("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                            f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                  break;  
    case "Biriyani" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.remove("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                             f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                 break;     
    case "Rotis" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.remove("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                              f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                 break;  
    case "Rice & Noodles" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.remove("js-hidden");f7.classList.add("js-hidden");
                             f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                 break;  
    case "curies" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.remove("js-hidden");
                             f8.classList.add("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                  break; 
    case "Dessert" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                             f8.classList.remove("js-hidden");f9.classList.add("js-hidden");f1.classList.add("js-hidden");
                  break;  
    case "Drinks and Beverages" :f2.classList.add("js-hidden"); f3.classList.add("js-hidden"); f4.classList.add("js-hidden");
                             f5.classList.add("js-hidden");f6.classList.add("js-hidden");f7.classList.add("js-hidden");
                             f8.classList.add("js-hidden");f9.classList.remove("js-hidden");f1.classList.add("js-hidden");
                  break;  
      
                              
}
}
