using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PlacementDashboard
{
    public partial class Students : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        void LoadStudents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT StudentId, EnrollmentNo, StudentName,
                    Department, Batch, CompanyName, PackageLPA, PlacementStatus
                    FROM Students
                    ORDER BY StudentId";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();

                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }
    }
}