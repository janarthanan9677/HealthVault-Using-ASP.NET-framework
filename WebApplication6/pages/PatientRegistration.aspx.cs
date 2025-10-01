using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication6.pages
{
    public partial class PatientRegistration : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string gender = ddlGender.SelectedValue;
            string dob = txtDOB.Text;
            string contact = txtContact.Text.Trim();
            string address = txtAddress.Text.Trim();
            // 🔹 Add more fields when you add corresponding controls in .aspx
            string bloodGroup = ddlBloodGroup.SelectedValue; // Example
            string maritalStatus = ddlMaritalStatus.SelectedValue; // Example
            string email = txtEmail.Text.Trim();
            string city = txtCity.Text.Trim();
            string state = txtState.Text.Trim();
            string pincode = txtPincode.Text.Trim();
            string altContact = txtAltContact.Text.Trim();
            string emergencyName = txtEmergencyName.Text.Trim();
            string emergencyNumber = txtEmergencyNumber.Text.Trim();
            string medicalHistory = txtMedicalHistory.Text.Trim();
            string allergies = txtAllergies.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["HospitalDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();


                // ✅ Generate Patient Code
                string newCode = "PAT0001";
                SqlCommand cmdCode = new SqlCommand("SELECT TOP 1 PatientCode FROM Patients ORDER BY PatientID DESC", con);
                var lastCode = cmdCode.ExecuteScalar();
                if (lastCode != null)
                {
                    int num = Convert.ToInt32(lastCode.ToString().Substring(3)) + 1;
                    newCode = "PAT" + num.ToString("D4");
                }

                // ✅ Insert query (matching table structure)
                string query = @"
                    INSERT INTO Patients
                    (PatientCode, FirstName, LastName, Gender, DateOfBirth, 
                     BloodGroup, MaritalStatus, ContactNumber, AlternateNumber, Email, 
                     Address, City, State, Pincode, EmergencyContactName, EmergencyContactNumber, 
                     MedicalHistory, Allergies, CreatedDate, UpdatedDate)
                    VALUES
                    (@PatientCode, @FirstName, @LastName, @Gender, @DateOfBirth, 
                     @BloodGroup, @MaritalStatus, @ContactNumber, @AlternateNumber, @Email, 
                     @Address, @City, @State, @Pincode, @EmergencyContactName, @EmergencyContactNumber, 
                     @MedicalHistory, @Allergies, GETDATE(), GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@PatientCode", newCode);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Gender", gender);
                cmd.Parameters.AddWithValue("@DateOfBirth", dob);
                cmd.Parameters.AddWithValue("@BloodGroup", string.IsNullOrEmpty(bloodGroup) ? (object)DBNull.Value : bloodGroup);
                cmd.Parameters.AddWithValue("@MaritalStatus", string.IsNullOrEmpty(maritalStatus) ? (object)DBNull.Value : maritalStatus);
                cmd.Parameters.AddWithValue("@ContactNumber", contact);
                cmd.Parameters.AddWithValue("@AlternateNumber", string.IsNullOrEmpty(altContact) ? (object)DBNull.Value : altContact);
                cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(city) ? (object)DBNull.Value : city);
                cmd.Parameters.AddWithValue("@State", string.IsNullOrEmpty(state) ? (object)DBNull.Value : state);
                cmd.Parameters.AddWithValue("@Pincode", string.IsNullOrEmpty(pincode) ? (object)DBNull.Value : pincode);
                cmd.Parameters.AddWithValue("@EmergencyContactName", string.IsNullOrEmpty(emergencyName) ? (object)DBNull.Value : emergencyName);
                cmd.Parameters.AddWithValue("@EmergencyContactNumber", string.IsNullOrEmpty(emergencyNumber) ? (object)DBNull.Value : emergencyNumber);
                cmd.Parameters.AddWithValue("@MedicalHistory", string.IsNullOrEmpty(medicalHistory) ? (object)DBNull.Value : medicalHistory);
                cmd.Parameters.AddWithValue("@Allergies", string.IsNullOrEmpty(allergies) ? (object)DBNull.Value : allergies);

                cmd.ExecuteNonQuery();

                lblMessage.Text = "✅ Patient Registered Successfully! Code: " + newCode;
                lblMessage.ForeColor = System.Drawing.Color.Green;


                txtFirstName.Text = txtLastName.Text = txtDOB.Text = txtContact.Text = txtAddress.Text = txtEmail.Text = txtCity.Text = txtState.Text = txtPincode.Text = txtEmergencyName.Text = txtAltContact.Text = txtEmergencyNumber.Text = txtMedicalHistory.Text = txtAllergies.Text = "";
            
                ddlGender.SelectedIndex = ddlBloodGroup.SelectedIndex = ddlMaritalStatus.SelectedIndex = 0;
            }
        }
       

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/pages/Admission.aspx");

        }
    }
}
