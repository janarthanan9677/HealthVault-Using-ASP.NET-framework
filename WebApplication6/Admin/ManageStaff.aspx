<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ManageStaff.aspx.cs" Inherits="WebApplication6.Admin.ManageStaff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <style>
    .gridview {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        font-family: Arial, sans-serif;
        font-size: 14px;

    }

    .gridview th {
        background-color: #007acc;
        color: white;
        padding: 10px;
        text-align: left;
        border: 1px solid #ccc;
    white-space: nowrap;
    }

    .gridview td {
        padding: 8px 10px;
        border: 1px solid #ccc;
         white-space: nowrap;
    }

    .gridview tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .gridview tr:hover {
        background-color: #e6f3ff;
    }

    .gridview .aspNetDisabled {
        color: #888;
    }
    .grid-container {
    width: 100%;
    overflow-x: auto;  /* Horizontal scroll */
    border: 1px solid #ccc;
    padding: 10px;
    box-sizing: border-box;
}
    .gridview a {
        color: #007acc;
        text-decoration: none;
        font-weight: bold;
    }

    .gridview a:hover {
        color: #005999;
        text-decoration: underline;
    }

    .btn {
        background-color: #007acc;
       padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 13px;
        margin: 2px 0;
        text-decoration: none;
        display: inline-block;
         color: white !important;
    }

    .btn:hover {
        background-color: #005999;
        
    }
    .gridview .btn {
        padding: 4px 10px;
        font-size: 12px;
    }
    .gridview .btn + .btn {
        margin-left: 5px;
    }
    h2 {
        font-family: Arial, sans-serif;
        color: #333;
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


    <h2>Manage Staff</h2>
  <asp:Button ID="btnAddStaff" runat="server" Text="Add New Staff" OnClick="btnAddStaff_Click" CssClass="btn" />
 <div style="text-align:right; margin-left:15px;">
<asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" 
    CssClass="btnBack" OnClick="btnBack_Click"  />
                </div>
<div class="grid-container">
        <asp:GridView ID="gvStaffs" runat="server" AutoGenerateColumns="False"
        DataKeyNames="StaffID,UserID"
        OnRowEditing="gvStaffs_RowEditing"
        OnRowCancelingEdit="gvStaffs_RowCancelingEdit"
        OnRowUpdating="gvStaffs_RowUpdating"
        OnRowDeleting="gvStaffs_RowDeleting"
        CssClass="gridview" OnSelectedIndexChanged="gvStaffs_SelectedIndexChanged" >
    <Columns>
      <asp:BoundField DataField="StaffID" HeaderText="ID" ReadOnly="true" />
      

        <asp:TemplateField HeaderText="Full Name">
    <ItemTemplate><%# Eval("FullName") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtFullName" runat="server" Text='<%# Bind("FullName") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Username">
    <ItemTemplate><%# Eval("Username") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtUsername" runat="server" Text='<%# Bind("Username") %>' />
    </EditItemTemplate>
</asp:TemplateField>
         <asp:TemplateField HeaderText="Password">
    <ItemTemplate><%# Eval("PasswordHash") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("PasswordHash") %>' />
    </EditItemTemplate>
</asp:TemplateField>
        <asp:TemplateField HeaderText="Role">
    <ItemTemplate><%# Eval("Role") %></ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlRole" runat="server" SelectedValue='<%# Bind("Role") %>'>
            <asp:ListItem Text="Other Staffs" Value="Otherstaff" />
            <asp:ListItem Text="FrontDesk" Value="FrontDesk" />
            <asp:ListItem Text="Pharmacy" Value="Pharmacy" />
            <asp:ListItem Text="Admin" Value="Admin" />
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>
        <asp:TemplateField HeaderText="Gender">
    <ItemTemplate><%# Eval("Gender") %></ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlGender" runat="server" SelectedValue='<%# Bind("Gender") %>'>
            <asp:ListItem Text="Male" Value="Male" />
            <asp:ListItem Text="Female" Value="Female" />
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="DateOfBirth">
    <ItemTemplate><%# Eval("DateOfBirth", "{0:dd-MMM-yyyy}")  %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtDOB" runat="server" Text='<%# Bind("DateOfBirth", "{0:yyyy-MM-dd}") %>' TextMode="Date" />
    </EditItemTemplate>
</asp:TemplateField>


        <asp:TemplateField HeaderText="Address">
    <ItemTemplate><%# Eval("Address") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Qualification">
    <ItemTemplate><%# Eval("Qualification") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtQual" runat="server" Text='<%# Bind("Qualification") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Salary">
    <ItemTemplate><%# Eval("Salary") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtSalary" runat="server" Text='<%# Bind("Salary") %>' />
    </EditItemTemplate>
</asp:TemplateField>

        <asp:TemplateField HeaderText="Joining Date">
    <ItemTemplate><%# Eval("JoiningDate", "{0:dd-MMM-yyyy}") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtJoiningDate" runat="server" Text='<%# Bind("JoiningDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" />
    </EditItemTemplate>
</asp:TemplateField>

        <asp:TemplateField HeaderText="Phone Number">
    <ItemTemplate><%# Eval("Phone") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Email">
    <ItemTemplate><%# Eval("Email") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Status">
    <ItemTemplate><%# Eval("Status") %></ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("Status") %>'>
            <asp:ListItem Text="Active" Value="Active" />
            <asp:ListItem Text="On Leave" Value="On Leave" />
            <asp:ListItem Text="Retired" Value="Retired" />
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Edit" />
                    &nbsp;|&nbsp;
                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" 
                        Text="Delete" 
                        OnClientClick="return confirm('Are you sure you want to delete this Staff?');" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn" />
                    &nbsp;|&nbsp;
                    <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn" />
                </EditItemTemplate>
            </asp:TemplateField>
    </Columns>
  </asp:GridView>
   </div>
</asp:Content>
