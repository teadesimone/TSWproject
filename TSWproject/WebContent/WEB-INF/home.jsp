<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
   ArrayList<JewelBean> products= (ArrayList<JewelBean>) request.getAttribute("prodotti");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title> JadeTear Home </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
     <style>
.grid-container {
  display: grid;
  grid-template-columns: auto ;
  grid-template-rows: auto auto auto auto auto;
  gap: 60px;
  background: rgba(250,250,250);
 
  
}

.grid-container > div {

  font-size: 30px;
}

.slider-gioielli {
  width: 100%;
  height: 100%;
  overflow-x: auto;
  overflow-y: hidden;
  padding:0.5%;
  background: transparent;

}

.slider-container {
  display: flex;
  height: auto;

 
}
.product-card {
  
 flex : 0 0 20%;
 background: rgba(240,240,240);
 border: 2px solid #84A8A1;
  border-radius: 20px;
  margin: 1%;
 text-align: center;
  width : 40%;
  height: 80%;
  padding : 2%; 
}

.slider-container img {
  width: 60%;
  height: 50%;
  transition: transform .2s;
  border: 2px solid #84A8A1;
  border-radius: 10px;
  
}

.slider-container img:hover {
  -ms-transform: scale(1.2); /* IE 9 */
  -webkit-transform: scale(1.2); /* Safari 3-8 */
  transform: scale(1.2); 
}

.slider-container p,.slider-container a{
 font-family: "Times New Roman", serif, sans-serif; 
 font-size: 20px;

}

.product-card a:link,.product-card a:visited {
  background-color: white;
  color: black;
  border: 2px #84A8A1;
  padding: 5%;
  border-radius: 20px;
  
  text-align: center;
  text-decoration: none;
  display: inline-block;
}

.product-card a:hover,.product-card a:active {
  background-color: #4C8577;
  color: white;
  padding: 5%;
  border-radius: 20px;
}

.banner{
  background-image: url("images/banner.jpg");
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
  flex-direction: column;
 background-position: center; /* Center the image */
  background-repeat: no-repeat; /* Do not repeat the image */
  background-size: cover;
}

.content{
  
  text-align: center;
  background: rgba(255,255,255,0.7);
  padding: 5%;
  
} 

.content p,.content h1{

  font-family: "Times New Roman", serif, sans-serif; 
  font-size: 100%;
  
  color: #000000;
}

.content a:link,.content a:visited {
  
  background: rgba(255,255,255,0.1);
  color: black;
  border: 2px solid #84A8A1;
  padding: 5%;
  border-radius: 20px;
  

  text-align: center;
  text-decoration: none;
  display: inline-block;
}

.content a:hover,.content a:active {
  background-color: #4C8577;
  color: white;
  border-radius: 20px;
}

.slider-pietre {
  display: flex;
  flex-flow: row wrap;
 padding-left: 5%;
 padding-top: 2%;
 padding-bottom: 2%;
 border-top-style: double;
 border-bottom-style: double;
 border-color: #84A8A1;
}

