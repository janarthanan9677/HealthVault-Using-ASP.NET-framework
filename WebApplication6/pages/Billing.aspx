<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Billing.aspx.cs" Inherits="WebApplication6.pages.Billing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .container {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin: 20px auto;
            width: 95%;
        }

        .header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            gap: 10px;
        }

        .header h2 {
            margin: 0;
            color: #2c3e50;
            flex-grow: 1;
        }

        .btn-back {
            background: #7f8c8d;
            color: #fff;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-back:hover {
            background: #636e72;
        }
   
        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }

        .form-row input, .form-row select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            flex: 1;
        }

        .aspNetButton {
            background: #27ae60;
            color: #fff;
            padding: 8px 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .aspNetButton:hover {
            background: #219150;
        }

        .section-header {
            margin: 15px 0 8px 0;
            font-size: 18px;
            color: #2c3e50;
            font-weight: bold;
        }

        .gv-style {
            width: 100%;
            border-collapse: collapse;
        }

        .gv-style th {
            background: #34495e;
            color: white;
            padding: 8px;
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

        .aspNet-GridView button {
            padding: 5px 10px;
            margin: 2px;
            border-radius: 4px;
        }

    </style>
    <div class="container">
            <h2>Billing Management</h2>
                    <asp:Button ID="btnBack" runat="server" Text="← Back" CssClass="btn-back" OnClick="btnBack_Click" />
 
            <br />
            <br />
 
            <!-- Add Bill -->
    <div class="form-row">
        <asp:TextBox ID="txtBillDescNew" runat="server" Placeholder="Description" />
        <asp:TextBox ID="txtBillAmountNew" runat="server" Placeholder="Amount" />
        <asp:DropDownList ID="ddlBillModeNew" runat="server">
            <asp:ListItem Text="Cash" Value="Cash" />
            <asp:ListItem Text="Card" Value="Card" />
            <asp:ListItem Text="UPI" Value="UPI" />
            <asp:ListItem Text="Insurance" Value="Insurance" />
        </asp:DropDownList>
        <asp:TextBox ID="txtInsuranceProviderNew" runat="server" Placeholder="Insurance Provider" />
        <asp:TextBox ID="txtPolicyNumberNew" runat="server" Placeholder="Policy Number" />
        <asp:Button ID="btnAddBill" runat="server" Text="Add Bill" OnClick="btnAddBill_Click" CssClass="aspNetButton" />
    </div>

    <!-- Billing -->
    <div class="section-header">Billing</div>
    <asp:GridView ID="gvBilling" runat="server" CssClass="gv-style" AutoGenerateColumns="False" DataKeyNames="BillID"
        OnRowEditing="gvBilling_RowEditing"
        OnRowCancelingEdit="gvBilling_RowCancelingEdit"
        OnRowUpdating="gvBilling_RowUpdating"
        OnRowDeleting="gvBilling_RowDeleting">
        <Columns>
            <asp:BoundField DataField="BillDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="True" />
            <asp:TemplateField HeaderText="Description">
                <ItemTemplate><%# Eval("Description") %></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtBillDesc" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount">
                <ItemTemplate><%# Eval("Amount") %></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtBillAmount" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Mode">
                <ItemTemplate><%# Eval("PaymentMode") %></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtBillMode" runat="server" Text='<%# Bind("PaymentMode") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate><%# Eval("PaymentStatus") %></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtBillStatus" runat="server" Text='<%# Bind("PaymentStatus") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="InsuranceProvider" HeaderText="Insurance" />
            <asp:BoundField DataField="PolicyNumber" HeaderText="Policy No" />
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
