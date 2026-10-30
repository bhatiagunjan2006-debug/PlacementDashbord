
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PlacementDashboard
{
    public partial class Reports : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSummary();
                LoadCompanyReport();
            }
        }

        void LoadSummary()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        COUNT(*) AS TotalStudents,
                        SUM(
                            CASE
                                WHEN PlacementStatus = 'Placed'
                                THEN 1 ELSE 0
                            END
                        ) AS PlacedStudents
                    FROM Students";

                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    int total = Convert.ToInt32(dr["TotalStudents"]);

                    int placed = dr["PlacedStudents"] == DBNull.Value
                        ? 0
                        : Convert.ToInt32(dr["PlacedStudents"]);

                    decimal percentage = total == 0
                        ? 0
                        : (decimal)placed / total * 100;

                    lblTotal.Text = total.ToString();
                    lblPlaced.Text = placed.ToString();
                    lblPercentage.Text = percentage.ToString("0.00");
                }

                dr.Close();
            }
        }

        void LoadCompanyReport()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        CompanyName,
                        COUNT(*) AS TotalStudents,
                        AVG(PackageLPA) AS AveragePackage,
                        MAX(PackageLPA) AS HighestPackage
                    FROM Students
                    WHERE PlacementStatus = 'Placed'
                    AND CompanyName IS NOT NULL
                    GROUP BY CompanyName
                    ORDER BY CompanyName";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvReport.DataSource = dt;
                gvReport.DataBind();
            }
        }
    }
}