.pietra{
  
  flex : 0 0 30%;
  width : 32%;
  height: 45%;
  background-image: url("images/giada.jpg");
  overflow: hidden;
  margin :1%;
  text-align : center;
  background-position: center; /* Center the image */
  background-repeat: no-repeat; /* Do not repeat the image */
  background-size: cover;
  border-radius: 10px;
  border: 2px solid #84A8A1;
  
  
  }
  
  .pietra1{

    flex : 0 0 30%;
    width : 32%;
    height: 45%;
    background-image: url("images/ametista.jpg");
    overflow: hidden;
    margin :1%;
    text-align : center;
    background-position: center; /* Center the image */
    background-repeat: no-repeat; /* Do not repeat the image */
    background-size: cover;
    border-radius: 10px;
    border: 2px solid #84A8A1;
    

  }
  .pietra2{

    flex : 0 0 30%;
    width : 32%;
    height: 45%;
    background-image: url("images/quarzorosa.jpg");
    overflow: hidden;
    margin :1%;
    text-align : center;
    background-position: center; /* Center the image */
    background-repeat: no-repeat; /* Do not repeat the image */
    background-size: cover;
    border-radius: 10px;
    border: 2px solid #84A8A1;

  }
  .pietra3{

    flex : 0 0 30%;
    width : 32%;
    height: 45%;
    background-image: url("images/quarzo.png");
    overflow: hidden;
    margin :1%;
    text-align : center;
    background-position: center; /* Center the image */
    background-repeat: no-repeat; /* Do not repeat the image */
    background-size: cover;
    border-radius: 10px;
    border: 2px solid #84A8A1;

  }
  .pietra4{

    flex : 0 0 30%;
    width : 32%;
    height: 45%;
    background-image: url("images/quarzo-citrino.jpg");
    overflow: hidden;
    margin :1%;
    text-align : center;
    background-position: center; /* Center the image */
    background-repeat: no-repeat; /* Do not repeat the image */
    background-size: cover;
    border-radius: 10px;
    border: 2px solid #84A8A1;
  }
  .pietra5{

    flex : 0 0 30%;
    width : 32%;
    height: 45%;
    background-image: url("images/aquamarine.jpg");
    overflow: hidden;
    margin :1%;
    text-align : center;
    background-position: center; /* Center the image */
    background-repeat: no-repeat; /* Do not repeat the image */
    background-size: cover;
    border-radius: 10px;
    border: 2px solid #84A8A1;
  }
  
  .testo{
    font-family: "Times New Roman", serif, sans-serif; 
    font-size: 50%;
    opacity: 0.0;
    transition: 0.5s;
    
  }
  .testo:hover {
    font-family: "Times New Roman", serif, sans-serif; 
    font-size: 50%;
    opacity: 0.7;
    background-color:white;
   
  }

h1{

display: flex;
justify-content: center;
text-align: center;
color: #4C8577;
padding: 1%;
border-top-style: double;
border-bottom-style: double;
border-color: #84A8A1;
font-family: "Times New Roman", serif, sans-serif; 


}

@media screen and (max-width: 880px){

  .pietra,.pietra1,.pietra2,.pietra3,.pietra4,.pietra5{

  flex : 0 0 40%;
   width : 32%;
  height: 32%;
  }

}

@media screen and (max-width: 450px){

  .pietra,.pietra1,.pietra2,.pietra3,.pietra4,.pietra5{

  flex : 0 0 90%;
  height: 16%;
  
  }

}





</style>
 
</head>

