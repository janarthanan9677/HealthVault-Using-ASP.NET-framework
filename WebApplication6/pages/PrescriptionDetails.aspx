<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PrescriptionDetails.aspx.cs" Inherits="WebApplication6.pages.PrescriptionDetails" %>
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
    <h2>Prescription Details</h2>
        <asp:Button ID="btnBack" runat="server" Text="← Back" CssClass="btn-back" OnClick="btnBack_Click" />
    <asp:GridView ID="gvPrescriptions" runat="server" AutoGenerateColumns="False" CssClass="gv-style"
        DataKeyNames="PrescriptionID" OnRowCommand="gvPrescriptions_RowCommand">
        <Columns>
            <asp:BoundField DataField="MedicineName" HeaderText="Medicine" />
            <asp:BoundField DataField="Dosage" HeaderText="Dosage" />
            <asp:BoundField DataField="Quantity" HeaderText="Qty" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" />
            <asp:BoundField DataField="Comments" HeaderText="Comments" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnIssue" runat="server" Text="Issue" CommandName="IssueMedicine" CommandArgument='<%# Eval("PrescriptionID") %>' 
                                Enabled='<%# Eval("Status").ToString() == "Pending" %>' CssClass="aspNetButton" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
