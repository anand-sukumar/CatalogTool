using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using ClosedXML.Excel;

namespace CatalogTool
{
    public partial class _Default : Page
    {
        public SqlConnection con;
        public string constr;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            btnExport.Visible = false;
            
            if(!this.IsPostBack)
            {
                DrpdwnProficiencyLevel.Items.Add(new ListItem("", ""));
                DrpdwnProficiencyLevel.Items.Add(new ListItem("1", "1"));
                DrpdwnProficiencyLevel.Items.Add(new ListItem("2", "2"));
                DrpdwnProficiencyLevel.Items.Add(new ListItem("3", "3"));
                DrpdwnProficiencyLevel.Items.Add(new ListItem("4", "4"));
                DrpdwnProficiencyLevel.Items.Add(new ListItem("5", "5"));

                DrpdwnActivityType.Items.Add(new ListItem("", ""));
                DrpdwnActivityType.Items.Add(new ListItem("ELearning", "ELearning"));
                DrpdwnActivityType.Items.Add(new ListItem("Classroom", "Classroom"));
            }
            
        }

        public void Connection()
        {
           
           constr = ConfigurationManager.ConnectionStrings["Anand"].ToString();           

        }

        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {
            Connection();
            //string query = "select * from CourseCatalog";
            //SqlCommand com = new SqlCommand(query, con);

            //SqlDataReader dr;
            //dr = com.ExecuteReader();
            SqlDataAdapter da;
            DataSet ds = new DataSet();

            // Consume the DB Stored Proc by passing the parameters
            using (SqlConnection SqlCon = new SqlConnection(constr))
            {
                try
                {
                    SqlCon.Open();

                    SqlCommand cmd = new SqlCommand("USP_GetCourseDetails", SqlCon);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@CourseName", SqlDbType.VarChar));
                    cmd.Parameters["@CourseName"].Value = TxtCourseName.Text;

                    cmd.Parameters.Add(new SqlParameter("@SkillName", SqlDbType.VarChar));
                    cmd.Parameters["@SkillName"].Value = TxtSkillName.Text;

                    cmd.Parameters.Add(new SqlParameter("@ProficiencyLevel", SqlDbType.Int));
                    //cmd.Parameters["@ProficiencyLevel"].Value = String.IsNullOrEmpty(TxtProficiencyLevel.Text) ? 0 : Convert.ToInt32(TxtProficiencyLevel.Text);
                    cmd.Parameters["@ProficiencyLevel"].Value = String.IsNullOrEmpty(DrpdwnProficiencyLevel.SelectedValue) ? 0 : Convert.ToInt32(DrpdwnProficiencyLevel.SelectedValue);

                    cmd.Parameters.Add(new SqlParameter("@CourseCode", SqlDbType.VarChar));
                    cmd.Parameters["@CourseCode"].Value = TxtCourseCode.Text;

                    cmd.Parameters.Add(new SqlParameter("@CourseDescription", SqlDbType.VarChar));
                    cmd.Parameters["@CourseDescription"].Value = TxtCourseDescription.Text;

                    cmd.Parameters.Add(new SqlParameter("@LicenseNeeded", SqlDbType.VarChar));
                    cmd.Parameters["@LicenseNeeded"].Value = TxtLicenseNeeded.Text;

                    cmd.Parameters.Add(new SqlParameter("@ActivityType", SqlDbType.VarChar));
                    //cmd.Parameters["@ActivityType"].Value = TxtActivityType.Text;
                    cmd.Parameters["@ActivityType"].Value = DrpdwnActivityType.SelectedValue;



                    da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    

                }
                catch (Exception ex) { }
                finally { SqlCon.Close(); }
            }

            if (ds.Tables.Count > 0)
            {
                // Bind the result with the Grid
                SearchResultGrid.DataSource = ds;
                SearchResultGrid.DataBind();
                
                SearchResultGrid.Visible = true;
                btnExport.Visible = true;

                lblErrorMessage.Text = "";
                TxtCourseName.Text = "";
                TxtSkillName.Text = "";
                DrpdwnProficiencyLevel.SelectedIndex = -1;
                TxtCourseCode.Text = "";
                TxtCourseDescription.Text = "";
                DrpdwnActivityType.SelectedIndex = -1;
                TxtLicenseNeeded.Text = "";
            }
            else
            {
                SearchResultGrid.Visible = false;
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = "The search Term Is Not Available in the Records"; ;

            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
           // override case
            
        }

        private void ExportGridToExcel()
        {
            
            // Export Gridview results to Excel xlsx format

            DataTable dt = new DataTable("GridView_Data");

            // Fetch Header Text
            foreach(Control c in SearchResultGrid.HeaderRow.Controls)
            {
                dt.Columns.Add(((System.Web.UI.WebControls.BoundField)((System.Web.UI.WebControls.DataControlFieldCell)c).ContainingField).DataField);
            }
            

                foreach (GridViewRow row in SearchResultGrid.Rows)
                {
                    dt.Rows.Add();
                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                        dt.Rows[dt.Rows.Count - 1][i] = row.Cells[i].Text;
                    }
                }
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt);
                    string FileName = "Anand" + DateTime.Now;
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }
            

        }



        protected void btnExport_ServerClick(object sender, EventArgs e)
        {
            // Export Excel Method
            ExportGridToExcel();
        }
    }
}