<body>
  <div class="grid-container" id="1">
      <div class="header" >
        <%@include file="/WEB-INF/header.jsp" %></div>
      <div class="banner" >
        
        <div  class="content" >
          
          <h1>Jade Tear</h1>
          <p>Visit our catalog </p>
          <a href="catalog"> Catalog </a>
        
        </div>
      
      </div>
      
    <h1> Check some of our jewels !</h1>
      
      <div class="slider-gioielli">
            <div class="slider-container">
                <% for (JewelBean prodotto : products){%>
                 <div class = "product-card">
                     <img src= "<%= "images//" + prodotto.getImmagine() %>" alt="<%=prodotto.getNome() %>">
                     <p><b><%=prodotto.getNome()%></b></p>
                     <p><b><%=prodotto.getPrezzo()%>€</b></p>
                     <a href="<%= "details?id=" + prodotto.getId() %>"> Product details</a>
                 </div>
 
                <% } %>
            </div>
         </div>
     
         
         <h1> Experience the allure of these gemstones and many more at Jade Tear</h1>
      
      <div class="slider-pietre">
        
              <div class="pietra">
                    <div class="testo">
                      <h3>Jade</h3>
                      <p>Jade, a symbol of harmony and purity, is one of the most cherished gemstones worldwide. With its captivating shades of green, Jade exudes a sense of serenity and balance. It's a gemstone revered for its spiritual significance and believed to bring prosperity and good fortune.</p>
                      <p>Properties: Jade belongs to two mineral groups: nephrite and jadeite. Nephrite jade is usually found in shades of dark green, while jadeite jade offers a wider color spectrum. They are ideal for crafting intricate jewelry pieces that stand the test of time.</p>
                    </div>
              </div> 
              
              <div class="pietra1">
                
                    <div class="testo">
                      <h3>Amethyst</h3>
                      <p>The Amethyst is bewitching gemstone renowned for its stunning purple hues. This gem exudes an aura of elegance and mystique, making it a popular choice for both modern and classic jewelry designs. Amethyst has fascinated civilizations throughout history.</p>
                      <p>Properties: Amethyst is a purple variety of quartz and owes its alluring color to trace amounts of iron and aluminum in its crystal structure. Amethyst offers excellent durability, ensuring that your cherished pieces retain their brilliance for generations to come.</p>
                    </div>
                  
              </div> 
              
              <div class="pietra2">
                
                  <div class="testo">
                    <h3>Rose Quartz</h3>
                    <p>Embrace the tender allure of Rose Quartz, the gem of love and compassion. With its delicate shades of pink, this gemstone exudes a soothing energy that nurtures the heart and fosters emotional healing. Rose Quartz captures the essence of affection.</p>
                    <p>Properties: Rose Quartz is a member of the quartz family and obtains its soft pink color from traces of titanium, iron, or manganese.This gem ensures your jewelry maintains its delightful pink allure while offering a remarkable combination of durability and elegance.</p>
                  </div>
             
              </div>
              
              
              <div class="pietra3">
               
                  <div class="testo">
                    <h3>Quartz</h3>
                    <p>A versatile and timeless beauty, Quartz enchants with its clear, crystal-like appearance. Known as the "Master Healer" in the gem world, Quartz is believed to amplify energies and promote clarity of thought. Its neutrality allows it to complement any style effortlessly.</p>
                    <p>Properties: Quartz is composed of silicon and oxygen, forming a crystal lattice structure. This gemstone boasts excellent scratch resistance, ensuring your Quartz jewelry stays brilliant for years to come.</p>
                  </div>
                
              </div> 
              
              <div class="pietra4">
               
                  <div class="testo">
                    <h3>Citrine</h3>
                    <p>Immerse yourself in the warmth of Citrine, a gemstone that embodies the sun's radiance. With its golden-yellow hues, Citrine infuses joy, success, and abundance into every facet of life. This gem shines as bright as the sun, casting a warm glow on those who wear it.</p>
                    <p>Properties: Citrine is a variety of quartz colored by traces of iron in its crystal structure. Its Mohs hardness of 7 makes it a durable choice for jewelry, allowing you to flaunt your Citrine pieces with confidence and charm.</p>
                  </div>
             
              </div> 
              
              <div class="pietra5">
               
                  <div class="testo">
                    <h3>Aquamarine</h3>
                    <p>Dive into the tranquil beauty of Aquamarine, reminiscent of the serene ocean waters. With its mesmerizing blue tones, this gemstone embodies a sense of calmness and clarity. Just like a refreshing seaside escape, Aquamarine rejuvenates the soul.</p>
                    <p>Properties: Aquamarine is a variety of beryl, sharing its family with emeralds. Its captivating blue color comes from traces of iron in the crystal structure. With a hardness rating of 7.5 to 8 on the Mohs scale, Aquamarine ensures lasting brilliance for your cherished jewelry pieces.</p>
                  </div>
               
              </div> 
        
      </div>
      
      <p style="text-align:center;"><a href="#1"><i class="fa fa-angle-double-up" aria-hidden="true"></i></a><br> Go up!</p>
       
      
      <div class="footer">
         <%@include file="/WEB-INF/footer.jsp" %>
      </div>

</div>



</body>

</html>
