<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminAddUser.aspx.cs" Inherits="WebApplication6.AdminAddUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-container {
    max-width: 400px;
    margin: 20px auto;
    padding: 20px;
    background: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0px 2px 6px rgba(0,0,0,0.2);
        }
        .form-control {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }

    </style>
     <h2>Add New User</h2>
    <div class="form-container">
        <asp:Label ID="lblName" runat="server" Text="Full Name:" AssociatedControlID="txtName"></asp:Label>
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox><br />

        <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail"></asp:Label>
        &nbsp;
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red"></asp:RegularExpressionValidator>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox><br />

        <asp:Label ID="lblPhone" runat="server" Text="Phone no:" AssociatedControlID="txtPhone"></asp:Label>
        &nbsp;
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Required 10 digits" ControlToValidate="txtPhone" ValidationExpression="^\d{10}$" ForeColor="Red"></asp:RegularExpressionValidator>
        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox><br />

        <asp:Label ID="lblUsername" runat="server" Text="Username:" AssociatedControlID="txtUsername"></asp:Label>
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUsername" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox><br />

        <asp:Label ID="lblPassword" runat="server" Text="Password:" AssociatedControlID="txtPassword"></asp:Label>
        &nbsp;
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPassword" ErrorMessage="required One Captial,number and special characters." ValidationExpression="^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&amp;*]).{8,}$" ForeColor="Red"></asp:RegularExpressionValidator>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox><br />
       
        <asp:Label ID="lblCPassword" runat="server" Text="Confirm Password:" AssociatedControlID="txtCPassword"></asp:Label>
        &nbsp;&nbsp;
        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtCPassword" ErrorMessage="password is mismatch" ForeColor="Red"></asp:CompareValidator>
        <asp:TextBox ID="txtCPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox><br />

        <asp:Label ID="lblRole" runat="server" Text="Role:" AssociatedControlID="ddlRole"></asp:Label>
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlRole" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
            <asp:ListItem Text="Select Role" Value=""></asp:ListItem>
            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
            <asp:ListItem Text="Doctor" Value="Doctor"></asp:ListItem>
            <asp:ListItem Text="Nurse" Value="Nurse"></asp:ListItem>
            <asp:ListItem Text="Patient" Value="Patient"></asp:ListItem>
        </asp:DropDownList><br />

        <asp:Button ID="btnAddUser" runat="server" Text="Add User" CssClass="btn" OnClick="btnAddUser_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
    </div>
</asp:Content>
