<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PatientList.aspx.cs" Inherits="WebApplication6.pages.PatientList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
/* Header with logo and logout */
#header {
    display: flex;
    align-items: center;
    justify-content: space-between;
/*    background-color: #007bff;*/
    padding: 10px 20px;
    color: white;
    border-radius: 8px 8px 0 0;
}
#header .logout-btn {
    background-color: #dc3545;
    padding: 6px 12px;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

#header .logout-btn:hover {
    background-color: #c82333;
}


#patient-container {
    max-width: 100%;
    margin: 20px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0px 0px 12px rgba(0,0,0,0.1);
}

/* Search box and button */
#patient-container input[type="text"] {
    padding: 8px;
    width: 300px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-right: 10px;
}

#patient-container input[type="submit"], #patient-container .aspNetButton {
    padding: 8px 16px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

#patient-container input[type="submit"]:hover, #patient-container .aspNetButton:hover {
    background-color: #0056b3;
}

/* GridView styles */
#gvPatients {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
    font-family: Arial, sans-serif;
}

#gvPatients th, #gvPatients td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: left;
}

#gvPatients th {
    background-color: #007bff;
    color: white;
}

#gvPatients tr:nth-child(even) {
    background-color: #f2f2f2;
}

#gvPatients .aspNetButton {
    background-color: #28a745;
    padding: 5px 10px;
    border-radius: 4px;
}

#gvPatients .aspNetButton:hover {
    background-color: #218838;
}
</style>

<div id="header">
    <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-btn" />
</div>

<div id="patient-container">
    <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by Code, Name, Phone"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />

    <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False" DataKeyNames="PatientID"
        OnRowCommand="gvPatients_RowCommand" OnSelectedIndexChanged="gvPatients_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="PatientCode" HeaderText="Code" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
             <asp:BoundField DataField="Gender" HeaderText="Gender" />
             <asp:BoundField DataField="Age" HeaderText="Age" />
             <asp:BoundField DataField="BloodGroup" HeaderText="BloodGroup" />
            <asp:BoundField DataField="ContactNumber" HeaderText="Contact" />
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button runat="server" Text="View" CommandName="ViewPatient" CommandArgument='<%# Eval("PatientID") %>' CssClass="aspNetButton" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
