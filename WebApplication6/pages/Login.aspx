<%@ Page Title="Login" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication6.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
<style>
        .login-wrapper {
            margin: 0;
            padding: 0;
            font-family: "Inter", Arial, sans-serif;
            background-color: #f0f4f8;
            background-image: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2)), url('https://placehold.co/1920x1080/4B5563/FFFFFF?text=Hospital');
            background-repeat: no-repeat;
            background-position: center center;
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #1F2937;
            transition: background-image 0.5s ease;
        }
        .login-wrapper {
            width: 100%;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-card {
            background: #ffffff;
            padding: 40px 35px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            width: 380px;
            max-width: 100%;
            text-align: center;
            transition: all 0.3s ease-in-out;
            border-top: 5px solid #3B82F6;
        }
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            color: #4B5563;
            margin-bottom: 8px;
            font-size: 15px;
        }
        .input {
            width: 100%;
            padding: 14px;
            border: 1px solid #E5E7EB;
            border-radius: 10px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
            box-sizing: border-box;
            background-color: #F9FAFB;
        }
        .input:focus {
            border-color: #3B82F6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
            background-color: #fff;
        }
        .btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            background-color: #3B82F6;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }
        .btn:hover {
            background-color: #2563EB;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
        }
        .btn:active {
            background-color: #1D4ED8;
            transform: translateY(-1px);
            box-shadow: 0 2px 10px rgba(29, 78, 216, 0.4);
        }
        .msg {
            display: block;
            margin-bottom: 20px;
            font-size: 14px;
            color: #EF4444;
            font-weight: 500;
        }
        .hidden {
            display: none;
        }
        
    </style>

     <div class="login-wrapper">
        <div class="login-card">
            <asp:Label ID="lblMessage" runat="server" CssClass="msg" ForeColor="Red" />

            <div class="form-group">
                <asp:Label ID="lblUser" runat="server" Text="Username" AssociatedControlID="txtUsername" />
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input" />
            </div>

            <div class="form-group">
                <asp:Label ID="lblPass" runat="server" Text="Password" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />   
    </div>
</div>
        
</asp:Content>

