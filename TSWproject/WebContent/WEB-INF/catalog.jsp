<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title> JadeTear Catalog </title>
    <link rel="stylesheet" type="text/css" href="./styles/catalogStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
    
    
        .grid-container {
            display: grid;
            grid-template-columns: 20% 80% ;
            grid-template-rows: auto auto auto ;
            gap: 60px;
            gap: 10px;
            background-color: white;
            padding: 10px;
        }
    
        .grid-container > div {


            
            text-align: center;
            padding: 20px 5px;;
            font-size:20px;
        
        
        }
        
        .catalogo-container{

        width: 100%;
          height: 100%;
          
    }
        
        .catalogo{
        
            display: flex;
            font-size:20px;
            flex-wrap: wrap;
            flex-direction: row;
            height: auto;
        
        }
        
       
        
        .card {

             flex : 0 0 25%;
             background: rgba(240,240,240);
             border: 1px solid #634B66;
             border-radius: 10px;
             margin: 1%;
             text-align: center;
             padding : 2%;
            
             
        }

        .catalogo img {
          width: 80%;
          height: 65%;
          transition: transform .2s;
          border: 1px solid #634B66;
          border-radius: 3px;
        
        }
        
        .catalogo img:hover {
          -ms-transform: scale(1.1); /* IE 9 */
          -webkit-transform: scale(1.1); /* Safari 3-8 */
          transform: scale(1.1); 
        }
        
        .catalogo p,.catalogo a{
         font-family: "Times New Roman", serif, sans-serif; 
         font-size: 18px;
        
        }
        
        .card a:link,.card a:visited {
          
          color: black;
          
          padding: 2%;
          text-align: center;
          text-decoration: none;
          display: inline-block;
        }
        
        .card a:hover,.card a:active {
        
          color: #AEA4B4;
          padding: 2%;
         
        }
        
        .filter-container{

        width: 100%;
          height: 100%;
        border: 1px solid  #3C6A5F;
        padding:5%;
        background: rgba(240,240,240);
        border-radius:5px;

         }

        .filter{

            display: flex;
            font-size:17px;
            flex-wrap: wrap;
            flex-direction: column;
            height: auto;
            padding:2%;
        
        

        }
        
        .macro{

          width: auto;
          height: auto;
          margin-top:10px;
        margin-bottom:10px;
          
          color: #634B66;

         }
        .checkboxInterne{
            
            text-align:left;
            border-top-style: double;
            border-bottom-style: double;
            border-color: #634B66;
            padding: 2%;
            margin-top:5px;
            padding-left:20%;
        
        }
        .macro input[type="checkbox"]{
        accent-color: #634B66;
        
        }
        
        .searchbar input[type="text"]{
            border-radius: 10px;
            padding: 2px;
            width: 30%;
            height: 80%;
            border-top: solid;
        border-bottom: solid;
        
    
        }
        
        h2{
        font-size: 30px;
        color: #634B66;
        text-align:center;
        
        }
        
            button {
              padding: 5px 10px;
              margin: 0 5px;
              border: 2px solid #634B66;
              border-radius: 10px;
              background-color: #fff;
              cursor: pointer;
              text-align: center;
              font-size: 18px;
              letter-spacing: 1px;
             font-family: "Times New Roman", serif, sans-serif;
            }
            
            button:hover {
              color: white;
              background-color: #634B66;
            }
            
            button:active {
              transform: scale(0.9);
            }
            
            
            .categoria {
              padding: 5px 10px;
              margin: 0 5px;
              transition: transform .5s;
              border-radius:0;
              border:none;
              color: #634B66;
              cursor: pointer;
              text-align: center;
              font-size: 18px;
              letter-spacing: 1px;
            }
            
            .categoria:active {
              transform: scale(0.9);
            }
            
            .categoria:hover {
              color: #634B66;
              background-color: white;
            border-bottom: 1px solid #634B66;
            
            }    



    </style>
</head>

