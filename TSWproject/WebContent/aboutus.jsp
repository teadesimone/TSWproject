<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>About Us</title>
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

        p {
            line-height: 1.5;
            color: #18020C;
            font-size: 16px;
            margin-bottom: 10px;
            text-align: center;
            margin: 0 20%;
        }

        .signature {
            text-align: right;
            font-style: italic;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/header.jsp" %>
        <h1>About Us</h1>
        <p>Welcome to Jade Tear, your enchanting online world of jewelry! We are here to sprinkle a little magic and sparkle into your life with our delightful collection of whimsical jewels.</p>

        <p>At Jade Tear, we believe that gemstones are nature's miracles, each possessing its unique beauty and energy. Our passion lies in harnessing the power and allure of gemstones to create exquisite jewelry that will captivate your heart.</p>

        <p>Step into our mystical realm and discover a treasure trove of jade, amethyst, rose quartz, and many other gemstones that will awaken your senses and fill your life with positive vibrations.</p>

        <p>Every piece of jewelry at Jade Tear is carefully crafted, accentuating the natural beauty of gemstones. From delicate necklaces adorned with shimmering aquamarines to stunning rings featuring sparkling quarzs, our collection showcases the splendor of nature's gems.</p>

        <p>Whether you're seeking a piece of jewelry for its healing properties, spiritual significance, or simply to add a touch of elegance to your style, Jade Tear offers a curated selection that celebrates the beauty and energy of gemstones.</p>

        <p>Thank you for choosing Jade Tear. We're delighted to be a part of your gemstone journey.</p>

        <p class="signature">Magically yours,</p>
        <p class="signature">The Jade Tear Team</p>
    <%@include file="/WEB-INF/footer.jsp" %>
</body>
</html>