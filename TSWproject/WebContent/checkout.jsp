<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, it.unisa.model.*"%>


<!DOCTYPE html>
<html>
	<head>
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<meta charset="UTF-8">
		<title>Pagamento</title>
		<!-- <link rel="stylesheet" href="styles/formStyle.css" type="text/css"> -->
	</head>
	<body>
	<h1>Checkout</h1>
    
    <form action="payment" method="post">
		<input type="hidden" name="action" value="confirm_buy">
        
        <br>
        <label for="destinatario">Insert destinatario:</label><br>
        <input name="destinatario" type="text" maxlenght="30" required placeholder="destinatario">
        <br>
        
        <br>
        <label for="pagamento">Insert pagamento:</label><br>
        <input name="pagamento" type="text" maxlenght="20" required placeholder="carta">
        <br>
        
        <br>
        <label for="indirizzo">indirizzo:</label><br>
        <input name="indirizzo" type="text" maxlenght="20" required placeholder="via roma 69">
        <!-- pulsante per prendere eventualmente indirizzo del cliente in automatico (client.getindirizzo())-->
        <br>
        
        <br>
        <label for="note">Note:</label><br>
        <input name="note" type="text" maxlenght="30" required placeholder="bla">
        <br>
        
        <br>
        <label for="spedizione">Spedizione:</label><br>
        <input name="spedizione" type="text" maxlenght="30" required placeholder="rapida">
        <br>
        
        <br>
         <label for="regalo">regalo:</label><br>
 		<input name="regalo" type="checkbox" value="true">
        <br>
        
     
        <br>
        <input type="submit" value="Paga">
        <br>
    </form>
    
</body>
</html>