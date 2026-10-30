<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="PlacementDashboard.Analytics" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Placement Analytics</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body { margin:0; font-family:Arial; background:#f4f6fb; }
        .sidebar {
            width:220px; height:100vh; position:fixed;
            background:#172554; color:white; padding:20px;
            box-sizing:border-box;
        }
        .sidebar a {
            display:block; color:white; text-decoration:none;
            padding:13px 8px; margin-top:8px;
        }
        .sidebar a:hover { background:#334b85; }
        .main { margin-left:220px; padding:30px; }
        .charts {
            display:grid;
            grid-template-columns:repeat(2, minmax(0, 1fr));
            gap:20px;
        }
        .chart-box {
            background:white; padding:20px;
            border-radius:10px; min-width:0;
        }
        .chart-box canvas { max-height:320px; }
        @media(max-width:850px) {
            .charts { grid-template-columns:1fr; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="sidebar">
        <h2>Placement Portal</h2>
        <a href="Default.aspx">Dashboard</a>
        <a href="Students.aspx">Students</a>
        <a href="Analytics.aspx">Analytics</a>
        <a href="Reports.aspx">Reports</a>
    </div>

    <div class="main">
        <h1>Placement Analytics</h1>
        <p>Visual analysis of student placement information.</p>

        <div class="charts">

            <div class="chart-box">
                <h3>1. Placement Status</h3>
                <canvas id="statusChart"></canvas>
            </div>

            <div class="chart-box">
                <h3>2. Company-wise Placements</h3>
                <canvas id="companyChart"></canvas>
            </div>

            <div class="chart-box">
                <h3>3. Student-wise Salary Packages</h3>
                <canvas id="salaryChart"></canvas>
            </div>

            <div class="chart-box">
                <h3>4. Department-wise Placements</h3>
                <canvas id="departmentChart"></canvas>
            </div>

            <div class="chart-box">
                <h3>5. Salary Package Distribution</h3>
                <canvas id="distributionChart"></canvas>
            </div>

        </div>

        <asp:Literal ID="litChartData" runat="server"></asp:Literal>
    </div>

</form>

<script>
const data = window.placementData;

function createChart(id, type, labels, datasets) {
    new Chart(document.getElementById(id), {
        type: type,
        data: {
            labels: labels,
            datasets: datasets
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { display: true }
            }
        }
    });
}

createChart(
    "statusChart",
    "doughnut",
    data.statusLabels,
    [{
        label: "Students",
        data: data.statusValues
    }]
);

createChart(
    "companyChart",
    "bar",
    data.companyLabels,
    [{
        label: "Placed Students",
        data: data.companyValues
    }]
);

createChart(
    "salaryChart",
    "bar",
    data.salaryLabels,
    [{
        label: "Package (LPA)",
        data: data.salaryValues
    }]
);

createChart(
    "departmentChart",
    "bar",
    data.departmentLabels,
    [
        {
            label: "Placed",
            data: data.departmentPlaced
        },
        {
            label: "Not Placed",
            data: data.departmentNotPlaced
        }
    ]
);

createChart(
    "distributionChart",
    "bar",
    data.distributionLabels,
    [{
        label: "Number of Students",
        data: data.distributionValues
    }]
);
</script>

</body>
</html>