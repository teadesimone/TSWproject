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
        
        .checkboxInterne{
            display: none;
        }
        
    </style>
</head>

<body>
	<%@include file="/WEB-INF/header.jsp" %>
    
    <h2>Our Catalog</h2>
    <div>
        <input type="text" id="search" placeholder="Search products..." >
        <button onclick="ajaxFilter()">Search</button>
        <button onclick="reset()">Reset</button>
        <button onclick="activeFilter()">Filter</button>
    </div>
    
    <div id="filter">
         
         <div>
            <input type="checkbox" id="prezzo" name="prezzo"  value="price" onchange="enablePrice()" >
            <label for="prezzo">Price</label>
            
            <div class="checkboxInterne" id="1">
            <label for= "prezzo_da"> From </label>
            <input name = "prezzo_da" id = "prezzo_da" type = "text" required >
            <label for= "prezzo_a"> To  </label>
            <input name = "prezzo_a" id = "prezzo_a" type = "text" required>
           </div>
         </div>
         
         <div>
             <input type="checkbox" id="materiale" name="materiale" value="material" onchange="enableMaterial()">
             <label for="materiale">Material</label>
             
             <div class="checkboxInterne" id="2">
                <input type="checkbox" id="oro" name="oro" value="Gold">
                <label for="oro">Gold</label>
                <input type="checkbox" id="argento" name="argento" value="Silver">
                <label for="argento">Silver</label>
                <input type="checkbox" id="ororosa" name="ororosa" value="Rose Gold">
                <label for="ororosa">Rose Gold</label>
            </div>
             
         </div>
         <div>
             <input type="checkbox" id="categoria" name="categoria" value="categoria" onchange="enableCategory()">
             <label for="categoria">Category</label>
             
             <div class="checkboxInterne" id="3" >
                <input type="checkbox" id="collana" name="collana" value="Necklace">
                <label for="collana">Necklace</label>
                <input type="checkbox" id="bracciale" name="bracciale" value="Bracelet">
                <label for="bracciale">Bracelet</label>
                <input type="checkbox" id="anello" name="anello" value="Ring">
                <label for="anello">Ring</label>
                <input type="checkbox" id="orecchini" name="orecchini" value="Earrings">
                <label for="orecchini">Earrings</label>
            </div>
                
         </div>
         
         <div>
             <input type="checkbox" id="pietra" name="pietra" value="pietra" onchange="enableGemstone()">
             <label for="pietra">Gemstone</label>
             
             <div class="checkboxInterne" id="4">
                 <input type="checkbox" id="giada" name="giada" value="Jade">
                 <label for="giada">Jade</label>
                 <input type="checkbox" id="ametista" name="ametista" value="Amethyst">
                 <label for="ametista">Amethyst</label>
                 <input type="checkbox" id="quarzorosa" name="quarzorosa" value="Rose Quarz">
                 <label for="quarzorosa">Rose Quarz</label>
                 <input type="checkbox" id="rubino" name="rubino" value="Ruby">
                 <label for="rubino">Ruby</label>
                 <input type="checkbox" id="smeraldo" name="smeraldo" value="Emerald">
                 <label for="smeraldo">Emerald</label>
                 <input type="checkbox" id="acquamarina" name="acquamarina" value="Aquamarine">
                 <label for="acquamarina">Aquamarine</label>
             </div>
                 
         </div>
    
    <!--     <button onclick="ajaxFilter()">Filter</button>-->
    </div>
    
    <table border = "1" id = "catalogTable">

    </table> 
    
    
    <%@include file="/WEB-INF/footer.jsp" %>
    
    <script>
        $(document).ready(function(){
            $.ajax({
                url: 'createCatalog',
                type: 'GET',
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
        
    /*
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
                    
        } */
        
        function ajaxFilter(){
            var keyword = $('#search').val();
            
            if($("#prezzo:checked").val()==undefined){
                $("#prezzo").val("");
            }else{
                $('#prezzo').val("prezzo");
            }
            var prezzo_da = $('#prezzo_da').val();
            var prezzo_a = $("#prezzo_a").val();
            
            if($("#materiale:checked").val()==undefined){
                $("#materiale").val("");
            }else{
                $('#materiale').val("materiale");
            }
            
            if($("#argento:checked").val()==undefined){
                $("#argento").val("");
            }else{
                $('#argento').val("Silver");
            }
            
            if($("#oro:checked").val()==undefined){
                $("#oro").val("");
            }else{
                $('#oro').val("Gold");
            }
            
            
            if($("#ororosa:checked").val()==undefined){
                $("#ororosa").val("");
            }else{
                $('#ororosa').val("Rose Gold");
            }
            
            if($("#categoria:checked").val()==undefined){
                $("#categoria").val("");
            }else{
                $('#categoria').val("categoria");
            }
            
            if($("#collana:checked").val()==undefined){
                $("#collana").val("");
            }else{
                $('#collana').val("Necklace");
            }
            
            if($("#bracciale:checked").val()==undefined){
                $("#bracciale").val("");
            }else{
                $('#bracciale').val("Bracelet");
            }
            
            if($("#anello:checked").val()==undefined){
                $("#anello").val("");
            }else{
                $('#anello').val("Ring");
            }
            
            if($("#orecchini:checked").val()==undefined){
                $("#orecchini").val("");
            }else{
                $('#orecchini').val("Earrings");
            }
            
            if($("#pietra:checked").val()==undefined){
                $("#pietra").val("");
            }else{
                $('#pietra').val("pietra");
            }
            
            if($("#acquamarina:checked").val()==undefined){
                $("#acquamarina").val("");
            }else{
                $('#acquamarina').val("Aquamarine");
            }
            
            if($("#ametista:checked").val()==undefined){
                $("#ametista").val("");
            }else{
                $('#ametista').val("Amethyst");
            }
            
            if($("#rubino:checked").val()==undefined){
                $("#rubino").val("");
            }else{
                $('#rubino').val("Ruby");
            }
            
            if($("#giada:checked").val()==undefined){
                $("#giada").val("");
            }else{
                $('#giada').val("Jade");
            }
            
            if($("#quarzorosa:checked").val()==undefined){
                $("#quarzorosa").val("");
            }else{
                $('#quarzorosa').val("Rose Quarz");
            }
            
            if($("#smeraldo:checked").val()==undefined){
                $("#smeraldo").val("");
            }else{
                $('#smeraldo').val("Emerald");
            }
            
            $.ajax({
                url: 'createCatalog?action=filter',
                method: 'GET',
                data: { keyword : keyword,
                        prezzo: $('#prezzo').val(),
                        prezzo_da: prezzo_da,
                        prezzo_a: prezzo_a,
                        materiale:$('#materiale').val(),
                        argento: $('#argento').val(),
                        oro: $('#oro').val(),
                        ororosa: $('#ororosa').val(),
                        categoria:$('#categoria').val(),
                        collana: $('#collana').val(),
                        bracciale: $('#bracciale').val(),
                        anello: $('#anello').val(),
                        orecchini: $('#orecchini').val(),
                        pietra: $('#pietra').val(),
                        acquamarina: $('#acquamarina').val(),
                        ametista: $('#ametista').val(),
                        rubino: $('#rubino').val(),
                        giada: $('#giada').val(),
                        quarzorosa: $('#quarzorosa').val(),
                        smeraldo: $('#smeraldo').val()
                },
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
            $("#prezzo").prop("checked", false);
            enablePrice();
            $("#materiale").prop("checked", false);
            enableMaterial();
            $("#categoria").prop("checked", false);
            enableCategory();
            $("#pietra").prop("checked", false);
            enableGemstone();
        }
        
        function activeFilter(){
            $("#filter").toggle();
        }
        
        function enablePrice() {
            var prezzo = document.getElementById('prezzo');
           
           if ($("#prezzo").prop("checked") == true ) {  
                $(".checkboxInterne#1").css("display","block");
            }
            else{
                $(".checkboxInterne#1").css("display","none"); 
            }
        }
        
        function enableCategory() {
            var categoria = document.getElementById('categoria'); 

            if ($("#categoria").prop("checked") == true ) {  
                $(".checkboxInterne#3").css("display","block");  
            }
            else{
                $(".checkboxInterne#3").css("display","none"); 
            }
        }
        
        function enableGemstone() {
            var pietra = document.getElementById('pietra'); 
           
            if ($("#pietra").prop("checked") == true ) {  
                $(".checkboxInterne#4").css("display","block");  
            }
            else{
                $(".checkboxInterne#4").css("display","none"); 
            }
        }
        
        function enableMaterial() {
            var materiale = document.getElementById('materiale'); 

            if ($("#materiale").prop("checked") == true ) {  
                $(".checkboxInterne#2").css("display","block");  
            }
            else{
                $(".checkboxInterne#2").css("display","none"); 
            }
        } 
    
    </script>
    
    
</body>

</html>
