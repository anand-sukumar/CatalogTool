<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CatalogTool._Default" EnableEventValidation="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Search Catalog files</p>
      
    </div>
    
    <div class="row" style="margin-left:20px;">
        <div>
            <h4>Basic Search</h4>
            <table style="width: 90%;">  
            <tr>
                <td>Course Name</td>
                <td>  
                <asp:TextBox ID="TxtCourseName" runat="server"  MaxLength="100" Wrap="true" Width="200px"></asp:TextBox>  
                </td>  
                <td>Skill Name</td>  
                <td>
                    <asp:TextBox ID="TxtSkillName" runat="server" MaxLength="100" Wrap="true" Width="200px" ></asp:TextBox>
                </td>
                <td>Proficiency Level</td>
                <td>
                    <%--<asp:TextBox ID="TxtProficiencyLevel" runat="server"  MaxLength="100" Wrap="true"></asp:TextBox>--%>
                    <asp:DropDownList ID="DrpdwnProficiencyLevel" runat="server" Width="160px"></asp:DropDownList>
                </td>
            </tr>  
            </table>  

        </div>
        <br />
        <div>
            <h4>Advanced Search</h4>
            <table style="width: 90%; padding: 10px 10px 10px 10px;">  
            <tr>
                <td>Course Code</td>
                <td>  
                <asp:TextBox ID="TxtCourseCode" runat="server"  MaxLength="100" Wrap="true" Width="200px"></asp:TextBox>  
                </td>  
                <td>Desciption</td>  
                <td>
                    <asp:TextBox ID="TxtCourseDescription" runat="server" MaxLength="100" Wrap="true" Width="200px" ></asp:TextBox>
                </td>
                <td>License Needed</td>
                <td>
                    <asp:TextBox ID="TxtLicenseNeeded" runat="server"  MaxLength="100" Wrap="true"></asp:TextBox>
                </td>
            </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                    <td>

                    </td>
                </tr>
            <tr>
                <td>Activity Type</td>
                <td>
                   <%-- <asp:TextBox ID="TxtActivityType" runat="server"  MaxLength="100" Wrap="true" Width="200px"></asp:TextBox>--%>
                    <asp:DropDownList ID="DrpdwnActivityType" runat="server" Width="200px"></asp:DropDownList>
                </td>
            </tr>  
            </table>
         </div>
         <div>
             <br />
            <p><input type="button" class="btn btn-primary btn-lg" id="btnSearch" runat="server" value="Search" style="font-size:smaller; height:40px; width:130px;" onserverclick="btnSearch_ServerClick" /></p>
         </div>
        <br />
        <table><tr><td><p><asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label></p></td></tr></table>
        <div style="width=70%">
            <asp:GridView ID="SearchResultGrid" runat="server" HeaderStyle-BackColor="#ccccff" RowStyle-BackColor="#ffccff"  HeaderStyle-HorizontalAlign="Center" EmptyDataText="No Results Found" RowStyle-HorizontalAlign="Center"></asp:GridView>            
        </div>
        <div>
             <br /><br />
            <input type="button" class="btn btn-primary btn-lg" id="btnExport" runat="server" value="Export to Excel" style="font-size:smaller; height:40px;" onserverclick="btnExport_ServerClick" />
         
        </div>
    </div>
    
</asp:Content>