<body>
    <div class="grid-container">
        <div class="header" >
            <%@include file="header.jsp" %></div>
    
    <h2>Our Catalog</h2>
    
    
    <div class="searchbar">
    
        <input type="text" list="list" id="search" placeholder="Search products..." style="width: 300px;" oninput="doSuggest()" >
        <span class="suggestBar">
            <datalist class="suggestBar" id="list" style="width: 300px;">
            
            </datalist>
        </span>
        <button onclick="ajaxFilter()"><i class="fa fa-search" aria-hidden="true"></i></button>
        <button onclick="reset()"><i class="fa fa-times" aria-hidden="true"></i></button>
     
        &nbsp;&nbsp;
        <button class="categoria" value="Necklace"><b>Necklaces</b></button>
        <button class="categoria" value="Ring"><b>Rings</b></button>
        <button class="categoria" value="Earrings"> <b>Earrings</b></button>
        <button class="categoria" value="Bracelet"><b>Bracelets</b></button>
        
    </div>
    
    <div class="filter-container">
        <h3 style="color:#634B66"> Filter your search </h3>
        <button onclick="activeFilter()">Filter</button>
        <div id="filter" class="filter">
            
         <div class="macro">
            <input type="checkbox" id="prezzo" name="prezzo" value="price" onchange="enablePrice()" >
            <label for="prezzo" >Price</label>
            
            <div class="checkboxInterne" id="1">
            <label for= "prezzo_da"> From </label>
            <input name = "prezzo_da" id = "prezzo_da" type="number" required style="width:20%">
            <label for= "prezzo_a"> To  </label>
            <input name = "prezzo_a" id = "prezzo_a" type="number" required style="width:20%">
           </div>
         </div>
         
         <div class="macro">
             <input type="checkbox" id="materiale" name="materiale" value="material" onchange="enableMaterial()">
             <label for="materiale">Material</label>
             
             <div class="checkboxInterne" id="2">
                <input type="checkbox" id="oro" name="oro" value="Gold">
                <label for="oro">Gold</label><br>
                <input type="checkbox" id="argento" name="argento" value="Silver">
                <label for="argento">Silver</label><br>
                <input type="checkbox" id="ororosa" name="ororosa" value="Rose Gold">
                <label for="ororosa">Rose Gold</label>
            </div>
             
         </div>
         <div class="macro">
             <input type="checkbox" id="categoria" name="categoria" value="categoria" onchange="enableCategory()">
             <label for="categoria">Category</label>
             
             <div class="checkboxInterne" id="3" >
                <input type="checkbox" id="collana" name="collana" value="Necklace">
                <label for="collana">Necklace</label><br>
                <input type="checkbox" id="bracciale" name="bracciale" value="Bracelet">
                <label for="bracciale">Bracelet</label><br>
                <input type="checkbox" id="anello" name="anello" value="Ring">
                <label for="anello">Ring</label><br>
                <input type="checkbox" id="orecchini" name="orecchini" value="Earrings">
                <label for="orecchini">Earrings</label>
            </div>
                
         </div>
         
         <div class="macro">
             <input type="checkbox" id="pietra" name="pietra"  value="pietra" onchange="enableGemstone()">
             <label for="pietra">Gemstone</label>
             
             <div class="checkboxInterne" id="4">
                 <input type="checkbox" id="giada" name="giada" value="Jade">
                 <label for="giada">Jade</label><br>
                 <input type="checkbox" id="ametista" name="ametista" value="Amethyst">
                 <label for="ametista">Amethyst</label><br>
                 <input type="checkbox" id="quarzorosa" name="quarzorosa" value="Rose Quarz">
                 <label for="quarzorosa">Rose Quarz</label><br>
                 <input type="checkbox" id="quarzo" name="quarzo" value="Quarz">
                 <label for="quarzo">Quarz</label><br>
                 <input type="checkbox" id="citrino" name="citrino" value="Citrine">
                 <label for="citrino">Citrine</label><br>
                 <input type="checkbox" id="acquamarina" name="acquamarina" value="Aquamarine">
                 <label for="acquamarina">Aquamarine</label>
             </div>
                 
         </div>
    
        <button onclick="ajaxFilter()">Filter</button>
    </div>
    
</div>
    
    <div class="catalogo-container" >
    <div class="catalogo" id = "catalogTable">
    
    
    </div>

