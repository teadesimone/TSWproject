<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer Service</title>
    <style>		
		body {
            font-family: "Times New Roman", serif, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;        
        }
        
        h1 {
            color: #84A8A1 ;
            text-align: center;
            font-size: 36px;
        }
        
		.contact-info,
		.other-info {
		    margin: 20px;
		    padding: 10px;
		    background-color: #fff;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}
		
		.contact-info h3,
		.other-info h3 {
		    margin-top: 0;
		    color: #AEA4B4 
		}
		
		.contact-info p,
		.other-info p {
		    margin: 5px 0;
		}
		
		.other-info ul {
		    list-style-type: disc;
		    padding-left: 20px;
		}
		
		.other-info ul li {
		    margin-bottom: 10px;
		}		    
    </style>
</head>
<body>
    <%@include file="/WEB-INF/header.jsp" %>
    <h1>Customer Service</h1>

    <div class="contact-info">
        <h3>Contact Information</h3>
        <p>If you have any questions or need assistance, don't hesitate to get in touch with us:</p>
        <p>Email: JadeTear@gmail.com</p>
        <p>Phone: 123-456-7890</p>
    </div>

    <div class="other-info">    
        <h3>Shipping</h3>
        <p>We have various shipping options available for your convenience:</p>
        <ul>
            <li><strong>Express Shipping:</strong> Delivery within 3-5 business days.</li>
            <li><strong>Standard Shipping:</strong> Delivery within 7-10 business days.</li>
            <li><strong>Economic Shipping:</strong> Delivery within 12-15 business days.</li>
        </ul>

        <h3>FAQs</h3>
        <p>Here are some frequently asked questions:</p>
        <ul>
            <li><strong>How can I track my order?</strong> Once your order is shipped, we'll keep you updated via email with tracking information.</li>
            <li><strong>What payment methods do you accept?</strong> We accept all major credit cards and PayPal.</li>
            <li><strong>Do you offer international shipping?</strong> Yes, we offer international shipping, so you can receive our products no matter where you are in the world.</li>
        </ul>
    </div>
    <%@include file="/WEB-INF/footer.jsp" %>
</body>
</html>
