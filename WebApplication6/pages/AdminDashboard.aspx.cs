using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/pages/Login.aspx");
            }
        }

        protected void btnManageDoctors_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ManageDoctors.aspx");
        }

        protected void btnManageNurses_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ManageNurses.aspx");
        }

        protected void btnManageStaff_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ManageStaff.aspx");
        }

        protected void btnReports_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Reports.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/pages/Login.aspx");
        }
    }
}