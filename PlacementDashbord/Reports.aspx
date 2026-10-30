
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="PlacementDashboard.Reports" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Placement Reports</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6fb;
        }

        .sidebar {
            width: 220px;
            height: 100vh;
            position: fixed;
            background: #172554;
            color: white;
            padding: 20px;
            box-sizing: border-box;
        }

        .sidebar h2 {
            font-size: 21px;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 13px 8px;
            margin-top: 8px;
            border-radius: 6px;
        }

        .sidebar a:hover {
            background: #334b85;
        }

        .main {
            margin-left: 220px;
            padding: 30px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-top: 25px;
        }

        .card {
            background: white;
            padding: 22px;
            border-radius: 10px;
            box-shadow: 0 2px 8px #ddd;
        }

        .card h3 {
            color: #64748b;
        }

        .number {
            font-size: 28px;
            font-weight: bold;
            color: #172554;
        }

        .panel {
            background: white;
            padding: 22px;
            border-radius: 10px;
            margin-top: 25px;
            box-shadow: 0 2px 8px #ddd;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .grid th {
            background: #172554;
            color: white;
            padding: 12px;
        }

        .grid td {
            padding: 11px;
            border-bottom: 1px solid #ddd;
        }

        .btn {
            padding: 10px 18px;
            border: none;
            background: #172554;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        @media print {
            .sidebar, .btn {
                display: none;
            }

            .main {
                margin-left: 0;
            }
        }

        @media(max-width: 800px) {
            .cards {
                grid-template-columns: 1fr;
            }
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

        <h1>Placement Reports</h1>
        <p>Summary of student placement performance.</p>

        <div class="cards">

            <div class="card">
                <h3>Total Students</h3>
                <div class="number">
                    <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                </div>
            </div>

            <div class="card">
                <h3>Placed Students</h3>
                <div class="number">
                    <asp:Label ID="lblPlaced" runat="server" Text="0"></asp:Label>
                </div>
            </div>

            <div class="card">
                <h3>Placement Percentage</h3>
                <div class="number">
                    <asp:Label ID="lblPercentage" runat="server" Text="0"></asp:Label>
                    %
                </div>
            </div>

        </div>

        <div class="panel">

            <h2>Company-wise Placement Report</h2>

            <asp:GridView ID="gvReport" runat="server"
                AutoGenerateColumns="False"
                CssClass="grid"
                EmptyDataText="No company placement data available.">

                <Columns>

                    <asp:BoundField
                        DataField="CompanyName"
                        HeaderText="Company Name" />

                    <asp:BoundField
                        DataField="TotalStudents"
                        HeaderText="Students Placed" />

                    <asp:BoundField
                        DataField="AveragePackage"
                        HeaderText="Average Package (LPA)"
                        DataFormatString="{0:N2}"
                        NullDisplayText="-" />

                    <asp:BoundField
                        DataField="HighestPackage"
                        HeaderText="Highest Package (LPA)"
                        DataFormatString="{0:N2}"
                        NullDisplayText="-" />

                </Columns>

            </asp:GridView>

            <br />

            <asp:Button ID="btnPrint" runat="server"
                Text="Print Report"
                CssClass="btn"
                OnClientClick="window.print(); return false;" />

        </div>

    </div>

</form>
</body>
</html>