</div>
    
    <div class="footer">
        <%@include file="footer.jsp" %>
    </div>
    
</div>
    
    <script>
        $(document).ready(function(){
        	$("#filter").css("display", "none");
        	$(".checkboxInterne").css("display", "none");
            
            $.ajax({
                url: 'catalog',
                type: 'GET',
                success: function(resp) {
                    $("#catalogTable").empty();
                    
                    for (let item of resp) {
                        $("#catalogTable").append("<div class='card'><a target='_blank' href='images//" +item.immagine+"'><img src='images//" +item.immagine+"' alt='"+item.nome+"'></a><p>"+item.nome+"</p><p>"+item.prezzo+"€</p><a href='details?id="+item.id+"'> <i class='fa fa-eye' aria-hidden='true''></i></a><a href='cart?action=add&id="+item.id+"'><i class='fa fa-cart-plus' aria-hidden='true'></i></a></div>");
                        
                        
                        
                    }
                }
            });
            
          
            
        });
        
      
    
    
         
         $("button.categoria").click(function() {
             var fired_button = $(this).val();
             
             $.ajax({
                 url: 'catalog?action=searchByCategory',
                 type: 'GET',
                 data : {category : fired_button},
                 success: function(resp) {
                     $("#catalogTable").empty();
                     for (let item of resp) {
                         $("#catalogTable").append("<div class='card'><a target='_blank' href='images//" +item.immagine+"'><img src='images//" +item.immagine+"' alt='"+item.nome+"'></a><p>"+item.nome+"</p><p>"+item.prezzo+"€</p><a href='details?id="+item.id+"'> <i class='fa fa-eye' aria-hidden='true''></i></a><a href='cart?action=add&id="+item.id+"'><i class='fa fa-cart-plus' aria-hidden='true'></i></a></div>");
                     }
                 }
             });
             
         });
         
         

     
    
        function doSuggest(){
            var keyword = $('#search').val();
            $.ajax({
                url: 'catalog?action=suggest',
                method: 'GET',
                data: { keyword : keyword },
                success: function(resp){
                    $("#list").empty();
                    for (let item of resp){
                        $("#list").append("<option style='width: 300px;'>"+item.nome+"</option>");
                        
                    }
                }
            });
        }
        
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
            
            if($("#quarzo:checked").val()==undefined){
                $("#quarzo").val("");
            }else{
                $('#quarzo').val("Quarz");
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
            
            if($("#citrino:checked").val()==undefined){
                $("#citrino").val("");
            }else{
                $('#citrino').val("Citrine");
            }
            
            $.ajax({
                url: 'catalog?action=filter',
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
                        quarzo: $('#quarzo').val(),
                        giada: $('#giada').val(),
                        quarzorosa: $('#quarzorosa').val(),
                        citrino: $('#citrino').val()
                },
                success: function(resp) {
                    $("#catalogTable").empty();
                        for (let item of resp) {
                            $("#catalogTable").append("<div class='card'><a target='_blank' href='images//" +item.immagine+"'><img src='images//" +item.immagine+"' alt='"+item.nome+"'></a><p>"+item.nome+"</p><p>"+item.prezzo+"€</p><a href='details?id="+item.id+"'> <i class='fa fa-eye' aria-hidden='true''></i></a><a href='cart?action=add&id="+item.id+"'><i class='fa fa-cart-plus' aria-hidden='true'></i></a></div>");
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
           if ($("#prezzo").prop("checked") == true ) {  
                $(".checkboxInterne#1").css("display","block");
            }
            else{
                $(".checkboxInterne#1").css("display","none"); 
            }
        }
        
        function enableCategory() {
            if ($("#categoria").prop("checked") == true ) {  
                $(".checkboxInterne#3").css("display","block");  
            }
            else{
                $(".checkboxInterne#3").css("display","none"); 
            }
        }
        
        function enableGemstone() {
            if ($("#pietra").prop("checked") == true ) {  
                $(".checkboxInterne#4").css("display","block");  
            }
            else{
                $(".checkboxInterne#4").css("display","none"); 
            }
        }
        
        function enableMaterial() {
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
