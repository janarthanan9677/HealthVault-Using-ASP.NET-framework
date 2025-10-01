<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StockManagement.aspx.cs" Inherits="WebApplication6.pages.StockManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <style>
          /* ===== Container ===== */
.container {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    margin: 20px auto;
    width: 95%;
}

/* ===== Headings ===== */
.container h2 {
    color: #2c3e50;
    margin-bottom: 20px;
}

/* ===== Form Rows ===== */
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

/* ===== Buttons ===== */
.aspNetButton, .btn-back {
    background: #27ae60;
    color: #fff;
    padding: 8px 14px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.aspNetButton:hover {
    background: #219150;
}

.btn-back {
    background: #7f8c8d;
}

.btn-back:hover {
    background: #636e72;
}

/* ===== Section Headers ===== */
.section-header {
    margin: 15px 0 8px 0;
    font-size: 18px;
    color: #2c3e50;
    font-weight: bold;
}

/* ===== GridView Styling ===== */
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

/* ===== GridView Buttons ===== */
.gv-style button, .gv-style .aspNetButton {
    padding: 5px 10px;
    margin: 2px;
    border-radius: 4px;
}

/* ===== Alerts / Messages ===== */
.alert {
    padding: 10px;
    background-color: #2ecc71;
    color: white;
    margin-bottom: 15px;
    border-radius: 4px;
}

/* ===== Input Placeholder Styling ===== */
input::placeholder {
    color: #95a5a6;
    font-style: italic;
}

/* ===== Responsive ===== */
@media screen and (max-width: 768px) {
    .form-row {
        flex-direction: column;
    }

    .form-row input, .form-row select {
        flex: 100%;
    }
}
.btn-back {
    background: #7f8c8d;
    color: #fff;
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-bottom: 15px;
}

.btn-back:hover {
    background: #636e72;
}

      </style>
    <div class="container">
    <h2>Stock Management</h2>
        <asp:Button ID="btnBack" runat="server" Text="← Back" CssClass="btn-back" OnClick="btnBack_Click" />

    <div class="form-row">
        <asp:TextBox ID="txtMedicineName" runat="server" Placeholder="Medicine Name" />
        <asp:TextBox ID="txtManufacturer" runat="server" Placeholder="Manufacturer" />
        <asp:TextBox ID="txtBatchNumber" runat="server" Placeholder="Batch Number" />
        <asp:TextBox ID="txtQuantity" runat="server" Placeholder="Quantity" />
        <asp:TextBox ID="txtExpiryDate" runat="server" Placeholder="Expiry Date (yyyy-MM-dd)" />
        <asp:TextBox ID="txtCostPrice" runat="server" Placeholder="Cost Price" />
        <asp:TextBox ID="txtSellingPrice" runat="server" Placeholder="Selling Price" />
        <asp:Button ID="btnAddMedicine" runat="server" Text="Add Medicine" CssClass="aspNetButton" OnClick="btnAddMedicine_Click" />
    </div>

    <asp:GridView ID="gvMedicines" runat="server" AutoGenerateColumns="False" CssClass="gv-style"
        DataKeyNames="MedicineID"
        OnRowEditing="gvMedicines_RowEditing"
        OnRowUpdating="gvMedicines_RowUpdating"
        OnRowDeleting="gvMedicines_RowDeleting">
        <Columns>
            <asp:BoundField DataField="MedicineName" HeaderText="Medicine Name" />
            <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" />
            <asp:BoundField DataField="BatchNumber" HeaderText="Batch No" />
            <asp:BoundField DataField="QuantityAvailable" HeaderText="Stock Qty" />
            <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="CostPrice" HeaderText="Cost Price" DataFormatString="{0:C}" />
            <asp:BoundField DataField="SellingPrice" HeaderText="Selling Price" DataFormatString="{0:C}" />
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
