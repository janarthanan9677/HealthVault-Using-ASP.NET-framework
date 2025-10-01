using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace WebApplication6.pages
{
    public partial class StockManagement : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindMedicinesGrid();
        }

        private void BindMedicinesGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Medicines", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMedicines.DataSource = dt;
                gvMedicines.DataBind();
            }
        }

        // Add new medicine
        protected void btnAddMedicine_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Medicines (MedicineName, Manufacturer, BatchNumber, QuantityAvailable, ExpiryDate, CostPrice, SellingPrice)
                                 VALUES (@Name, @Manufacturer, @Batch, @Qty, @Expiry, @Cost, @Selling)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", txtMedicineName.Text);
                cmd.Parameters.AddWithValue("@Manufacturer", txtManufacturer.Text);
                cmd.Parameters.AddWithValue("@Batch", txtBatchNumber.Text);
                cmd.Parameters.AddWithValue("@Qty", Convert.ToInt32(txtQuantity.Text));
                cmd.Parameters.AddWithValue("@Expiry", Convert.ToDateTime(txtExpiryDate.Text));
                cmd.Parameters.AddWithValue("@Cost", Convert.ToDecimal(txtCostPrice.Text));
                cmd.Parameters.AddWithValue("@Selling", Convert.ToDecimal(txtSellingPrice.Text));
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindMedicinesGrid();
        }

        // Back button
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/PharmacyDashboard.aspx");
        }

        // Edit row
        protected void gvMedicines_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMedicines.EditIndex = e.NewEditIndex;
            BindMedicinesGrid();
        }

        // Cancel editing
        protected void gvMedicines_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMedicines.EditIndex = -1;
            BindMedicinesGrid();
        }

        // Update row
        protected void gvMedicines_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int medicineId = Convert.ToInt32(gvMedicines.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvMedicines.Rows[e.RowIndex];

            string name = ((TextBox)row.FindControl("txtMedicineName")).Text;
            string manufacturer = ((TextBox)row.FindControl("txtManufacturer")).Text;
            string batch = ((TextBox)row.FindControl("txtBatchNumber")).Text;
            int qty = Convert.ToInt32(((TextBox)row.FindControl("txtQuantityAvailable")).Text);
            DateTime expiry = Convert.ToDateTime(((TextBox)row.FindControl("txtExpiryDate")).Text);
            decimal cost = Convert.ToDecimal(((TextBox)row.FindControl("txtCostPrice")).Text);
            decimal selling = Convert.ToDecimal(((TextBox)row.FindControl("txtSellingPrice")).Text);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"UPDATE Medicines SET 
                                    MedicineName=@Name, 
                                    Manufacturer=@Manufacturer, 
                                    BatchNumber=@Batch, 
                                    QuantityAvailable=@Qty,
                                    ExpiryDate=@Expiry,
                                    CostPrice=@Cost,
                                    SellingPrice=@Selling,
                                    UpdatedDate=GETDATE()
                                 WHERE MedicineID=@ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Manufacturer", manufacturer);
                cmd.Parameters.AddWithValue("@Batch", batch);
                cmd.Parameters.AddWithValue("@Qty", qty);
                cmd.Parameters.AddWithValue("@Expiry", expiry);
                cmd.Parameters.AddWithValue("@Cost", cost);
                cmd.Parameters.AddWithValue("@Selling", selling);
                cmd.Parameters.AddWithValue("@ID", medicineId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvMedicines.EditIndex = -1;
            BindMedicinesGrid();
        }

        // Delete row
        protected void gvMedicines_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int medicineId = Convert.ToInt32(gvMedicines.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Medicines WHERE MedicineID=@ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", medicineId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindMedicinesGrid();
        }
    }
}
