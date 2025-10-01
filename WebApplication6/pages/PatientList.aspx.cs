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
    public partial class PatientList : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadPatients();
        }

        void LoadPatients(string search = "")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT PatientID, PatientCode, FirstName, LastName, Gender, ContactNumber, BloodGroup ,Age FROM Patients";
                if (!string.IsNullOrEmpty(search))
                    sql += " WHERE PatientCode LIKE @s OR FirstName LIKE @s OR LastName LIKE @s OR ContactNumber LIKE @s";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (!string.IsNullOrEmpty(search))
                        cmd.Parameters.AddWithValue("@s", "%" + search + "%");

                    con.Open();
                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());
                    gvPatients.DataSource = dt;
                    gvPatients.DataBind();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadPatients(txtSearch.Text.Trim());
        }

        protected void gvPatients_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewPatient")
            {
                int patientId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"PatientDetails.aspx?PatientID={patientId}");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/Login.aspx");
        }

        protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}