using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtUsername_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "SELECT UserID, Role FROM Users WHERE Username=@Username AND PasswordHash=@Password";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password); // plain password check

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    // Save session
                    Session["UserID"] = dr["UserID"].ToString();
                    Session["Role"] = dr["Role"].ToString();

                    // Redirect by role
                    string role = dr["Role"].ToString();
                    switch (role)
                    {
                        case "Admin":
                            Response.Redirect("~/pages/AdminDashboard.aspx");
                            break;
                        case "Doctor":
                            Response.Redirect("~/pages/PatientList.aspx");
                            break;
                        case "Nurse":
                            Response.Redirect("~/pages/PatientList.aspx");
                            break;
                        case "FrontDesk":
                            Response.Redirect("~/pages/Admission.aspx");
                            break;
                        case "Pharmacy":
                            Response.Redirect("~/pages/PharmacyDashboard.aspx");
                            break;
                        default:
                            lblMessage.Text = "Role not assigned!";
                            break;
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password!";
                }
            }
        }
    }
    }
