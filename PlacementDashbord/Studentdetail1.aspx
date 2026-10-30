<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDetails.aspx.cs" Inherits="PlacementDashboard.StudentDetails" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Student Details</title>

    <style>
        body {
            margin:0;
            font-family:Arial;
            background:#f4f6fb;
        }
        .sidebar {
            width:220px;
            height:100vh;
            position:fixed;
            background:#172554;
            color:white;
            padding:20px;
            box-sizing:border-box;
        }
        .sidebar a {
            display:block;
            color:white;
            text-decoration:none;
            padding:13px 8px;
            margin-top:8px;
        }
        .sidebar a:hover { background:#334b85; }
        .main {
            margin-left:220px;
            padding:30px;
        }
        .panel {
            background:white;
            padding:25px;
            border-radius:10px;
            max-width:650px;
        }
        .detail {
            padding:13px;
            border-bottom:1px solid #ddd;
        }
        .heading {
            font-weight:bold;
            display:inline-block;
            width:180px;
        }
        .btn {
            display:inline-block;
            margin-top:20px;
            padding:10px 18px;
            background:#172554;
            color:white;
            text-decoration:none;
            border-radius:5px;
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
        <h1>Student Details</h1>

        <div class="panel">

            <div class="detail">
                <span class="heading">Enrollment Number:</span>
                <asp:Label ID="lblEnrollment" runat="server" />
            </div>

            <div class="detail">
                <span class="heading">Student Name:</span>
                <asp:Label ID="lblName" runat="server" />
            </div>

            <div class="detail">
                <span class="heading">Department:</span>
                <asp:Label ID="lblDepartment" runat="server" />
            </div>

            <div class="detail">
                <span class="heading">Batch:</span>
                <asp:Label ID="lblBatch" runat="server" />
            </div>

            <div class="detail">
                <span class="heading">Company:</span>
                <asp:Label ID="lblCompany" runat="server" />
            </div>

            <div class="detail">
                <span class="heading">Package:</span>
                <asp:Label ID="lblPackage" runat="server" />
            </div>

            <div class="detail">
                <span class="heading">Placement Status:</span>
                <asp:Label ID="lblStatus" runat="server" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />

            <br />

            <a href="Students.aspx" class="btn">Back to Students</a>

        </div>
    </div>

</form>
</body>
</html>