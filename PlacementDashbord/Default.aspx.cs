using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PlacementDashboard
{
    public partial class _Default : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
                LoadStudents("");
            }
        }

        void LoadDashboard()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                    COUNT(*) AS TotalStudents,
                    SUM(CASE WHEN PlacementStatus = 'Placed' THEN 1 ELSE 0 END) AS PlacedStudents,
                    COUNT(DISTINCT CASE WHEN PlacementStatus = 'Placed' THEN CompanyName END) AS TotalCompanies,
                    AVG(CASE WHEN PlacementStatus = 'Placed' THEN PackageLPA END) AS AveragePackage
                    FROM Students";

                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTotal.Text = Convert.ToString(dr["TotalStudents"]);
                    lblPlaced.Text = Convert.ToString(dr["PlacedStudents"]);
                    lblCompanies.Text = Convert.ToString(dr["TotalCompanies"]);

                    lblPackage.Text = dr["AveragePackage"] == DBNull.Value
                        ? "0.00"
                        : Convert.ToDecimal(dr["AveragePackage"]).ToString("0.00");
                }

                dr.Close();
            }
        }

        void LoadStudents(string search)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT StudentId, EnrollmentNo, StudentName,
                    Department, Batch, CompanyName, PackageLPA, PlacementStatus
                    FROM Students
                    WHERE EnrollmentNo LIKE @search
                    OR StudentName LIKE @search
                    ORDER BY StudentId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadStudents(txtSearch.Text.Trim());
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadStudents("");
            lblMessage.Text = "";
        }
    }
}