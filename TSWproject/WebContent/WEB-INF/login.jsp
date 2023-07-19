<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="./styles/formStyle.css">
    <title>Login page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        *{
                height: 100%;
                margin: auto;
                width: 100%;
        }
        
        .container{
            display: grid;
            grid-template-columns: 25% 50% 25%;
            width: 100%;
        }

        .card{
            grid-column:  2/3;
            display: grid;
            grid-template-columns: 1fr;
            grid-template-rows: 15% 70% 7.5% 7.5%;
            height:80%;
            width:70%;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            gap: 10px;
        }
        .title{
            grid-column: 1/3;
            grid-row: 1;
            width:100%;
            height:100%;
            margin-top: 8%;
            bottom: 30px;
            text-align:center;
        }

        .link{
            grid-column: 1/3;
            grid-row: 4;
            width:100%;
            height:100%;
            margin-bottom:0;
            margin-top: 20px;
            text-align:center;
        }


        .inputBox{
            display: inline-flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .error{
            transform: translateY(-100%);
        }

        .submitContainer{
            grid-row: 3;
            margin:auto;
            text-align:center;
        }

        .submit{
            height: 65%;
            width: 25%;
            padding:0.5%;
            margin:auto;
        }

        #passwordLabel{
            padding: 6px;
        }

        @media only screen and (max-width: 900px){ /* media query per tablet e schermi laptop medi */
            .container{
                grid-template-columns: 1fr 5fr 1fr;
            }
            .card{
                width:100%;
            }
        }

        @media only screen and (max-width: 480px){ /* media query per smartphone */
            .container{
                grid-template-columns: 1fr;
            }
            .card{
                grid-column:1;
                width:100%;
            }
        }

        /*
        .link{
            grid-column: 2/3;
            margin: auto;
            top:50%;
        }*/
        /*
        .link{
            top: 80%;
            bottom: 37%;
            margin: auto;
        }
        */
    </style>
</head>
<body>
    <form action="login" method="post" onsubmit="event.preventDefault(); validate(this)">
        <div class="container">
            <div class="card">
                <span class="title">Login</span>

                <div class="inputBox">
                    <span class="error" id="errorEmail"></span>
                    <input id="email" name="email" type="email" maxlenght="30" required placeholder="myemail@domain.com" autocomplete="off">
                    <label id="emailLabel" for="email"> Email: </label>
                </div>

                <div class="inputBox">
                    <input id="password" name="password" type="password" maxlenght="20" required placeholder="password123" autocomplete="off">
                    <label id="passwordLabel" for="password">Password:</label>
                </div>

                <input type="hidden" name="action" value="login">
                <div class="submitContainer">
                    <input class="submit" type="submit" value="Submit">
                </div>
                <div class="link">
                    <span>You haven't register yet? Sign up <a href= "registration"> here</a></span>
                    <span>Return to <a href="home"> home </a></span>
                </div>
            </div>
        </div>
    </form>
    <script>
        $(document).ready(function () {

            $("#email").on("input", function() {
                if ($("#email").val().length !== 0)
                $("#emailLabel").addClass("notEmpty");
                else
                $("#emailLabel").removeClass("notEmpty");
            });

        })

        function validate(obj) {	
            let valid = true;	

            let email = document.getElementsByName("email")[0];    
            let errorEmail = document.getElementById('errorEmail');
            if(!checkEmail(email)) {
                valid = false;
                errorEmail.textContent = "Error: invalid email address";

            } else {
                errorEmail.textContent = ""; 
            }

            if(valid) obj.submit();
        }    

        function checkEmail(inputtxt) {
            let email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if(inputtxt.value.match(email)) 
            return true;

            return false;	
        }
    </script>

</body>
</html>