using System;
using System.Data.SqlClient;
using System.Configuration;

namespace PlacementDashboard
{
    public partial class StudentDetails : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudentDetails();
            }
        }

        void LoadStudentDetails()
        {
            int studentId;

            if (!int.TryParse(Request.QueryString["id"], out studentId))
            {
                lblMessage.Text = "Invalid student ID.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT EnrollmentNo, StudentName, Department,
                    Batch, CompanyName, PackageLPA, PlacementStatus
                    FROM Students
                    WHERE StudentId = @StudentId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StudentId", studentId);

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblEnrollment.Text = Server.HtmlEncode(Convert.ToString(dr["EnrollmentNo"]));
                        lblName.Text = Server.HtmlEncode(Convert.ToString(dr["StudentName"]));
                        lblDepartment.Text = Server.HtmlEncode(Convert.ToString(dr["Department"]));
                        lblBatch.Text = Server.HtmlEncode(Convert.ToString(dr["Batch"]));
                        lblCompany.Text = Server.HtmlEncode(Convert.ToString(dr["CompanyName"]));

                        lblPackage.Text = dr["PackageLPA"] == DBNull.Value
                            ? "-"
                            : Convert.ToDecimal(dr["PackageLPA"]).ToString("0.00") + " LPA";

                        lblStatus.Text = Server.HtmlEncode(Convert.ToString(dr["PlacementStatus"]));
                    }
                    else
                    {
                        lblMessage.Text = "Student record not found.";
                    }
                }
            }
        }
    }
}