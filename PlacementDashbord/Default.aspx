<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PlacementDashboard._Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Placement Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #f4f6fb;
        }
        .sidebar {
            width: 220px;
            height: 100vh;
            background: #172554;
            color: white;
            position: fixed;
            padding: 20px;
            box-sizing: border-box;
        }
        .sidebar h2 { font-size: 21px; }
        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 13px 8px;
            margin-top: 8px;
            border-radius: 6px;
        }
        .sidebar a:hover { background: #334b85; }
        .main {
            margin-left: 220px;
            padding: 30px;
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin: 25px 0;
        }
        .card {
            background: white;
            padding: 22px;
            border-radius: 10px;
            box-shadow: 0 2px 8px #ddd;
        }
        .card h3 { color: #64748b; }
        .number {
            font-size: 28px;
            font-weight: bold;
            color: #172554;
        }
        .panel {
            background: white;
            padding: 22px;
            border-radius: 10px;
            margin-top: 20px;
        }
        input, .btn {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn {
            background: #172554;
            color: white;
            cursor: pointer;
        }
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        @media(max-width: 900px) {
            .cards { grid-template-columns: repeat(2, 1fr); }
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
        <h1>Placement Dashboard</h1>
        <p>Welcome to the Student Placement Management System.</p>

        <div class="cards">
            <div class="card">
                <h3>Total Students</h3>
                <div class="number">
                    <asp:Label ID="lblTotal" runat="server" Text="0" />
                </div>
            </div>

            <div class="card">
                <h3>Students Placed</h3>
                <div class="number">
                    <asp:Label ID="lblPlaced" runat="server" Text="0" />
                </div>
            </div>

            <div class="card">
                <h3>Companies</h3>
                <div class="number">
                    <asp:Label ID="lblCompanies" runat="server" Text="0" />
                </div>
            </div>

            <div class="card">
                <h3>Average Package</h3>
                <div class="number">
                    <asp:Label ID="lblPackage" runat="server" Text="0" />
                    LPA
                </div>
            </div>
        </div>

        <div class="panel">
            <h2>Student Records</h2>

            <asp:TextBox ID="txtSearch" runat="server"
                placeholder="Search by name or enrollment number" />

            <asp:Button ID="btnSearch" runat="server"
                Text="Search" CssClass="btn" OnClick="btnSearch_Click" />

            <asp:Button ID="btnReset" runat="server"
                Text="Reset" CssClass="btn" OnClick="btnReset_Click" />

            <asp:Label ID="lblMessage" runat="server" />

            <asp:GridView ID="gvStudents" runat="server"
                AutoGenerateColumns="False"
                CssClass="grid"
                EmptyDataText="No student records found.">

                <Columns>
                    <asp:BoundField DataField="EnrollmentNo"
                        HeaderText="Enrollment No" />

                    <asp:BoundField DataField="StudentName"
                        HeaderText="Student Name" />

                    <asp:BoundField DataField="Department"
                        HeaderText="Department" />

                    <asp:BoundField DataField="Batch"
                        HeaderText="Batch" />

                    <asp:BoundField DataField="CompanyName"
                        HeaderText="Company" />

                    <asp:BoundField DataField="PackageLPA"
                        HeaderText="Package (LPA)"
                        DataFormatString="{0:N2}"
                        NullDisplayText="-" />

                    <asp:BoundField DataField="PlacementStatus"
                        HeaderText="Status" />

                    <asp:HyperLinkField
                        Text="View Details"
                        DataNavigateUrlFields="StudentId"
                        DataNavigateUrlFormatString="StudentDetails.aspx?id={0}"
                        HeaderText="Details"
                        Target="_blank" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</form>
</body>
</html>