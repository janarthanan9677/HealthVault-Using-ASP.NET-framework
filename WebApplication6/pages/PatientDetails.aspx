<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PatientDetails.aspx.cs" Inherits="WebApplication6.pages.PatientDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    #patient-details-container {
        max-width: 100%;
        margin: 20px auto;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        font-family: Arial, sans-serif;
    }
    .section-header {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
        color: #007bff;
        border-bottom: 2px solid #007bff;
        padding-bottom: 5px;
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
    #basic-info { display: flex; gap: 20px; flex-wrap: wrap; margin-bottom: 20px; }
    .info-item { flex: 1 1 250px; }
    .info-item label { font-weight: bold; }
    .gv-style { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
    .gv-style th, .gv-style td { padding: 10px; border: 1px solid #ddd; }
    .gv-style th { background-color: #007bff; color: white; }
    .gv-style tr:nth-child(even) { background-color: #f2f2f2; }
    .form-row { display: flex; gap: 15px; flex-wrap: wrap; margin-bottom: 15px; align-items: center; }
    .form-row input[type="text"], .form-row select { padding: 6px; border: 1px solid #ccc; border-radius: 4px; }
    .form-row button, .form-row .aspNetButton { padding: 6px 12px; border: none; border-radius: 4px; background-color: #28a745; color: white; cursor: pointer; }
    .form-row button:hover, .form-row .aspNetButton:hover { background-color: #218838; }
</style>

<div id="patient-details-container">
    <asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" 
        CssClass="btnBack" OnClick="btnBack_Click"  />

    <br />

    <!-- Basic Info -->
    <div class="section-header">Patient Basic Info</div>
    <div id="basic-info">
        <div class="info-item"><label>Patient Code:</label> <asp:Label ID="lblPatientCode" runat="server" /></div>
        <div class="info-item"><label>Name:</label> <asp:Label ID="lblPatientName" runat="server" /></div>
        <div class="info-item"><label>Gender:</label> <asp:Label ID="lblGender" runat="server" /></div>
        <div class="info-item"><label>Date of Birth:</label> <asp:Label ID="lblDateOfBirth" runat="server" /></div>
        <div class="info-item"><label>Blood Group:</label> <asp:Label ID="lblBloodGroup" runat="server" /></div>
        <div class="info-item"><label>Marital Status:</label> <asp:Label ID="lblMaritalStatus" runat="server" /></div>
        <div class="info-item"><label>Contact:</label> <asp:Label ID="lblContactNumber" runat="server" /></div>
        <div class="info-item"><label>Alternate Contact:</label> <asp:Label ID="lblAlternateNumber" runat="server" /></div>
        <div class="info-item"><label>Email:</label> <asp:Label ID="lblEmail" runat="server" /></div>
        <div class="info-item"><label>Address:</label> <asp:Label ID="lblAddress" runat="server" /></div>
        <div class="info-item"><label>City:</label> <asp:Label ID="lblCity" runat="server" /></div>
        <div class="info-item"><label>State:</label> <asp:Label ID="lblState" runat="server" /></div>
        <div class="info-item"><label>Pincode:</label> <asp:Label ID="lblPincode" runat="server" /></div>
        <div class="info-item"><label>Emergency Contact Name:</label> <asp:Label ID="lblEmergencyContactName" runat="server" /></div>
        <div class="info-item"><label>Emergency Contact Number:</label> <asp:Label ID="lblEmergencyContactNumber" runat="server" /></div>
        <div class="info-item"><label>Medical History:</label> <asp:Label ID="lblMedicalHistory" runat="server" /></div>
        <div class="info-item"><label>Allergies:</label> <asp:Label ID="lblAllergies" runat="server" /></div>
    </div>

    <!-- Vitals History -->
    <div class="section-header">Vitals History</div>
    <asp:GridView ID="gvVitals" runat="server" CssClass="gv-style" AutoGenerateColumns="False" DataKeyNames="VitalID"
        OnRowEditing="gvVitals_RowEditing"
        OnRowCancelingEdit="gvVitals_RowCancelingEdit"
        OnRowUpdating="gvVitals_RowUpdating"
        OnRowDeleting="gvVitals_RowDeleting">
        <Columns>
            <asp:TemplateField HeaderText="Vital Type">
                <ItemTemplate><%# Eval("VitalType") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtVitalType" runat="server" Text='<%# Bind("VitalType") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Value">
                <ItemTemplate><%# Eval("VitalValue") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtVitalValue" runat="server" Text='<%# Bind("VitalValue") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Unit">
                <ItemTemplate><%# Eval("Unit") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtUnit" runat="server" Text='<%# Bind("Unit") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comments">
                <ItemTemplate><%# Eval("Comments") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtComments" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="AddedByName" HeaderText="Added By" ReadOnly="True" />
            <asp:BoundField DataField="AddedOn" HeaderText="Added On" DataFormatString="{0:dd/MM/yyyy HH:mm}" ReadOnly="True" />
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>

    <!-- Add Vital -->
    <div class="form-row">
        <asp:DropDownList ID="ddlVitalType" runat="server">
            <asp:ListItem Text="BP" Value="BP" />
            <asp:ListItem Text="Heart Rate" Value="Heart Rate" />
            <asp:ListItem Text="Temperature" Value="Temperature" />
            <asp:ListItem Text="Respiration" Value="Respiration" />
        </asp:DropDownList>
        <asp:TextBox ID="txtVitalValueNew" runat="server" Placeholder="Value" />
        <asp:TextBox ID="txtUnitNew" runat="server" Placeholder="Unit" />
        <asp:TextBox ID="txtCommentsNew" runat="server" Placeholder="Comments" />
        <asp:Button ID="btnAddVital" runat="server" Text="Add Vital" OnClick="btnAddVital_Click" CssClass="aspNetButton" />
    </div>

    <!-- Prescriptions -->
    <div class="section-header">Prescriptions</div>
    <asp:GridView ID="gvPrescriptions" runat="server" CssClass="gv-style" AutoGenerateColumns="False" DataKeyNames="PrescriptionID"
        OnRowEditing="gvPrescriptions_RowEditing"
        OnRowCancelingEdit="gvPrescriptions_RowCancelingEdit"
        OnRowUpdating="gvPrescriptions_RowUpdating"
        OnRowDeleting="gvPrescriptions_RowDeleting">
        <Columns>
            <asp:TemplateField HeaderText="Medicine">
                <ItemTemplate><%# Eval("MedicineName") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtMedicine" runat="server" Text='<%# Bind("MedicineName") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Dosage">
                <ItemTemplate><%# Eval("Dosage") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtDosage" runat="server" Text='<%# Bind("Dosage") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Qty">
                <ItemTemplate><%# Eval("Quantity") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Duration">
                <ItemTemplate><%# Eval("Duration") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtDuration" runat="server" Text='<%# Bind("Duration") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comments">
                <ItemTemplate><%# Eval("Comments") %></ItemTemplate>
                <EditItemTemplate><asp:TextBox ID="txtPrescComments" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox></EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PrescribedByName" HeaderText="Prescribed By" ReadOnly="True" />
            <asp:BoundField DataField="PrescribedOn" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="True" />
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>

    <!-- Add Prescription -->
    <div class="form-row">
        <asp:TextBox ID="txtMedicineNew" runat="server" Placeholder="Medicine" />
        <asp:TextBox ID="txtDosageNew" runat="server" Placeholder="Dosage" />
        <asp:TextBox ID="txtQuantityNew" runat="server" Placeholder="Quantity" />
        <asp:TextBox ID="txtDurationNew" runat="server" Placeholder="Duration" />
        <asp:TextBox ID="txtPrescriptionCommentsNew" runat="server" Placeholder="Comments" />
        <asp:Button ID="btnAddPrescription" runat="server" Text="Add Prescription" OnClick="btnAddPrescription_Click" CssClass="aspNetButton" />
    </div>
</div>

</asp:Content>
