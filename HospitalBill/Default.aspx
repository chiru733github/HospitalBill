<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HospitalBill._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <div class="row">
            <section class="col" aria-labelledby="hostingTitle">
                <p style="text-align:center; color:dodgerblue; text-decoration:underline; font-size:24px;">
                        Hospital Bill
                </p>
                <div style="display:flex; align-content:center; justify-content:space-between;margin-left:150px;">
                    <div class="form">
                         <asp:Label ID="Label1" runat="server" ForeColor="#CC0066" Text="Bill Number"></asp:Label>
                         <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                         <asp:DropDownList ID="EditList" runat="server" AutoPostBack="true" Width="150px" OnSelectedIndexChanged="EditList_SelectedIndexChanged">
                         </asp:DropDownList>
                    </div>
                    <div class="form">
                         <asp:Label ID="Label2" runat="server" ForeColor="#CC0066" Text="Bill Date"></asp:Label>
                        <asp:TextBox ID="TextBox2" runat="server" type="date"></asp:TextBox>
                    </div>
                </div>
                
                <div style="display:flex;align-content:center; justify-content:space-between;margin-left:150px; margin-top:10px">
                    <div class="form">
                        <asp:Label ID="Label3" runat="server" ForeColor="#CC0066" Text="PatientName"></asp:Label>
                        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    </div>
                    <div class="form">
                         <asp:Label ID="Label4" runat="server" ForeColor="#CC0066" Text="Gender"></asp:Label>
                         <asp:DropDownList ID="DropDownList1" runat="server">
                             <asp:ListItem></asp:ListItem>
                             <asp:ListItem>Male</asp:ListItem>
                             <asp:ListItem>Female</asp:ListItem>
                         </asp:DropDownList>
                    </div>
                    <div class="form">
                        <asp:Label ID="Label5" runat="server" ForeColor="#CC0066" Text="Date of birth"></asp:Label>
                        <asp:TextBox ID="TextBox4" type="date" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div style="display:flex;align-content:center; justify-content:space-between;margin-left:150px;margin-top:10px;">
                    <div class="form">
                         <asp:Label ID="Label6" runat="server" ForeColor="#CC0066" Text="Address"></asp:Label>
                         <textarea id="TextArea1" runat="server" cols="20" name="S1" rows="2"></textarea>
                    </div>
                    <div class="form">
                          <asp:Label ID="Label7" runat="server" ForeColor="#CC0066" Text="Email Id"></asp:Label>
                          <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    </div>
                    <div class="form">
                        <asp:Label ID="Label8" runat="server" ForeColor="#CC0066" Text="Phone Number"></asp:Label>
                        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div style="justify-content:space-between; align-items:center; margin-left:150px;display:flex; margin-top:10px;">
                    <div class="form">
                         <asp:Label ID="Label9" runat="server" ForeColor="#CC0066" Text="Investigation"></asp:Label>
                         <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                         </asp:DropDownList>
                    </div>
                    <div class="form">
                         <asp:Label ID="Label10" runat="server" ForeColor="#CC0066" Text="Fee"></asp:Label>
                         <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                    </div>
                         <asp:Button ID="Button5" runat="server" OnClick="Grid_Button" Text="Add to Grid" />
                </div>
                <p>
                        <asp:GridView ID="GridView1" runat="server" Width="1088px" CellPadding="3" HorizontalAlign="Center" ShowHeaderWhenEmpty="True" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2">
                            <Columns>
                                <asp:TemplateField HeaderText="SNo">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSerialNumber" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Investigation_Name" HeaderText="Investigation Name" />
                                <asp:BoundField DataField="Fee" HeaderText="Fees" />
                                <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" />
                        </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FFF1D4" />
                            <SortedAscendingHeaderStyle BackColor="#B95C30" />
                            <SortedDescendingCellStyle BackColor="#F1E5CE" />
                            <SortedDescendingHeaderStyle BackColor="#93451F" />
                        </asp:GridView>
                        </p>
                <p>
                        &nbsp;</p>
            </section>
        </div>
    </main>

    <asp:Button ID="Button1" runat="server" Text="Add" OnClick="Add_Button" />
    <asp:Button ID="Button2" runat="server" Text="Edit" OnClick="Edit_Button" />
    <asp:Button ID="Button3" runat="server" Text="Save" Onclick="Save_Button" />
    <asp:Button ID="Button4" runat="server" Text="Clear" OnClick="Clear_Button" />


    
    


</asp:Content>


