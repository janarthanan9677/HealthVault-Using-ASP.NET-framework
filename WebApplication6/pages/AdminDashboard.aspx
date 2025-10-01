<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WebApplication6.AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .admin-dashboard {
    text-align: center;
    padding: 30px;
}

.admin-menu {
    margin-top: 20px;
}

.admin-btn {
    margin: 10px;
    padding: 15px 30px;
    font-size: 16px;
    background-color: #007acc;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

.admin-btn:hover {
    background-color: #005f99;
}

.logout {
    background-color: #d9534f;
}

.logout:hover {
    background-color: #b52b27;
}

    </style>
 <div class="admin-dashboard">
        <h2>Welcome, Admin</h2>
        <p>Select a module to manage:</p>

        <div class="admin-menu">
            <asp:Button ID="btnManageDoctors" runat="server" Text="Manage Doctors" CssClass="admin-btn" OnClick="btnManageDoctors_Click" />
            <asp:Button ID="btnManageNurses" runat="server" Text="Manage Nurses" CssClass="admin-btn" OnClick="btnManageNurses_Click" />
            <asp:Button ID="btnManageStaff" runat="server" Text="Manage Staff" CssClass="admin-btn" OnClick="btnManageStaff_Click" />
            <asp:Button ID="btnReports" runat="server" Text="Reports" CssClass="admin-btn" OnClick="btnReports_Click" />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="admin-btn logout" OnClick="btnLogout_Click" />
        </div>
    </div>    
    </asp:Content>
