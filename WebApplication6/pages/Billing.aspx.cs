using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication6.pages
{
    public partial class Billing : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;
        int patientId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["PatientID"] != null)
                {
                    patientId = Convert.ToInt32(Request.QueryString["PatientID"]);
                    ViewState["PatientID"] = patientId;
                    LoadBilling(patientId);
                }
                else
                {
                    Response.Redirect("Admission.aspx");
                }
            }
            else
            {
                patientId = Convert.ToInt32(ViewState["PatientID"]);
            }
        }

        private void LoadBilling(int patientId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT BillID, BillDate, Description, Amount, PaymentMode, PaymentStatus, 
                                        InsuranceProvider, PolicyNumber 
                                 FROM Billing WHERE PatientID=@pid";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@pid", patientId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBilling.DataSource = dt;
                gvBilling.DataBind();
            }
        }

        protected void btnAddBill_Click(object sender, EventArgs e)
        {
            int patientId = Convert.ToInt32(ViewState["PatientID"]);
            string desc = txtBillDescNew.Text.Trim();
            decimal amount = Convert.ToDecimal(txtBillAmountNew.Text.Trim());
            string mode = ddlBillModeNew.SelectedValue;
            string insurance = txtInsuranceProviderNew.Text.Trim();
            string policy = txtPolicyNumberNew.Text.Trim();
            int billedBy = Convert.ToInt32(Session["UserID"]); // logged-in user

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Billing 
                                (PatientID, Amount, Description, BilledBy, PaymentMode, InsuranceProvider, PolicyNumber) 
                                 VALUES (@pid, @amt, @desc, @billedBy, @mode, @ins, @policy)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@pid", patientId);
                cmd.Parameters.AddWithValue("@amt", amount);
                cmd.Parameters.AddWithValue("@desc", desc);
                cmd.Parameters.AddWithValue("@billedBy", billedBy);
                cmd.Parameters.AddWithValue("@mode", mode);
                cmd.Parameters.AddWithValue("@ins", insurance);
                cmd.Parameters.AddWithValue("@policy", policy);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // clear fields
            txtBillDescNew.Text = "";
            txtBillAmountNew.Text = "";
            txtInsuranceProviderNew.Text = "";
            txtPolicyNumberNew.Text = "";

            LoadBilling(patientId);
        }

        protected void gvBilling_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBilling.EditIndex = e.NewEditIndex;
            LoadBilling(Convert.ToInt32(ViewState["PatientID"]));
        }

        protected void gvBilling_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBilling.EditIndex = -1;
            LoadBilling(Convert.ToInt32(ViewState["PatientID"]));
        }

        protected void gvBilling_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int billId = Convert.ToInt32(gvBilling.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvBilling.Rows[e.RowIndex];

            string desc = ((TextBox)row.FindControl("txtDesc")).Text;
            decimal amount = Convert.ToDecimal(((TextBox)row.FindControl("txtAmount")).Text);
            string mode = ((DropDownList)row.FindControl("ddlMode")).SelectedValue;
            string status = ((DropDownList)row.FindControl("ddlStatus")).SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"UPDATE Billing 
                                 SET Description=@desc, Amount=@amt, PaymentMode=@mode, PaymentStatus=@status 
                                 WHERE BillID=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@desc", desc);
                cmd.Parameters.AddWithValue("@amt", amount);
                cmd.Parameters.AddWithValue("@mode", mode);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@id", billId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvBilling.EditIndex = -1;
            LoadBilling(Convert.ToInt32(ViewState["PatientID"]));
        }

        protected void gvBilling_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int billId = Convert.ToInt32(gvBilling.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Billing WHERE BillID=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", billId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadBilling(Convert.ToInt32(ViewState["PatientID"]));
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/Admission.aspx");
        }
    }
}
