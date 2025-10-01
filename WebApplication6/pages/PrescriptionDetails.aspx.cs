using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6.pages
{
    public partial class PrescriptionDetails : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;
        int patientId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["PatientID"] != null)
                {
                    patientId = Convert.ToInt32(Request.QueryString["PatientID"]);
                    BindPrescriptionsGrid();
                }
            }
        }

        private void BindPrescriptionsGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Prescriptions WHERE PatientID=@patientId", con);
                da.SelectCommand.Parameters.AddWithValue("@patientId", patientId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvPrescriptions.DataSource = dt;
                gvPrescriptions.DataBind();
            }
        }

        protected void gvPrescriptions_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "IssueMedicine")
            {
                int prescId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    // Get prescription details
                    SqlCommand cmd = new SqlCommand("SELECT MedicineID, Quantity FROM Prescriptions WHERE PrescriptionID=@id", con);
                    cmd.Parameters.AddWithValue("@id", prescId);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        int medId = Convert.ToInt32(dr["MedicineID"]);
                        int qty = Convert.ToInt32(dr["Quantity"]);
                        dr.Close();

                        // Reduce stock
                        SqlCommand cmdStock = new SqlCommand("UPDATE Medicines SET QuantityAvailable = QuantityAvailable - @qty WHERE MedicineID=@medId", con);
                        cmdStock.Parameters.AddWithValue("@qty", qty);
                        cmdStock.Parameters.AddWithValue("@medId", medId);
                        cmdStock.ExecuteNonQuery();

                        // Update prescription status
                        SqlCommand cmdUpdate = new SqlCommand("UPDATE Prescriptions SET Status='Issued' WHERE PrescriptionID=@id", con);
                        cmdUpdate.Parameters.AddWithValue("@id", prescId);
                        cmdUpdate.ExecuteNonQuery();

                        // Get selling price & insert into PharmacyBilling
                        SqlCommand cmdPrice = new SqlCommand("SELECT SellingPrice FROM Medicines WHERE MedicineID=@medId", con);
                        cmdPrice.Parameters.AddWithValue("@medId", medId);
                        decimal totalAmount = qty * Convert.ToDecimal(cmdPrice.ExecuteScalar());

                        SqlCommand cmdBill = new SqlCommand(@"INSERT INTO PharmacyBilling (PrescriptionID, PatientID, MedicineID, Quantity, TotalAmount)
                                                             VALUES (@presc, @patient, @med, @qty, @total)", con);
                        cmdBill.Parameters.AddWithValue("@presc", prescId);
                        cmdBill.Parameters.AddWithValue("@patient", patientId);
                        cmdBill.Parameters.AddWithValue("@med", medId);
                        cmdBill.Parameters.AddWithValue("@qty", qty);
                        cmdBill.Parameters.AddWithValue("@total", totalAmount);
                        cmdBill.ExecuteNonQuery();
                    }
                }
                BindPrescriptionsGrid();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/PharmacyDashboard.aspx"); // or previous page
        }
    }
}