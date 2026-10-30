using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace PlacementDashboard
{
    public partial class Analytics : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCharts();
            }
        }

        void LoadCharts()
        {
            Dictionary<string, object> data = new Dictionary<string, object>();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1. Placement status
                List<string> statusLabels = new List<string>();
                List<int> statusValues = new List<int>();

                string q1 = @"
                    SELECT PlacementStatus, COUNT(*) AS Total
                    FROM Students
                    GROUP BY PlacementStatus";

                using (SqlCommand cmd = new SqlCommand(q1, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        statusLabels.Add(Convert.ToString(dr["PlacementStatus"]));
                        statusValues.Add(Convert.ToInt32(dr["Total"]));
                    }
                }

                data["statusLabels"] = statusLabels;
                data["statusValues"] = statusValues;

                // 2. Company-wise placements
                List<string> companyLabels = new List<string>();
                List<int> companyValues = new List<int>();

                string q2 = @"
                    SELECT CompanyName, COUNT(*) AS Total
                    FROM Students
                    WHERE PlacementStatus = 'Placed'
                    AND CompanyName IS NOT NULL
                    GROUP BY CompanyName
                    ORDER BY CompanyName";

                using (SqlCommand cmd = new SqlCommand(q2, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        companyLabels.Add(Convert.ToString(dr["CompanyName"]));
                        companyValues.Add(Convert.ToInt32(dr["Total"]));
                    }
                }

                data["companyLabels"] = companyLabels;
                data["companyValues"] = companyValues;

                // 3. Student-wise salary packages
                List<string> salaryLabels = new List<string>();
                List<decimal> salaryValues = new List<decimal>();

                string q3 = @"
                    SELECT StudentName, PackageLPA
                    FROM Students
                    WHERE PlacementStatus = 'Placed'
                    AND PackageLPA IS NOT NULL
                    ORDER BY StudentName";

                using (SqlCommand cmd = new SqlCommand(q3, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        salaryLabels.Add(Convert.ToString(dr["StudentName"]));
                        salaryValues.Add(Convert.ToDecimal(dr["PackageLPA"]));
                    }
                }

                data["salaryLabels"] = salaryLabels;
                data["salaryValues"] = salaryValues;

                // 4. Department-wise placed and not placed
                List<string> departmentLabels = new List<string>();
                List<int> departmentPlaced = new List<int>();
                List<int> departmentNotPlaced = new List<int>();

                string q4 = @"
                    SELECT Department,
                    SUM(CASE WHEN PlacementStatus = 'Placed' THEN 1 ELSE 0 END) AS Placed,
                    SUM(CASE WHEN PlacementStatus <> 'Placed' OR PlacementStatus IS NULL THEN 1 ELSE 0 END) AS NotPlaced
                    FROM Students
                    GROUP BY Department
                    ORDER BY Department";

                using (SqlCommand cmd = new SqlCommand(q4, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        departmentLabels.Add(Convert.ToString(dr["Department"]));
                        departmentPlaced.Add(Convert.ToInt32(dr["Placed"]));
                        departmentNotPlaced.Add(Convert.ToInt32(dr["NotPlaced"]));
                    }
                }

                data["departmentLabels"] = departmentLabels;
                data["departmentPlaced"] = departmentPlaced;
                data["departmentNotPlaced"] = departmentNotPlaced;

                // 5. Salary package distribution
                List<string> distributionLabels = new List<string>
                {
                    "15–16 LPA",
                    "16–18 LPA",
                    "18–20 LPA",
                    "Other"
                };

                List<int> distributionValues = new List<int>();

                string q5 = @"
                    SELECT
                    SUM(CASE WHEN PackageLPA >= 15 AND PackageLPA < 16 THEN 1 ELSE 0 END) AS Range1,
                    SUM(CASE WHEN PackageLPA >= 16 AND PackageLPA < 18 THEN 1 ELSE 0 END) AS Range2,
                    SUM(CASE WHEN PackageLPA >= 18 AND PackageLPA <= 20 THEN 1 ELSE 0 END) AS Range3,
                    SUM(CASE WHEN PackageLPA < 15 OR PackageLPA > 20 THEN 1 ELSE 0 END) AS OtherRange
                    FROM Students
                    WHERE PlacementStatus = 'Placed'";

                using (SqlCommand cmd = new SqlCommand(q5, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        distributionValues.Add(Convert.ToInt32(dr["Range1"]));
                        distributionValues.Add(Convert.ToInt32(dr["Range2"]));
                        distributionValues.Add(Convert.ToInt32(dr["Range3"]));
                        distributionValues.Add(Convert.ToInt32(dr["OtherRange"]));
                    }
                }

                data["distributionLabels"] = distributionLabels;
                data["distributionValues"] = distributionValues;
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string json = serializer.Serialize(data);

            litChartData.Text =
                "<script>window.placementData = " + json + ";</script>";
        }
    }
}