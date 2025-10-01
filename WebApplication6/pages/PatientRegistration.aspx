<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PatientRegistration.aspx.cs" Inherits="WebApplication6.pages.PatientRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-container {
            width: 600px;
            margin: 30px auto;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #004080;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .success-message {
            display: block;
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
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
    .btnBack:hover { background-color: #0066cc; }
    </style>

    <div class="form-container">
        <h2>Patient Registration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" 
        CssClass="btnBack" OnClick="btnBack_Click"  />

        </h2>

        <!-- First & Last Name -->
        <asp:Label Text="First Name:" AssociatedControlID="txtFirstName" runat="server" />
        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>

        <asp:Label Text="Last Name:" AssociatedControlID="txtLastName" runat="server" />
        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>

        <!-- Gender -->
        <asp:Label Text="Gender:" runat="server" />
        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
            <asp:ListItem Text="--Select--" Value="" />
            <asp:ListItem Text="Male" Value="Male" />
            <asp:ListItem Text="Female" Value="Female" />
            <asp:ListItem Text="Other" Value="Other" />
        </asp:DropDownList>

        <!-- DOB -->
        <asp:Label Text="Date of Birth:" AssociatedControlID="txtDOB" runat="server" />
        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>

        <!-- Blood Group -->
        <asp:Label Text="Blood Group:" runat="server" />
        <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="form-control">
            <asp:ListItem Text="--Select--" Value="" />
            <asp:ListItem>A+</asp:ListItem>
            <asp:ListItem>A-</asp:ListItem>
            <asp:ListItem>B+</asp:ListItem>
            <asp:ListItem>B-</asp:ListItem>
            <asp:ListItem>O+</asp:ListItem>
            <asp:ListItem>O-</asp:ListItem>
            <asp:ListItem>AB+</asp:ListItem>
            <asp:ListItem>AB-</asp:ListItem>
        </asp:DropDownList>

        <!-- Marital Status -->
        <asp:Label Text="Marital Status:" runat="server" />
        <asp:DropDownList ID="ddlMaritalStatus" runat="server" CssClass="form-control">
            <asp:ListItem Text="--Select--" Value="" />
            <asp:ListItem>Single</asp:ListItem>
            <asp:ListItem>Married</asp:ListItem>
            <asp:ListItem>Divorced</asp:ListItem>
            <asp:ListItem>Widowed</asp:ListItem>
        </asp:DropDownList>

        <!-- Contact Numbers -->
        <asp:Label Text="Primary Contact:" AssociatedControlID="txtContact" runat="server" />
        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control"></asp:TextBox>

        <asp:Label Text="Alternate Contact:" AssociatedControlID="txtAltContact" runat="server" />
        <asp:TextBox ID="txtAltContact" runat="server" CssClass="form-control"></asp:TextBox>

        <!-- Email -->
        <asp:Label Text="Email:" AssociatedControlID="txtEmail" runat="server" />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>

        <!-- Address -->
        <asp:Label Text="Address:" AssociatedControlID="txtAddress" runat="server" />
        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>

        <asp:Label Text="City:" AssociatedControlID="txtCity" runat="server" />
        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>

        <asp:Label Text="State:" AssociatedControlID="txtState" runat="server" />
        <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>

        <asp:Label Text="Pincode:" AssociatedControlID="txtPincode" runat="server" />
        <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control"></asp:TextBox>

        <!-- Emergency Contact -->
        <asp:Label Text="Emergency Contact Name:" AssociatedControlID="txtEmergencyName" runat="server" />
        <asp:TextBox ID="txtEmergencyName" runat="server" CssClass="form-control"></asp:TextBox>

        <asp:Label Text="Emergency Contact Number:" AssociatedControlID="txtEmergencyNumber" runat="server" />
        <asp:TextBox ID="txtEmergencyNumber" runat="server" CssClass="form-control"></asp:TextBox>

        <!-- Medical History -->
        <asp:Label Text="Medical History:" AssociatedControlID="txtMedicalHistory" runat="server" />
        <asp:TextBox ID="txtMedicalHistory" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>

        <!-- Allergies -->
        <asp:Label Text="Allergies:" AssociatedControlID="txtAllergies" runat="server" />
        <asp:TextBox ID="txtAllergies" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control"></asp:TextBox>

        <!-- Register Button -->
        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="btnRegister_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="success-message"></asp:Label>
    </div>
</asp:Content>
