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
    public partial class Addnurse : System.Web.UI.Page
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
            string Gender = ddlGender.SelectedValue;
            string Address = txtAddress.Text.Trim();
            DateTime dob = DateTime.Parse(txtDOB.Text);
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string spec = txtSpec.Text.Trim();
            string qual = txtQual.Text.Trim();
            int exp = Convert.ToInt32(txtExp.Text.Trim());
            decimal sal = Convert.ToDecimal(txtSalary.Text.Trim());
            DateTime joining = DateTime.Parse(txtJoiningDate.Text);
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
                  VALUES (@username, @password, 'Nurse', @fullName, @email, @phone); SELECT SCOPE_IDENTITY();", con, trx))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password);
                        cmd.Parameters.AddWithValue("@fullName", fullName);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@phone", phone);

                        object obj = cmd.ExecuteScalar();
                        newUserId = Convert.ToInt32(obj);
                    }

                    // 2) Insert Nurse profile with extra fields
                    using (SqlCommand cmd2 = new SqlCommand(
                        @"INSERT INTO Nurses 
                    (UserID, Gender, DateOfBirth, Address, Specialization, Qualification, YearsOfExperience, Salary, JoiningDate, Status) 
                  VALUES 
                    (@uid, @Gender, @dob, @Address, @spec, @qual, @exp, @sal, @JoiningDate, @status)", con, trx))
                    {
                        cmd2.Parameters.AddWithValue("@uid", newUserId);
                        cmd2.Parameters.AddWithValue("@Gender", Gender);
                        cmd2.Parameters.AddWithValue("@Address", Address);
                        cmd2.Parameters.AddWithValue("@dob", SqlDbType.Date).Value = dob.Date;
                        cmd2.Parameters.AddWithValue("@spec", spec);
                        cmd2.Parameters.AddWithValue("@qual", qual);
                        cmd2.Parameters.AddWithValue("@exp", exp);
                        cmd2.Parameters.AddWithValue("@sal", sal);
                        cmd2.Parameters.AddWithValue("@JoiningDate", SqlDbType.Date).Value = joining.Date;
                        cmd2.Parameters.AddWithValue("@status", status);
                        cmd2.ExecuteNonQuery();
                    }

                    trx.Commit();
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "Nurse added successfully.";


                    // Clear form
                    txtUsername.Text = txtPassword.Text = txtFullName.Text = txtDOB.Text = txtAddress.Text  = txtEmail.Text = txtPhone.Text = "";
                    txtSpec.Text  = txtQual.Text = txtExp.Text = txtSalary.Text = txtJoiningDate.Text = "";
                    ddlGender.SelectedIndex = ddlStatus.SelectedIndex = 0;
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
            Response.Redirect("~/Admin/ManageNurses.aspx");
        }
    }
    
}
