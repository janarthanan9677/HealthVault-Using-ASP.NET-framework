<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addstaff.aspx.cs" Inherits="WebApplication6.Admin.addstaff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
                <style>
        /* Container */
.form-container {
    width: 450px;
    margin: 40px auto;
    padding: 30px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

/* Page Title */
h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #2c3e50;
    font-weight: 600;
}

/* Labels */
.form-container label {
    display: block;
    margin-top: 12px;
    margin-bottom: 4px;
    font-weight: bold;
    color: #444;
}

/* Inputs & Dropdowns */
.form-container input[type="text"],
.form-container input[type="password"],
.form-container input[type="email"],
.form-container input[type="number"],
.form-container select {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease-in-out;
}

.form-container input:focus,
.form-container select:focus {
    border-color: #007bff;
    outline: none;
}

/* Button */
.btn {
    display: block;
    width: 100%;
    background: #007bff;
    color: white;
    font-size: 15px;
    font-weight: bold;
    padding: 12px;
    margin-top: 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease-in-out;
}

.btn:hover {
    background: #0056b3;
}

/* Message Label */
#lblMsg {
    display: block;
    margin-top: 12px;
    text-align: center;
    font-size: 14px;
    font-weight: 600;
}
.btnBack {
    background-color: #004c99;
    color: white;
    padding: 8px 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}
.btnBack:hover {
    background-color: #0066cc;
}
input[type="date"] {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    background-color: #fff;
    color: #333;
    transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

/* On focus */
input[type="date"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 4px rgba(0,123,255,0.4);
}



/* Calendar icon (Chrome/Edge/Safari) */
input[type="date"]::-webkit-calendar-picker-indicator {
    cursor: pointer;
    filter: invert(40%) sepia(80%) saturate(200%) hue-rotate(190deg);
    opacity: 0.8;
    transition: opacity 0.3s;
}

input[type="date"]::-webkit-calendar-picker-indicator:hover {
    opacity: 1;
}


    </style>
   
    <h2>Add New Staff</h2>
            <div style="text-align:right; margin-left:15px;">
<asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" 
    CssClass="btnBack" OnClick="btnBack_Click"  />
                </div>
    <div class="form-container">
        <asp:Label Text="Username" runat="server" />
        <asp:TextBox ID="txtUsername" runat="server" /><br />

        <asp:Label Text="Password" runat="server" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" /><br />

        <asp:Label Text="Role" runat="server" />
        <asp:DropDownList ID="ddlRole" runat="server">
            <asp:ListItem Text="FrontDesk" Value="FrontDesk" />
            <asp:ListItem Text="Pharmacy" Value="Pharmacy" />
            <asp:ListItem Text="Other Staff" Value="otherStaff" />
            <asp:ListItem Text="Admin" Value="Admin" />
        </asp:DropDownList><br />

        <asp:Label Text="Full Name" runat="server" />
        <asp:TextBox ID="txtFullName" runat="server" /><br />

        <asp:Label Text="Gender" runat="server" />
        <asp:DropDownList ID="ddlGender" runat="server">
        <asp:ListItem Text="Male" Value="Male" />
        <asp:ListItem Text="Female" Value="Female" />
        </asp:DropDownList><br />

        <asp:Label Text="Address" runat="server" />
        <asp:TextBox ID="txtAddress" runat="server" /><br />

        <asp:Label Text="Date of birth" runat="server" />
        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" /><br />


        <asp:Label Text="Email" runat="server" />
        <asp:TextBox ID="txtEmail" runat="server" /><br />

        <asp:Label Text="Phone" runat="server" />
        <asp:TextBox ID="txtPhone" runat="server" /><br />

        <asp:Label Text="Qualification" runat="server" />
        <asp:TextBox ID="txtQual" runat="server" /><br />

        <asp:Label Text="Salary" runat="server" />
        <asp:TextBox ID="txtSalary" runat="server" /><br />

        <asp:Label Text="Joining Date" runat="server" />
        <asp:TextBox ID="txtJoiningDate" runat="server" TextMode="Date" /><br />

        <asp:Label Text="Status" runat="server" />
        <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Text="Active" Value="Active" />
            <asp:ListItem Text="On Leave" Value="On Leave" />
            <asp:ListItem Text="Retired" Value="Retired" />
        </asp:DropDownList><br />

        <asp:Button ID="btnSave" runat="server" Text="Save Staff" OnClick="btnSave_Click" CssClass="btn" /><br />
        <asp:Label ID="lblMsg" runat="server" ForeColor="Green" />

            
</div>
</asp:Content>
