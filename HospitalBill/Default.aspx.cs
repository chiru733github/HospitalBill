using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HospitalBill
{
    public partial class _Default : Page
    {
        SqlConnection conn = new SqlConnection(@"Data Source=LAPTOP-SBDVLFF5\SQLEXPRESS;Initial Catalog=HospitalDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            EditList.Visible = false;
            if (!IsPostBack)
            {
                Button3.Enabled = false;
                FillInvestigation();
                ViewGrid();
            }
        }
        void ViewGrid()
        {
            SqlDataAdapter adapter = null;
            if (EditList.SelectedValue == "")
            {
                adapter = new SqlDataAdapter("exec usp_ShowGrid 0", conn);
            }
            else
            {
                adapter = new SqlDataAdapter("exec usp_ShowGrid " + EditList.SelectedValue, conn);
            }
            DataTable dataTable = new DataTable();
            adapter.Fill(dataTable);
            GridView1.DataSource = dataTable;
            GridView1.DataBind();

        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblSerialNumber = (Label)e.Row.FindControl("lblSerialNumber");
                lblSerialNumber.Text = (e.Row.RowIndex + 1).ToString();
            }
        }
        void FillInvestigation()
        {
            conn.Open();
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("select * from Investigation",conn);
            DataTable dt = new DataTable();
            sqlDataAdapter.Fill(dt);
            DropDownList2.DataSource = dt;
            DropDownList2.DataTextField = "Investigation_Name";
            DropDownList2.DataValueField = "Investigation_Id";
            DropDownList2.DataBind();
            conn.Close();
        }
        protected void Add_Button(object sender, EventArgs e)
        {
            Clear_Button(sender, e);
            Button3.Enabled = true;
            TextBox1.Visible = true;
            conn.Open();
            SqlCommand cmd = new SqlCommand("select max(Bill_No) from HospitalBill", conn);
            SqlDataReader sqlData = cmd.ExecuteReader();
            if (sqlData.Read())
            {
                TextBox1.Text = (sqlData.GetInt32(0)+1).ToString();
            }
            else
            {
                TextBox1.Text = "1";
            }
            conn.Close();
        }

        protected void Save_Button(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand Insertcmd = new SqlCommand("usp_InsertBill", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                Insertcmd.Parameters.AddWithValue("@Bill_No", TextBox1.Text);
                Insertcmd.Parameters.AddWithValue("@Bill_Date", TextBox2.Text);
                Insertcmd.Parameters.AddWithValue("@PatientName", TextBox3.Text);
                Insertcmd.Parameters.AddWithValue("@Gender",DropDownList1.SelectedValue);
                Insertcmd.Parameters.AddWithValue("@DOB", TextBox4.Text);
                Insertcmd.Parameters.AddWithValue("@Address", TextArea1.Value);
                Insertcmd.Parameters.AddWithValue("@Email_Id", TextBox5.Text);
                Insertcmd.Parameters.AddWithValue("@Mobile_No", TextBox6.Text);
                Insertcmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Inserted Data SuccessFully');", true);
                
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }

        }

        protected void Edit_Button(object sender, EventArgs e)
        {
            TextBox1.Visible= false;
            EditList.Visible= true;
            Button3.Enabled= true;
            conn.Open();
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("select * from HospitalBill", conn);
            DataTable dt = new DataTable();
            sqlDataAdapter.Fill(dt);
            EditList.DataSource = dt;
            EditList.DataTextField = "Bill_No";
            EditList.DataValueField = "Bill_No";
            EditList.DataBind();
            ViewGrid();
            conn.Close();
        }

        protected void Grid_Button(object sender, EventArgs e)
        {
            EditList.Visible = true;
            conn.Open();
            SqlCommand Insertcmd = new SqlCommand("usp_Inserting_Into_Grid", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            if (DropDownList2.SelectedValue != "1") 
            {
                Insertcmd.Parameters.AddWithValue("@Bill_No", EditList.SelectedValue);
                Insertcmd.Parameters.AddWithValue("@Investigation_Id", DropDownList2.SelectedValue);
                Insertcmd.ExecuteNonQuery();
            }
            ViewGrid() ;
            conn.Close();

        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            EditList.Visible = true;
            TextBox1.Visible = false;
            conn.Open();
            SqlCommand cmd = new SqlCommand("select Fee from Investigation where Investigation_Id=" + DropDownList2.SelectedValue, conn);
            SqlDataReader sqlData = cmd.ExecuteReader();
            if (sqlData.Read())
            {
                TextBox7.Text = sqlData.GetDecimal(0).ToString();
            }
            
            conn.Close();
        }

        protected void EditList_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand FillDetail = new SqlCommand("select * from HospitalBill where Bill_No='"+EditList.SelectedValue+"'", conn);
                SqlDataReader reader = FillDetail.ExecuteReader();
                if(reader.Read())
                {
                    EditList.Visible = true;
                    TextBox1.Text = reader["Bill_No"].ToString();
                    TextBox2.Text = Convert.ToDateTime(reader["Bill_Date"]).ToString("yyyy-MM-dd");
                    TextBox3.Text = reader["Patient_Name"].ToString() ;
                    DropDownList1.SelectedValue = reader["Gender"].ToString();
                    TextBox4.Text = Convert.ToDateTime(reader["DOB"]).ToString("yyyy-MM-dd");
                    TextArea1.Value = reader["Address"].ToString();
                    TextBox5.Text = reader["Email_Id"].ToString();
                    TextBox6.Text = reader["Mobile_No"].ToString();
                }
                reader.Close();
                ViewGrid();
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        protected void Clear_Button(object sender, EventArgs e)
        {
            TextBox1.Text = TextBox2.Text = TextBox3.Text = TextBox4.Text = TextBox5.Text = TextBox6.Text= TextBox7.Text= "";
            DropDownList1.SelectedValue= "";
            TextArea1.Value = "";
            FillInvestigation();
            Button3.Enabled = false;
            EditList.Visible = false;
            TextBox1.Visible = true;

        }
    }
}