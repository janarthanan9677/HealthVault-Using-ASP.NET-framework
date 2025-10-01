using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class AdminAddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            string connStr = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=HospitalDB;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Users (Username, PasswordHash, Role, FullName, Email,Phone) VALUES (@Username, @Password, @Role, @FullName, @Email, @Phone)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text); // Plain password since you requested no hashing
                cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
                cmd.Parameters.AddWithValue("@FullName", txtName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMessage.Text = "User added successfully!";
                txtName.Text = txtEmail.Text = txtUsername.Text = txtPassword.Text = "";
                ddlRole.SelectedIndex = 0;
            }
        }
    }
}