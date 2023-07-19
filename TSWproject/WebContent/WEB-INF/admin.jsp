<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%


JewelBean j = (JewelBean) request.getAttribute("jewel");
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>
        <title> Admin Page </title>
        <link rel="stylesheet" type="text/css" href="./styles/multi-formStyle.css">
        <style>
            .submitContainer{
                display: flex;
                flex-direction: row;
                gap: 10px;
            }
            
          input[type="submit"], input[type="reset"] {
                height:60%;
                border-radius: 5px;
                border: 2px solid #4c8577;
                cursor: pointer;
                background-color: transparent;
                transition: 0.5s;
                text-transform: uppercase;
                font-size: 11px;
                letter-spacing: 2px;
                margin-bottom: 1em;
                color: #4c8577;
            }

      input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #4c8577;
            color: white;
        }
        
            #load, #delete {
            color: #AEA4B4;
            border: 2px solid #AEA4B4;
            }
            
           #load:hover, #delete:hover {
            background-color: #AEA4B4;
            color: white;
            }
            
        </style>
</head>

<body>
    <div class="grid-container">
        <div class="header">
            <%@include file="header.jsp" %></div>
        <div class="screen-container">    
        <span class="title"> Admin Page </span>
        
        <div class="transparentCard">
        <% if (error != null){%>
                <div class="errorNoTranslate"><%=error%></div>
        <%}%>
        <form class="formContainer" action="admin" method="post" enctype="multipart/form-data">
                <span class="subtitle">Add a jewel</span>
                <input type="hidden" name="action" value="insert">

                <div class="inputBox">
                <input name="name" type="text" maxlength="50" required placeholder="enter name">
                <label for="name">Name:</label>
                </div>
                
                <div class="inputBox special">
                <label for="category">Category:</label>
                <select name="category">
                    <option value="Necklace"> Necklace </option>
                    <option value="Earrings"> Earrings </option>
                    <option value="Ring"> Ring </option>
                    <option value="Bracelet"> Bracelet </option>

                </select>
                </div>
                
                <div class="inputBox special">
                <label for="gemstone">Gemstone:</label>
                <select name="gemstone">
               	 	 <option value="Jade"> Jade </option>
               		 <option value="Amethyst">Amethyst </option>
                        <option value="Quarz"> Quarz </option>
                     <option value="Rose Quarz"> Rose Quarz </option>
                     <option value="Citrine"> Citrine </option>
                     <option value="Aquamarine"> Aquamarine </option>
             
           		  </select>  
                </div>

                <div class="inputBox special">
                <label for="image">Image:</label>
                <input name="image" type="file" required>
                </div>

                <div class="inputBox special">
                <label for="availability">Availability:</label>
                <input name="availability" type="number" min="0" required>
                </div>

                <div class="inputBox special">
                <label for="IVA">IVA:</label>
                <input name="IVA" type="number" min="1" max="22" value="22" required>
                </div>

                <div class="inputBox special">
                <label for="price">Price:</label>
                <input name="price" type="number" min="1" max='5000' required>
                </div>

                <div class="inputBox special">
                <label for="description">Description:</label>
                <textarea name="description" maxlength="100" rows="3" required placeholder="enter description"></textarea>
                </div>

                <div class="inputBox special">
                <label for="material">Material:</label>
                 <select name="material">
               	 	 <option value="Gold"> Gold </option>
               		 <option value="Silver"> Silver </option>
               		 <option value="Rose Gold"> Rose Gold </option>

           		  </select>  
                </div>

                <div class="inputBox special">
                <label for="discount">Discount:</label>
                <input name="discount" type="number" min="0" max="99" value="0">
                </div>
                
                <div class="submitContainer">
                <input class="submit" type="submit" value="Add">
                <input class="submit" type="reset" value="Reset">
                </div>
        </form>
        

        <form class="formContainer" action="admin" method="post">
                <span class="subtitle">Update with new info</span>
                <input type="hidden" name="action" value="load">
                <fieldset>
                        <legend> Write down the jewel's ID you want to modify</legend>
                        <label for="id">Id:</label>
                        <input name="id" type="number" required>
                        <input id="load" type="submit" value="Load">
                </fieldset>
        </form>

        <%if(j != null){%>
        	<form class="formContainer" action="admin" method="post">
        		<input type="hidden" name="action" value="modify">
        		<input type="hidden" name="idM" value=<%=j.getId() %>>
                
                <div class="inputBox">
                <input name="nameM" type="text" maxlength="50" required value="<%=j.getNome() %>">
                <label for="name">Name:</label>
                </div>
                
                <div class="inputBox special">
                <label for="category">Category:</label>
                <select name="categoryM">
                    <option value="Necklace"> Necklace </option>
                    <option value="Earrings"> Earrings </option>
                    <option value="Ring"> Ring </option>
                    <option value="Bracelet"> Bracelet </option>
                </select>
                </div>
                
                <div class="inputBox special">
                <label for="gemstone">Gemstone:</label>
                  <select name="gemstoneM">
               	 	 <option value="Jade"> Jade </option>
               		 <option value="Amethyst">Amethyst </option>
                        <option value="Quarz"> Quarz </option>
                     <option value="Rose Quarz"> Rose Quarz </option>       
                     <option value="Citrine"> Citrine </option>
                     <option value="Aquamarine"> Aquamarine </option>

           		  </select>  
                </div>
                
                <div class="inputBox special">
                <label for="image">Image:</label>
                <input name="imageM" type="text" maxlength="100" required value="<%=j.getImmagine() %>">
                </div>
                
                <div class="inputBox special">
                <label for="availability">Availability:</label>
                <input name="availabilityM" type="number" min="0" required value="<%=j.getDisponibilita() %>">
                </div>
                
                <div class="inputBox special">
                <label for="IVA">IVA:</label>
                <input name="IVAM" type="number" min="1" max='22' required value="<%=j.getIVA() %>">               
                </div>
                
                <div class="inputBox special">
                <label for="price">Price:</label>
                <input name="priceM" type="number" min="1" max='5000' required value="<%=j.getPrezzo() %>">
                </div>
                
                <div class="inputBox special">
                <label for="description">Description:</label>
                <textarea name="descriptionM" maxlength="100" rows="3" required><%=j.getDescrizione() %></textarea>
                </div>
                
                <div class="inputBox special">
                <label for="materialM">Material:</label> <select name="category">
               	  <select name="materialM">
               	 	 <option value="Gold"> Gold </option>
               		 <option value="Silver"> Silver </option>
               		 <option value="Rose Gold"> Rose Gold </option>
           		  </select>
                </div>

                <div class="inputBox special">     
                <label for="discount">Discount:</label>
                <input name="discountM" type="number" min="0" max="99" value="<%=j.getSconto() %>">
                </div>
                
                <div class="submitContainer">
                <input class="submit" type="submit" value="Modify">
                </div>
           </form>

        <%}%>

        <form class="formContainer" action="admin" method="post">
                <span class="subtitle">Delete a jewel</span>
                <input type="hidden" name="action" value="delete">
                <fieldset>
                        <legend> Write down the jewel's ID you want to delete</legend>
                        <label for="id">Id:</label>
                        <input name="id" type="number" required>
                        <input id="delete" type="submit" value="Delete">
                </fieldset>
        </form>
      </div>  
    </div>    
        
        <div class="footer">
        <%@include file="/WEB-INF/footer.jsp" %>
    </div>

</div>
</body>
</html>
