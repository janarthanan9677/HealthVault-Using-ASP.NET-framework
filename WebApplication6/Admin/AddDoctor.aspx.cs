using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6.Admin
{
    public partial class AddDoctor : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string spec = txtSpec.Text.Trim();
            string dept = txtDept.Text.Trim();
            string qual = txtQual.Text.Trim();
            int exp = Convert.ToInt32(txtExp.Text.Trim());
            decimal fee = Convert.ToDecimal(txtFee.Text.Trim());
            string license = txtLicense.Text.Trim();
            string status = ddlStatus.SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Check username exists
                using (SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username=@u", con))
                {
                    check.Parameters.AddWithValue("@u", username);
                    int exists = (int)check.ExecuteScalar();
                    if (exists > 0)
                    {
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        lblMsg.Text = "Username already exists.";
                        return;
                    }
                }

                SqlTransaction trx = con.BeginTransaction();
                try
                {
                    // 1) Insert into Users and get new UserID
                    int newUserId;
                    using (SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Users (Username, PasswordHash, Role, FullName, Email, Phone) 
                  VALUES (@username, @password, 'Doctor', @fullName, @email, @phone); SELECT SCOPE_IDENTITY();", con, trx))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password);
                        cmd.Parameters.AddWithValue("@fullName", fullName);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@phone", phone);

                        object obj = cmd.ExecuteScalar();
                        newUserId = Convert.ToInt32(obj);
                    }

                    // 2) Insert doctor profile with extra fields
                    using (SqlCommand cmd2 = new SqlCommand(
                        @"INSERT INTO Doctors 
                    (UserID, Specialization, Department, Qualification, ExperienceYears, ConsultationFee, LicenseNumber, Status) 
                  VALUES 
                    (@uid, @spec, @dept, @qual, @exp, @fee, @license, @status)", con, trx))
                    {
                        cmd2.Parameters.AddWithValue("@uid", newUserId);
                        cmd2.Parameters.AddWithValue("@spec", spec);
                        cmd2.Parameters.AddWithValue("@dept", dept);
                        cmd2.Parameters.AddWithValue("@qual", qual);
                        cmd2.Parameters.AddWithValue("@exp", exp);
                        cmd2.Parameters.AddWithValue("@fee", fee);
                        cmd2.Parameters.AddWithValue("@license", license);
                        cmd2.Parameters.AddWithValue("@status", status);
                        cmd2.ExecuteNonQuery();
                    }

                    trx.Commit();
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "Doctor added successfully.";
                    

                    // Clear form
                    txtUsername.Text = txtPassword.Text = txtFullName.Text = txtEmail.Text = txtPhone.Text = "";
                    txtSpec.Text = txtDept.Text = txtQual.Text = txtExp.Text = txtFee.Text = txtLicense.Text = "";
                    ddlStatus.SelectedIndex = 0;
                }
                catch (Exception ex)
                {
                    trx.Rollback();
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void txtAvail_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ManageDoctors.aspx");
        }
    }
}