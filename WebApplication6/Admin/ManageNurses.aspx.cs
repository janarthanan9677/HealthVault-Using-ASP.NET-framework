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
    public partial class ManageNurses : System.Web.UI.Page
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
                @"SELECT d.NurseID, d.UserID, u.Username, u.PasswordHash,u.Role, u.FullName, d.Gender, d.DateOfBirth, d.Address, d.Specialization, d.Qualification,
d.YearsOfExperience, d.Salary, d.JoiningDate, u.Phone, u.Email, d.Status FROM Nurses d INNER JOIN Users u ON d.UserID = u.UserID", con))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvNurses.DataSource = dt;
                    gvNurses.DataBind();
                }
            }
        }
        protected void btnAddNurse_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/AddNurse.aspx");
        }
        protected void gvNurses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvNurses.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvNurses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvNurses.EditIndex = -1;
            BindGrid();
        }
        protected void gvNurses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvNurses.Rows[e.RowIndex];
            int NurseId = Convert.ToInt32(gvNurses.DataKeys[e.RowIndex]["NurseID"]);
            int userId = Convert.ToInt32(gvNurses.DataKeys[e.RowIndex]["UserID"]);

            // Get values from GridView controls
            string fullName = ((TextBox)row.FindControl("txtFullName")).Text.Trim();
            string username = ((TextBox)row.FindControl("txtUsername")).Text.Trim();
            string password = ((TextBox)row.FindControl("txtPassword")).Text.Trim();
            string role = ((DropDownList)row.FindControl("ddlRole")).SelectedValue;
            string Gender= ((DropDownList)row.FindControl("ddlGender")).SelectedValue;
            DateTime dob = DateTime.Parse(((TextBox)row.FindControl("txtDOB")).Text);
            string address = ((TextBox)row.FindControl("txtAddress")).Text.Trim();
            string spec = ((TextBox)row.FindControl("txtSpec")).Text.Trim();
            string qual = ((TextBox)row.FindControl("txtQual")).Text.Trim();
            int exp = Convert.ToInt32(((TextBox)row.FindControl("txtExp")).Text.Trim());
            decimal sal = Convert.ToDecimal(((TextBox)row.FindControl("txtSalary")).Text.Trim());
            DateTime joining = DateTime.Parse(((TextBox)row.FindControl("txtJoiningDate")).Text);
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

                    // Update Nurses table
                    using (SqlCommand cmd2 = new SqlCommand(
                        @"UPDATE Nurses 
                  SET Gender=@Gender, DateOfBirth=@dob, Address=@address, Specialization=@Spec,Qualification=@Qual, 
                      YearsOfExperience=@Exp, Salary=@sal, JoiningDate=@joining, Status=@Status, UpdatedDate = @UpdatedDate
                  WHERE NurseID=@NurseID", con, trx))
                    {
                        cmd2.Parameters.AddWithValue("@Gender", Gender);
                        cmd2.Parameters.AddWithValue("@dob", SqlDbType.Date).Value = dob.Date;
                        cmd2.Parameters.AddWithValue("@address", address);
                        cmd2.Parameters.AddWithValue("@Spec", spec);
                        cmd2.Parameters.AddWithValue("@Qual", qual);
                        cmd2.Parameters.AddWithValue("@Exp", exp);
                        cmd2.Parameters.AddWithValue("@sal", sal);
                        cmd2.Parameters.AddWithValue("@joining", SqlDbType.Date).Value = joining.Date;
                        cmd2.Parameters.AddWithValue("@Status", status);
                        cmd2.Parameters.AddWithValue("@UpdatedDate", DateTime.Now);
                        cmd2.Parameters.AddWithValue("@NurseID", NurseId);
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

            gvNurses.EditIndex = -1;
            BindGrid();
        }

        protected void gvNurses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int NurseId = Convert.ToInt32(gvNurses.DataKeys[e.RowIndex]["NurseID"]);
            int userId = Convert.ToInt32(gvNurses.DataKeys[e.RowIndex]["UserID"]);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction trx = con.BeginTransaction();
                try
                {
                    // Delete Nurses record
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM Nurses WHERE NurseID=@NurseID", con, trx))
                    {
                        cmd.Parameters.AddWithValue("@NurseID", NurseId);
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



        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/AdminDashboard.aspx");
        }
    }
}