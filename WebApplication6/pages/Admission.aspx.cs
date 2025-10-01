using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class Admission : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPatients();
            }
        }

        private void LoadPatients(string search = "")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT PatientID, FirstName, LastName, Gender, DateOfBirth, ContactNumber 
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

        protected void gvPatients_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewPatient")
            {
                string patientId = e.CommandArgument.ToString();
                Response.Redirect("~/pages/Billing.aspx?PatientID=" + patientId);
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadPatients(txtSearch.Text.Trim());
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadPatients(txtSearch.Text.Trim());
        }
        protected void btnNewRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/PatientRegistration.aspx"); // Page to register a new patient
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}