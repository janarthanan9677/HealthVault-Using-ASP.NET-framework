<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Admission.aspx.cs" Inherits="WebApplication6.Admission" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .container {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .header {
            background: #2c3e50;
            color: #fff;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
            font-size: 20px;
        }

        .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background: #c0392b;
        }

        .container {
            width: 95%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .gv-style {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .gv-style th {
            background: #34495e;
            color: white;
            padding: 10px;
            text-align: left;
        }

        .gv-style td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        .gv-style tr:nth-child(even) {
            background: #f9f9f9;
        }

        .gv-style tr:hover {
            background: #ecf0f1;
        }

        .view-btn {
            background: #3498db;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .view-btn:hover {
            background: #2980b9;
        }
        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            justify-content: flex-start; /* Align everything to left */
        }

        .search-input {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 250px;
        }

        .search-btn {
            background: #2980b9;
            color: white;
            padding: 8px 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .search-btn:hover {
            background: #2471a3;
        }

        .new-btn {
            background: #27ae60;
            color: white;
            padding: 8px 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .new-btn:hover {
            background: #219150;
        }


    </style>

        <!-- Header -->
        <div class="header">
            <h2>Admission - Patient Records</h2>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
        </div>

        <!-- Container -->
        <div class="container">
                       <div class="search-bar">
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by Name or Contact..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
            <asp:Button ID="btnNewRegister" runat="server" Text="New Register" CssClass="new-btn" OnClick="btnNewRegister_Click" />
        </div>
            <div class="title">Registered Patients</div>

            <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False" CssClass="gv-style"
                DataKeyNames="PatientID" OnRowCommand="gvPatients_RowCommand">
                <Columns>
                    <asp:BoundField DataField="PatientID" HeaderText="ID" />
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:BoundField DataField="DateOfBirth" HeaderText="DOB" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" Text="View" CommandName="ViewPatient"
                                CommandArgument='<%# Eval("PatientID") %>' CssClass="view-btn" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
  </asp:Content>
