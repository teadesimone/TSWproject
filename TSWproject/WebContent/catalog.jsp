<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>



<!--
List<JewelBean> products = (ArrayList<JewelBean>) request.getAttribute("products");
if(products == null) {
    response.sendRedirect("./createCatalog");
    return;

} -->   
 

<!DOCTYPE html>
<html lang="en">

<head>
    <title> JadeTear Catalog </title>
    <style>
        #filter{
            display: none;
        }
    </style>
</head>

<body>
	<%@include file="/WEB-INF/header.jsp" %>
    
    <h2>Our Catalog</h2>
    <div>
        <input type="text" id="search" placeholder="Search products..." >
        <button onclick="ajaxSearch()">Search</button>
        <button onclick="reset()">Reset</button>
        <button onclick="activeFilter()">Filter</button>
    </div>
    
    <div id="filter">
         
         <div>
            <input type="checkbox" id="prezzo" name="prezzo" >
            <label for="prezzo">Price</label>
            
            <label for= "prezzo_da"> From </label>
            <input name = "prezzo_da" id = "prezzo_da" type = "text" >
            <label for= "prezzo_a"> To  </label>
            <input name = "prezzo_a" id = "prezzo_a" type = "text" >
            
         </div>
         
         <div>
             <input type="checkbox" id="materiale" name="materiale">
             <label for="materiale">Material</label>
             
                <input type="checkbox" id="oro" name="oro">
                <label for="oro">Gold</label>
                <input type="checkbox" id="argento" name="argento">
                <label for="argento">Silver</label>
                <input type="checkbox" id="ororosa" name="ororosa">
                <label for="ororosa">Rose Gold</label>
                
             
         </div>
         <div>
             <input type="checkbox" id="Categoria" name="categoria">
             <label for="categoria">Category</label>
             
                <input type="checkbox" id="collana" name="collana">
                <label for="collana">Necklace</label>
                <input type="checkbox" id="bracciale" name="bracciale">
                <label for="bracciale">Bracelet</label>
                <input type="checkbox" id="anello" name="anello">
                <label for="anello">Ring</label>
                <input type="checkbox" id="orecchino" name="orecchino">
                <label for="orecchino">Earrings</label>
             
         </div>
         
         <div>
             <input type="checkbox" id="pietra" name="pietra">
             <label for="pietra">Gemstone</label>
             
                 <input type="checkbox" id="giada" name="giada">
                 <label for="giada">Jade</label>
                 <input type="checkbox" id="ametista" name="ametista">
                 <label for="ametista">Amethyst</label>
                 <input type="checkbox" id="rosequarz" name="rosequarz">
                 <label for="rosequarz">Rose Quarz</label>
                 <input type="checkbox" id="rubino" name="rubino">
                 <label for="rubino">Ruby</label>
                 <input type="checkbox" id="smeraldo" name="smeraldo">
                 <label for="smeraldo">Emerald</label>
                 <input type="checkbox" id="acquamarina" name="acquamarina">
                 <label for="acquamarina">Aquamarine</label>
             
         </div>
    
    </div>
    
    <table border = "1" id = "catalogTable">

    </table> 
   
    
   
    
    <!-- <a href="clientorders"> ordini cliente </a> -->
    <%@include file="/WEB-INF/footer.jsp" %>
    
    <script>
        $(document).ready(function(){
            $.ajax({
                type: 'GET',
                url: 'createCatalog',
                success: function(resp) {
                    $("#catalogTable").empty();
                    $("#catalogTable").append("<tr>");
                    $("#catalogTable").append("<th>Nome</th>");
                    $("#catalogTable").append("<th>Image</th>");
                    $("#catalogTable").append("<th>Description</th>");
                    $("#catalogTable").append("<th>Price</th>");
                    $("#catalogTable").append("<th>Detailed Description</th>");
                    $("#catalogTable").append("<th>Add to Cart</th>");
                    $("#catalogTable").append("</tr>");
                    for (let item of resp) {
                        $("#catalogTable").append("<tr>");
                        $("#catalogTable").append("<td>"+item.nome+"</td>");
                        $("#catalogTable").append("<td><img src='images//" +item.immagine+"' alt='"+item.nome+"' width='"+90+"'  height='"+90+"'></td>");
                        $("#catalogTable").append("<td>"+item.descrizione+"</td>");
                        $("#catalogTable").append("<td>"+item.prezzo+"€</td>");
                        $("#catalogTable").append("<td><a href='details?id="+item.id+"'> Show Details</a><br></td>");
                        $("#catalogTable").append("<td><a href='cart?action=add&id="+item.id+"'> Add To Cart</a><br></td>");
                        $("#catalogTable").append("</tr>");
                        
                    }
                }
            });
            
        });
        
        function ajaxSearch(){
            var query = $('#search').val();
                $.ajax({
                    url: 'createCatalog?action=search',
                    method: 'GET',
                    data: { query: query },
                    success: function(resp) {
                        $("#catalogTable").empty();
                        $("#catalogTable").append("<tr>");
                            $("#catalogTable").append("<th>Nome</th>");
                            $("#catalogTable").append("<th>Image</th>");
                            $("#catalogTable").append("<th>Description</th>");
                            $("#catalogTable").append("<th>Price</th>");
                            $("#catalogTable").append("<th>Detailed Description</th>");
                            $("#catalogTable").append("<th>Add to Cart</th>");
                            $("#catalogTable").append("</tr>");
                        for (let item of resp) {
                            $("#catalogTable").append("<tr>");
                                $("#catalogTable").append("<td>"+item.nome+"</td>");
                                $("#catalogTable").append("<td><img src='images//" +item.immagine+"' alt='"+item.nome+"' width='"+90+"'  height='"+90+"'></td>");
                                $("#catalogTable").append("<td>"+item.descrizione+"</td>");
                                $("#catalogTable").append("<td>"+item.prezzo+"</td>");
                                $("#catalogTable").append("<td><a href='details?id="+item.id+"'> Show Details</a><br></td>");
                                $("#catalogTable").append("<td><a href='cart?action=add&id="+item.id+"'> Add To Cart</a><br></td>");
                                $("#catalogTable").append("</tr>");
                                
                            }
                        }
                    });
                    
        }

        function reset() {
            $("#search:text").val("");
        }
        
        function activeFilter(){
            $("#filter").css("display","block");
        }
    
    </script>
    
    
</body>

</html>
