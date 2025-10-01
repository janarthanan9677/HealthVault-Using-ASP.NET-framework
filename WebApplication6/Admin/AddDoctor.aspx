<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddDoctor.aspx.cs" Inherits="WebApplication6.Admin.AddDoctor" %>
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


    </style>
   
    <h2>Add New Doctor</h2>
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
            <asp:ListItem Text="Doctor" Value="Doctor" />
            <asp:ListItem Text="Admin" Value="Admin" />
        </asp:DropDownList><br />

        <asp:Label Text="Full Name" runat="server" />
        <asp:TextBox ID="txtFullName" runat="server" /><br />

        <asp:Label Text="Email" runat="server" />
        <asp:TextBox ID="txtEmail" runat="server" /><br />

        <asp:Label Text="Phone" runat="server" />
        <asp:TextBox ID="txtPhone" runat="server" /><br />

        <asp:Label Text="Specialization" runat="server" />
        <asp:TextBox ID="txtSpec" runat="server" /><br />

        <asp:Label Text="Department" runat="server" />
        <asp:TextBox ID="txtDept" runat="server" /><br />

        <asp:Label Text="Qualification" runat="server" />
        <asp:TextBox ID="txtQual" runat="server" /><br />

        <asp:Label Text="Experience (Years)" runat="server" />
        <asp:TextBox ID="txtExp" runat="server" /><br />

        <asp:Label Text="Consultation Fee" runat="server" />
        <asp:TextBox ID="txtFee" runat="server" /><br />

        <asp:Label Text="License Number" runat="server" />
        <asp:TextBox ID="txtLicense" runat="server" /><br />

        <asp:Label Text="Status" runat="server" />
        <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Text="Active" Value="Active" />
            <asp:ListItem Text="On Leave" Value="On Leave" />
            <asp:ListItem Text="Retired" Value="Retired" />
        </asp:DropDownList><br />

        <asp:Button ID="btnSave" runat="server" Text="Save Doctor" OnClick="btnSave_Click" CssClass="btn" /><br />
        <asp:Label ID="lblMsg" runat="server" ForeColor="Green" />

            
</div>
  
    
</asp:Content>
