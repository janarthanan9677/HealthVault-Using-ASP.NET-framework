using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication6.pages
{
    public partial class PharmacyDashboard : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindPatientsGrid();
        }

        private void BindPatientsGrid(string search = "")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT PatientID, PatientCode, FirstName, LastName, Gender, DateOfBirth, ContactNumber 
                                 FROM Patients ";

                if (!string.IsNullOrEmpty(search))
                {
                    query += "WHERE FirstName LIKE @search OR LastName LIKE @search OR ContactNumber LIKE @search ";
                }

                query += "ORDER BY PatientID DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(search))
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPatients.DataSource = dt;
                gvPatients.DataBind();
            }
        }

        protected void gvPatients_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int patientId = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "ViewPrescription")
                Response.Redirect($"PrescriptionDetails.aspx?PatientID={patientId}");
            else if (e.CommandName == "ViewBilling")
                Response.Redirect($"PharmacyBilling.aspx?PatientID={patientId}");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindPatientsGrid(txtSearch.Text.Trim());
        }

        protected void btnStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/StockManagement.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/pages/Login.aspx");
        }
    }
}
