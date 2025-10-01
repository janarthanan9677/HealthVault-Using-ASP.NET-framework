using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication6.pages
{
    public partial class PatientDetails : System.Web.UI.Page
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

                    LoadPatientDetails(patientId);
                    LoadVitals(patientId);
                    LoadPrescriptions(patientId);
                }
                else
                {
                    Response.Redirect("PatientList.aspx");
                }
            }
            else
            {
                patientId = Convert.ToInt32(ViewState["PatientID"]);
            }
        }

        #region Load Data
        void LoadPatientDetails(int patientId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"SELECT PatientCode, FirstName, LastName, Gender, DateOfBirth, BloodGroup, MaritalStatus,
                              ContactNumber, AlternateNumber, Email, Address, City, State, Pincode,
                              EmergencyContactName, EmergencyContactNumber, MedicalHistory, Allergies
                       FROM Patients
                       WHERE PatientID=@pid";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@pid", patientId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        lblPatientCode.Text = dr["PatientCode"].ToString();
                        lblPatientName.Text = dr["FirstName"].ToString() + " " + dr["LastName"].ToString();
                        lblGender.Text = dr["Gender"].ToString();
                        lblDateOfBirth.Text = Convert.ToDateTime(dr["DateOfBirth"]).ToString("dd/MM/yyyy");
                        lblBloodGroup.Text = dr["BloodGroup"].ToString();
                        lblMaritalStatus.Text = dr["MaritalStatus"].ToString();
                        lblContactNumber.Text = dr["ContactNumber"].ToString();
                        lblAlternateNumber.Text = dr["AlternateNumber"].ToString();
                        lblEmail.Text = dr["Email"].ToString();
                        lblAddress.Text = dr["Address"].ToString();
                        lblCity.Text = dr["City"].ToString();
                        lblState.Text = dr["State"].ToString();
                        lblPincode.Text = dr["Pincode"].ToString();
                        lblEmergencyContactName.Text = dr["EmergencyContactName"].ToString();
                        lblEmergencyContactNumber.Text = dr["EmergencyContactNumber"].ToString();
                        lblMedicalHistory.Text = dr["MedicalHistory"].ToString();
                        lblAllergies.Text = dr["Allergies"].ToString();
                    }
                }
            }
        }
       

        void LoadVitals(int patientId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"SELECT v.VitalID, v.VitalType, v.VitalValue, v.Unit, v.Comments, u.FullName AS AddedByName, v.AddedOn
                               FROM Vitals v
                               INNER JOIN Users u ON v.AddedBy = u.UserID
                               WHERE v.PatientID=@pid
                               ORDER BY v.AddedOn DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@pid", patientId);
                    con.Open();
                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());
                    gvVitals.DataSource = dt;
                    gvVitals.DataBind();
                }
            }
        }

        void LoadPrescriptions(int patientId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"SELECT p.PrescriptionID, p.MedicineName, p.Dosage, p.Quantity, p.Duration, p.Comments, u.FullName AS PrescribedByName, p.PrescribedOn
                               FROM Prescriptions p
                               INNER JOIN Users u ON p.PrescribedBy = u.UserID
                               WHERE p.PatientID=@pid
                               ORDER BY p.PrescribedOn DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@pid", patientId);
                    con.Open();
                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());
                    gvPrescriptions.DataSource = dt;
                    gvPrescriptions.DataBind();
                }
            }
        }
        #endregion

        #region Vitals Edit/Delete
        protected void gvVitals_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvVitals.EditIndex = e.NewEditIndex;
            LoadVitals(patientId);
        }

        protected void gvVitals_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvVitals.EditIndex = -1;
            LoadVitals(patientId);
        }

        protected void gvVitals_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvVitals.Rows[e.RowIndex];
            int vitalId = Convert.ToInt32(gvVitals.DataKeys[e.RowIndex].Value);

            string vitalType = ((TextBox)row.FindControl("txtVitalType")).Text;
            string value = ((TextBox)row.FindControl("txtVitalValue")).Text;
            string unit = ((TextBox)row.FindControl("txtUnit")).Text;
            string comments = ((TextBox)row.FindControl("txtComments")).Text;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "UPDATE Vitals SET VitalType=@vtype, VitalValue=@vvalue, Unit=@unit, Comments=@comments WHERE VitalID=@id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@vtype", vitalType);
                    cmd.Parameters.AddWithValue("@vvalue", value);
                    cmd.Parameters.AddWithValue("@unit", unit);
                    cmd.Parameters.AddWithValue("@comments", comments);
                    cmd.Parameters.AddWithValue("@id", vitalId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvVitals.EditIndex = -1;
            LoadVitals(patientId);
        }

        protected void gvVitals_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int vitalId = Convert.ToInt32(gvVitals.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "DELETE FROM Vitals WHERE VitalID=@id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", vitalId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            LoadVitals(patientId);
        }
        #endregion

        #region Prescriptions Edit/Delete
        protected void gvPrescriptions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPrescriptions.EditIndex = e.NewEditIndex;
            LoadPrescriptions(patientId);
        }

        protected void gvPrescriptions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPrescriptions.EditIndex = -1;
            LoadPrescriptions(patientId);
        }

        protected void gvPrescriptions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvPrescriptions.Rows[e.RowIndex];
            int prescId = Convert.ToInt32(gvPrescriptions.DataKeys[e.RowIndex].Value);

            string medicine = ((TextBox)row.FindControl("txtMedicine")).Text;
            string dosage = ((TextBox)row.FindControl("txtDosage")).Text;
            int quantity = Convert.ToInt32(((TextBox)row.FindControl("txtQuantity")).Text);
            string duration = ((TextBox)row.FindControl("txtDuration")).Text;
            string comments = ((TextBox)row.FindControl("txtPrescComments")).Text;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"UPDATE Prescriptions 
                               SET MedicineName=@med, Dosage=@dosage, Quantity=@qty, Duration=@dur, Comments=@comments 
                               WHERE PrescriptionID=@id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@med", medicine);
                    cmd.Parameters.AddWithValue("@dosage", dosage);
                    cmd.Parameters.AddWithValue("@qty", quantity);
                    cmd.Parameters.AddWithValue("@dur", duration);
                    cmd.Parameters.AddWithValue("@comments", comments);
                    cmd.Parameters.AddWithValue("@id", prescId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvPrescriptions.EditIndex = -1;
            LoadPrescriptions(patientId);
        }

        protected void gvPrescriptions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int prescId = Convert.ToInt32(gvPrescriptions.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "DELETE FROM Prescriptions WHERE PrescriptionID=@id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", prescId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            LoadPrescriptions(patientId);
        }
        #endregion

        #region Add New Vitals / Prescriptions
        protected void btnAddVital_Click(object sender, EventArgs e)
        {
            string vitalType = ddlVitalType.SelectedValue;
            string value = txtVitalValueNew.Text.Trim();
            string unit = txtUnitNew.Text.Trim();
            string comments = txtCommentsNew.Text.Trim();
            int addedBy = 1; // Replace with Session["UserID"]

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO Vitals (PatientID, VitalType, VitalValue, Unit, Comments, AddedBy)
                               VALUES (@pid, @vtype, @vvalue, @unit, @comments, @addedBy)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@pid", patientId);
                    cmd.Parameters.AddWithValue("@vtype", vitalType);
                    cmd.Parameters.AddWithValue("@vvalue", value);
                    cmd.Parameters.AddWithValue("@unit", unit);
                    cmd.Parameters.AddWithValue("@comments", comments);
                    cmd.Parameters.AddWithValue("@addedBy", addedBy);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            txtVitalValueNew.Text = "";
            txtUnitNew.Text = "";
            txtCommentsNew.Text = "";
            LoadVitals(patientId);
        }

        protected void btnAddPrescription_Click(object sender, EventArgs e)
        {
            string medicine = txtMedicineNew.Text.Trim();
            string dosage = txtDosageNew.Text.Trim();
            int quantity = Convert.ToInt32(txtQuantityNew.Text.Trim());
            string duration = txtDurationNew.Text.Trim();
            string comments = txtPrescriptionCommentsNew.Text.Trim();
            int prescribedBy = 1; // Replace with Session["UserID"]

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO Prescriptions (PatientID, MedicineName, Dosage, Quantity, Duration, Comments, PrescribedBy)
                               VALUES (@pid, @med, @dosage, @qty, @dur, @comments, @prescribedBy)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@pid", patientId);
                    cmd.Parameters.AddWithValue("@med", medicine);
                    cmd.Parameters.AddWithValue("@dosage", dosage);
                    cmd.Parameters.AddWithValue("@qty", quantity);
                    cmd.Parameters.AddWithValue("@dur", duration);
                    cmd.Parameters.AddWithValue("@comments", comments);
                    cmd.Parameters.AddWithValue("@prescribedBy", prescribedBy);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            txtMedicineNew.Text = "";
            txtDosageNew.Text = "";
            txtQuantityNew.Text = "";
            txtDurationNew.Text = "";
            txtPrescriptionCommentsNew.Text = "";
            LoadPrescriptions(patientId);
        }
        #endregion

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/PatientList.aspx");
        }
    }
}
