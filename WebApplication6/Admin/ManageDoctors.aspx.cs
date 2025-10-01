using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6.Admin
{
    public partial class ManageDoctors : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();

        }
        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                @"SELECT d.DoctorID, d.UserID, u.Username, u.PasswordHash,u.Role, u.FullName, d.Specialization, d.Department, d.Qualification,
d.ExperienceYears, d.ConsultationFee, d.LicenseNumber, u.Phone, u.Email, d.Status FROM Doctors d INNER JOIN Users u ON d.UserID = u.UserID", con))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDoctors.DataSource = dt;
                    gvDoctors.DataBind();
                }
            }
        }
        protected void btnAddDoctor_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/AddDoctor.aspx");
        }
        protected void gvDoctors_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDoctors.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvDoctors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDoctors.EditIndex = -1;
            BindGrid();
        }
        protected void gvDoctors_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvDoctors.Rows[e.RowIndex];
            int doctorId = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex]["DoctorID"]);
            int userId = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex]["UserID"]);

            // Get values from GridView controls
            string fullName = ((TextBox)row.FindControl("txtFullName")).Text.Trim();
            string username = ((TextBox)row.FindControl("txtUsername")).Text.Trim();
            string password = ((TextBox)row.FindControl("txtPassword")).Text.Trim();
            string role = ((DropDownList)row.FindControl("ddlRole")).SelectedValue;
            string spec = ((TextBox)row.FindControl("txtSpec")).Text.Trim();
            string dept = ((TextBox)row.FindControl("txtDept")).Text.Trim();
            string qual = ((TextBox)row.FindControl("txtQual")).Text.Trim();
            int exp = Convert.ToInt32(((TextBox)row.FindControl("txtExp")).Text.Trim());
            decimal fee = Convert.ToDecimal(((TextBox)row.FindControl("txtFee")).Text.Trim());
            string license = ((TextBox)row.FindControl("txtLicense")).Text.Trim();
            string phone = ((TextBox)row.FindControl("txtPhone")).Text.Trim();
            string email = ((TextBox)row.FindControl("txtEmail")).Text.Trim();
            string status = ((DropDownList)row.FindControl("ddlStatus")).SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction trx = con.BeginTransaction();
                try
                {
                    
                    using (SqlCommand cmd = new SqlCommand("UPDATE Users SET FullName=@FullName,username=@Username, PasswordHash=@PasswordHash, Role=@Role, Phone=@Phone, Email=@Email WHERE UserID=@UserID", con, trx))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", password);
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.ExecuteNonQuery();
                    }

                    // Update Doctors table
                    using (SqlCommand cmd2 = new SqlCommand(
                        @"UPDATE Doctors 
                  SET Specialization=@Spec, Department=@Dept, Qualification=@Qual, 
                      ExperienceYears=@Exp, ConsultationFee=@Fee, LicenseNumber=@License, Status=@Status
                  WHERE DoctorID=@DoctorID", con, trx))
                    {
                        cmd2.Parameters.AddWithValue("@Spec", spec);
                        cmd2.Parameters.AddWithValue("@Dept", dept);
                        cmd2.Parameters.AddWithValue("@Qual", qual);
                        cmd2.Parameters.AddWithValue("@Exp", exp);
                        cmd2.Parameters.AddWithValue("@Fee", fee);
                        cmd2.Parameters.AddWithValue("@License", license);
                        cmd2.Parameters.AddWithValue("@Status", status);
                        cmd2.Parameters.AddWithValue("@DoctorID", doctorId);
                        cmd2.ExecuteNonQuery();
                    }

                    trx.Commit();
                }
                catch
                {
                    trx.Rollback();
                    throw;
                }
            }

            gvDoctors.EditIndex = -1;
            BindGrid();
        }

        protected void gvDoctors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int doctorId = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex]["DoctorID"]);
            int userId = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex]["UserID"]);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction trx = con.BeginTransaction();
                try
                {
                    // Delete Doctors record
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM Doctors WHERE DoctorID=@DoctorID", con, trx))
                    {
                        cmd.Parameters.AddWithValue("@DoctorID", doctorId);
                        cmd.ExecuteNonQuery();
                    }

                    // Delete Users record (optional: or set Role=NULL/disable)
                    using (SqlCommand cmd2 = new SqlCommand("DELETE FROM Users WHERE UserID=@UserID", con, trx))
                    {
                        cmd2.Parameters.AddWithValue("@UserID", userId);
                        cmd2.ExecuteNonQuery();
                    }

                    trx.Commit();
                }
                catch
                {
                    trx.Rollback();
                    throw;
                }
            }

            BindGrid();
        }

        protected void gvDoctors_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/AdminDashboard.aspx");
        }
    }
}
