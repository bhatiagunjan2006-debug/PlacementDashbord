<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="PlacementDashboard.Students" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Students</title>
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
        .panel {
            background:white; padding:22px;
            border-radius:10px; margin-top:20px;
        }
        .grid { width:100%; border-collapse:collapse; }
        .grid th {
            background:#172554; color:white; padding:12px;
        }
        .grid td { padding:11px; border-bottom:1px solid #ddd; }
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
        <h1>Student Management</h1>
        <p>View all registered student placement records.</p>

        <div class="panel">
            <asp:GridView ID="gvStudents" runat="server"
                AutoGenerateColumns="False"
                CssClass="grid"
                EmptyDataText="No students found.">

                <Columns>
                    <asp:BoundField DataField="EnrollmentNo" HeaderText="Enrollment No" />
                    <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                    <asp:BoundField DataField="Department" HeaderText="Department" />
                    <asp:BoundField DataField="Batch" HeaderText="Batch" />
                    <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                    <asp:BoundField DataField="PackageLPA" HeaderText="Package (LPA)"
                        DataFormatString="{0:N2}" NullDisplayText="-" />
                    <asp:BoundField DataField="PlacementStatus" HeaderText="Status" />

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