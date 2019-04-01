######################################################################################################
##  Author Udishman Mudiar (Udish)                                                                  ##
##  version: 1.0                                                                                    ##
##  The script has to be run with an Administrator priviledge or else it will fail                  ##
##  The SCOM installation files has to be copied to a location in the machine                       ##
##  The pre-requisites softwares are also need to be copied if SCOM console needs to be installed   ##
##                                                                                                  ##
##                                                                                                  ##  
######################################################################################################

#region Time Stamp
Function LogTime(){
    Get-Date -Format 'dd/MM/yy hh:mm:ss'
 } 
#endregion

#region Initial Declaration
Write-Host "$(logtime) `t  Script Starting.." -ForegroundColor Magenta
$ErrorActionPreference= 'silentlycontinue'
$global:domain=(Get-WmiObject Win32_ComputerSystem).Domain
$global:domainsuffix=$domain.split('.')[0]
#endregion

#region Sleep
Function Sleep($b){
    Start-Sleep -Seconds $b
}
#endregion

#region Template Primay MS selection window
#Creating an user window
Function TemplatePrimary{
    $a = new-object -comobject wscript.shell 
    $ConsoleAnswer = $a.popup("Do you want to use Default Template?",0,"Choose Template?",4)

    if($ConsoleAnswer -eq 6)
    {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $Form = New-Object system.Windows.Forms.Form
        $Form.Text = "Default Template Selection"
        $Label = New-Object System.Windows.Forms.Label
        #$Label.Text = "This form is very simple."
        $form.Size = New-Object System.Drawing.Size(500,300)
        $form.StartPosition = 'CenterScreen'
        $Form.Controls.Add($Label)

        $OKButton = New-Object System.Windows.Forms.Button
        #$OKButton.Location = New-Object System.Drawing.Point(75,120)
        $OKButton.Location = New-Object System.Drawing.Point(160,150)
        $OKButton.Size = New-Object System.Drawing.Size(75,23)
        $OKButton.Text = 'OK'
        $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $OKButton
        $form.Controls.Add($OKButton)

        $CancelButton = New-Object System.Windows.Forms.Button
        #$CancelButton.Location = New-Object System.Drawing.Point(150,120)
        $CancelButton.Location = New-Object System.Drawing.Point(260,150)
        $CancelButton.Size = New-Object System.Drawing.Size(75,23)
        $CancelButton.Text = 'Cancel'
        $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $CancelButton
        $form.Controls.Add($CancelButton)


        #Adding template drop down
        $DropDownArray = "2012R2_Template","2016_Template","1801_Template","1807_Template","2019_Template"
        $DropDown = New-object System.Windows.Forms.ComboBox
        $DropDown.Location = New-object System.Drawing.Size(140,40)
        $DropDown.Size = New-object System.Drawing.Size(200,20)

        ForEach ($Item in $DropDownArray) {
   
	    $DropDown.Items.Add($Item) | Out-Null
    }
  
        $Form.Controls.Add($DropDown)
        $result = $form.ShowDialog()    
        $templatename = $DropDown.Text
    
        If($templatename -eq "2012R2_Template")
                                                                                                        {
        $global:T_adusers = "2012R2-scomsvc-ms,2012R2-scomsvc-das,2012R2-scomsvc-rdr,2012R2-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM2012R2_MG"
        $global:T_OpsDBSQL="SQL2012"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager2012R2"
        $global:T_OpsDWSQL="SQL2012"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW2012R2"
        $global:T_MSACC="$domainsuffix\2012R2-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\2012R2-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\2012R2-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\2012R2-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:group="OM2012R2Admins"
        $global:T_installationpath="C:\SC 2012 RTM SCOM"
        $global:T_PreReqPath="C:\Software" 
    }
        If($templatename -eq "2016_Template")
                                                                                                        {
        $global:T_adusers = "2016-scomsvc-ms,2016-scomsvc-das,2016-scomsvc-rdr,2016-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM2016_MG"
        $global:T_OpsDBSQL="SQL2016"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager2016"
        $global:T_OpsDWSQL="SQL2016"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW2016"
        $global:T_MSACC="$domainsuffix\2016-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\2016-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\2016-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\2016-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1"  
        $global:group="OM2016Admins" 
        $global:T_installationpath="C:\SC 2016 RTM SCOM"
        $global:T_PreReqPath="C:\Software"    
    }
        If($templatename -eq "1801_Template")
                                                                                                        {
        $global:T_adusers = "1801-scomsvc-ms,1801-scomsvc-das,1801-scomsvc-rdr,1801-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM1801_MG"
        $global:T_OpsDBSQL="SQL2016"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager1801"
        $global:T_OpsDWSQL="SQL2016"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW1801"
        $global:T_MSACC="$domainsuffix\1801-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\1801-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\1801-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\1801-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:group="OM1801Admins"
        $global:T_installationpath="C:\System Center Operations Manager"
        $global:T_PreReqPath="C:\Software"     
             
    }
        If($templatename -eq "1807_Template")
                                                                                                        {
        $global:T_adusers = "1807-scomsvc-ms,1807-scomsvc-das,1807-scomsvc-rdr,1807-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM1807_MG"
        $global:T_OpsDBSQL="SQL2016"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager1807"
        $global:T_OpsDWSQL="SQL2016"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW1807"
        $global:T_MSACC="$domainsuffix\1807-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\1807-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\1807-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\1807-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1"
        $global:group="OM1807Admins"
        $global:T_installationpath="C:\System Center Operations Manager"
        $global:T_PreReqPath="C:\Software"     
    }
        If($templatename -eq "2019_Template")
                                                                                                        {
        $global:T_adusers = "2019-scomsvc-ms,2019-scomsvc-das,2019-scomsvc-rdr,2019-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM2019_MG"
        $global:T_OpsDBSQL="SQL2017"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager2019"
        $global:T_OpsDWSQL="SQL2017"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW2019"
        $global:T_MSACC="$domainsuffix\2019-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\2019-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\2019-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\2019-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1"
        $global:group="OM2019Admins"
        $global:T_installationpath="C:\System Center Operations Manager 2019"
        $global:T_PreReqPath="C:\Software"     
    }
     
        #$T_adusers
    
        #Form($T_adusers,$T_password,$T_domain,$T_MGName,$T_OpsDBSQL,$T_OpsDBPort,$T_OpsDBName,$T_OpsDWSQL,$T_OpsDWPort,$T_OpsDWName,$T_MSACC,$T_MSACCPassword,$T_DASACC,$T_DASACCPassword,$T_RDRACC,$T_RDRPassword,$T_WTRACC,$T_WTRPassword,$T_EnableErrorReporting,$T_SendCEIPReports,$T_UseMicrosoftUpdate,$T_AcceptLicense)      
        FormPrimaryMS
    }
    elseif ($ConsoleAnswer -eq 7)
    {
        FormCustomPrimaryMS
    }
}
#endregion

#region Template Addtional MS selection window
#Creating an user window
Function TemplateAdditional{
    $a = new-object -comobject wscript.shell 
    $ConsoleAnswer = $a.popup("Do you want to use Default Template?",0,"Choose Template?",4)

    if($ConsoleAnswer -eq 6)
    {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $Form = New-Object system.Windows.Forms.Form
        $Form.Text = "Default Template Selection"
        $Label = New-Object System.Windows.Forms.Label
        #$Label.Text = "This form is very simple."
        $form.Size = New-Object System.Drawing.Size(500,300)
        $form.StartPosition = 'CenterScreen'
        $Form.Controls.Add($Label)

        $OKButton = New-Object System.Windows.Forms.Button
        #$OKButton.Location = New-Object System.Drawing.Point(75,120)
        $OKButton.Location = New-Object System.Drawing.Point(160,150)
        $OKButton.Size = New-Object System.Drawing.Size(75,23)
        $OKButton.Text = 'OK'
        $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $OKButton
        $form.Controls.Add($OKButton)

        $CancelButton = New-Object System.Windows.Forms.Button
        #$CancelButton.Location = New-Object System.Drawing.Point(150,120)
        $CancelButton.Location = New-Object System.Drawing.Point(260,150)
        $CancelButton.Size = New-Object System.Drawing.Size(75,23)
        $CancelButton.Text = 'Cancel'
        $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $CancelButton
        $form.Controls.Add($CancelButton)


        #Adding template drop down
        $DropDownArray = "2012R2_Template","2016_Template","1801_Template","1807_Template","2019_Template"
        $DropDown = New-object System.Windows.Forms.ComboBox
        $DropDown.Location = New-object System.Drawing.Size(140,40)
        $DropDown.Size = New-object System.Drawing.Size(200,20)

       ForEach ($Item in $DropDownArray) {
   
	    $DropDown.Items.Add($Item) | Out-Null
    }
  
        $Form.Controls.Add($DropDown)
        $result = $form.ShowDialog()    
        $templatename = $DropDown.Text
    
        If($templatename -eq "2012R2_Template")
                                                                                                        {
        $global:T_adusers = "2012R2-scomsvc-ms,2012R2-scomsvc-das,2012R2-scomsvc-rdr,2012R2-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM2012R2_MG"
        $global:T_OpsDBSQL="SQL2012"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager2012R2"
        $global:T_OpsDWSQL="SQL2012"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW2012R2"
        $global:T_MSACC="$domainsuffix\2012R2-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\2012R2-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\2012R2-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\2012R2-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:group="OM2012R2Admins"   
    }
        If($templatename -eq "2016_Template")
                                                                                                        {
        $global:T_adusers = "2016-scomsvc-ms,2016-scomsvc-das,2016-scomsvc-rdr,2016-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM2016_MG"
        $global:T_OpsDBSQL="SQL2016"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager2016"
        $global:T_OpsDWSQL="SQL2016"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW2016"
        $global:T_MSACC="$domainsuffix\2016-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\2016-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\2016-scomsvc-ms"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\2016-scomsvc-ms"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1"  
        $global:group="OM2016Admins"     
    }
        If($templatename -eq "1801_Template")
                                                                                                        {
        $global:T_adusers = "1801-scomsvc-ms,1801-scomsvc-das,1801-scomsvc-rdr,1801-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM1801_MG"
        $global:T_OpsDBSQL="SQL2016"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager1801"
        $global:T_OpsDWSQL="SQL2016"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW1801"
        $global:T_MSACC="$domainsuffix\1801-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\1801-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\1801-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\1801-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:group="OM1801Admins"     
    }
        If($templatename -eq "1807_Template")
                                                                                                        {
        $global:T_adusers = "1807-scomsvc-ms,1807-scomsvc-das,1807-scomsvc-rdr,1807-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM1807_MG"
        $global:T_OpsDBSQL="SQL2016"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager1807"
        $global:T_OpsDWSQL="SQL2016"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW1807"
        $global:T_MSACC="$domainsuffix\1807-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\1807-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\1807-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\1807-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1"
        $global:group="OM1807Admins"       
    }
        If($templatename -eq "2019_Template")
                                                                                                        {
        $global:T_adusers = "2019-scomsvc-ms,2019-scomsvc-das,2019-scomsvc-rdr,2019-scomsvc-wtr"
        $global:T_password = "P@ssw0rd"
        $global:T_domain=$domain
        $global:T_MGName="SCOM2019_MG"
        $global:T_OpsDBSQL="SQL2017"
        $global:T_OpsDBPort="1433"
        $global:T_OpsDBName="OperationsManager2019"
        $global:T_OpsDWSQL="SQL2017"
        $global:T_OpsDWPort="1433"
        $global:T_OpsDWName="OperationsManagerDW2019"
        $global:T_MSACC="$domainsuffix\2019-scomsvc-ms"
        $global:T_MSACCPassword="P@ssw0rd"
        $global:T_DASACC="$domainsuffix\2019-scomsvc-das"
        $global:T_DASACCPassword="P@ssw0rd"
        $global:T_RDRACC="$domainsuffix\2019-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_WTRACC="$domainsuffix\2019-scomsvc-wtr"
        $global:T_WTRPassword="P@ssw0rd"
        $global:T_EnableErrorReporting="Never"
        $global:T_SendCEIPReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1"
        $global:group="OM2019Admins"      
    }
     
        #$T_adusers
    
        #Form($T_adusers,$T_password,$T_domain,$T_MGName,$T_OpsDBSQL,$T_OpsDBPort,$T_OpsDBName,$T_OpsDWSQL,$T_OpsDWPort,$T_OpsDWName,$T_MSACC,$T_MSACCPassword,$T_DASACC,$T_DASACCPassword,$T_RDRACC,$T_RDRPassword,$T_WTRACC,$T_WTRPassword,$T_EnableErrorReporting,$T_SendCEIPReports,$T_UseMicrosoftUpdate,$T_AcceptLicense)      
        FormSecondaryMS
    }
    elseif ($ConsoleAnswer -eq 7)
    {
        FormCustomAdditionalMS
    }
}
#endregion

#region Default Primary MS Template form
Function FormPrimaryMS(){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. Primary Management Server'
$form.Size = New-Object System.Drawing.Size(1200,800)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,700)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,700)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'Enter the users to be created in AD with comma seperated'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'Enter the password. Same password will be set for all the users'
$form.Controls.Add($label2)


$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'Domain Name e.g: mydomain.com'
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'Management Group Name'
$form.Controls.Add($label4)

$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'SQL Server Name. eg: SQL2016\Instance,customport'
$form.Controls.Add($label5)


$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(850,100)
#This is adjust the length and height of the name of the label
$label6.Size = New-Object System.Drawing.Size(350,30)
$label6.Text = 'SqlInstancePort: <SQL instance port number>'
$form.Controls.Add($label6)



$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(20,180)
#This is adjust the length and height of the name of the label
$label7.Size = New-Object System.Drawing.Size(350,30)
$label7.Text = 'DatabaseName (Default: OperationsManager)'
$form.Controls.Add($label7)


$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(450,180)
#This is adjust the length and height of the name of the label
$label8.Size = New-Object System.Drawing.Size(350,30)
$label8.Text = 'DWSqlServerInstance: eg: SQL2016\Instance,customport)'
$form.Controls.Add($label8)


$label9 = New-Object System.Windows.Forms.Label
$label9.Location = New-Object System.Drawing.Point(850,180)
#This is adjust the length and height of the name of the label
$label9.Size = New-Object System.Drawing.Size(350,30)
$label9.Text = 'DWSqlInstancePort: <SQL instance port number>)'
$form.Controls.Add($label9)

$label10 = New-Object System.Windows.Forms.Label
$label10.Location = New-Object System.Drawing.Point(20,260)
#This is adjust the length and height of the name of the label
$label10.Size = New-Object System.Drawing.Size(350,30)
$label10.Text = 'DWDatabaseName: (Default: OperationsManagerDW)'
$form.Controls.Add($label10)

$label11 = New-Object System.Windows.Forms.Label
$label11.Location = New-Object System.Drawing.Point(450,260)
#This is adjust the length and height of the name of the label
$label11.Size = New-Object System.Drawing.Size(350,30)
$label11.Text = 'Management Server ActionAccount: <domain\username> '
$form.Controls.Add($label11)

$label12 = New-Object System.Windows.Forms.Label
$label12.Location = New-Object System.Drawing.Point(850,260)
#This is adjust the length and height of the name of the label
$label12.Size = New-Object System.Drawing.Size(350,30)
$label12.Text = 'Management Server ActionAccount Password '
$form.Controls.Add($label12)

$label13 = New-Object System.Windows.Forms.Label
$label13.Location = New-Object System.Drawing.Point(20,340)
#This is adjust the length and height of the name of the label
$label13.Size = New-Object System.Drawing.Size(350,30)
$label13.Text = 'DASActionAccountUser: <domain\username> '
$form.Controls.Add($label13)


$label14 = New-Object System.Windows.Forms.Label
$label14.Location = New-Object System.Drawing.Point(450,340)
#This is adjust the length and height of the name of the label
$label14.Size = New-Object System.Drawing.Size(350,30)
$label14.Text = 'DASActionAccountPassword'
$form.Controls.Add($label14)


$label15 = New-Object System.Windows.Forms.Label
$label15.Location = New-Object System.Drawing.Point(850,340)
#This is adjust the length and height of the name of the label
$label15.Size = New-Object System.Drawing.Size(350,30)
$label15.Text = 'DataReaderAction Account: <domain\username>'
$form.Controls.Add($label15)

$label16 = New-Object System.Windows.Forms.Label
$label16.Location = New-Object System.Drawing.Point(20,420)
#This is adjust the length and height of the name of the label
$label16.Size = New-Object System.Drawing.Size(350,30)
$label16.Text = 'DataReaderAction Account Password'
$form.Controls.Add($label16)

$label17 = New-Object System.Windows.Forms.Label
$label17.Location = New-Object System.Drawing.Point(450,420)
#This is adjust the length and height of the name of the label
$label17.Size = New-Object System.Drawing.Size(350,30)
$label17.Text = 'DataWriterAction Account: <domain\username>'
$form.Controls.Add($label17)

$label18 = New-Object System.Windows.Forms.Label
$label18.Location = New-Object System.Drawing.Point(850,420)
#This is adjust the length and height of the name of the label
$label18.Size = New-Object System.Drawing.Size(350,30)
$label18.Text = 'DataWriterAction Account Password'
$form.Controls.Add($label18)

$label19 = New-Object System.Windows.Forms.Label
$label19.Location = New-Object System.Drawing.Point(20,500)
#This is adjust the length and height of the name of the label
$label19.Size = New-Object System.Drawing.Size(350,30)
$label19.Text = 'EnableErrorReporting: [Never|Queued|Always]'
$form.Controls.Add($label19)

$label20 = New-Object System.Windows.Forms.Label
$label20.Location = New-Object System.Drawing.Point(450,500)
#This is adjust the length and height of the name of the label
$label20.Size = New-Object System.Drawing.Size(350,30)
$label20.Text = 'SendCEIPReports: [0|1]'
$form.Controls.Add($label20)

$label21 = New-Object System.Windows.Forms.Label
$label21.Location = New-Object System.Drawing.Point(850,500)
#This is adjust the length and height of the name of the label
$label21.Size = New-Object System.Drawing.Size(350,30)
$label21.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label21)

$label22 = New-Object System.Windows.Forms.Label
$label22.Location = New-Object System.Drawing.Point(20,580)
#This is adjust the length and height of the name of the label
$label22.Size = New-Object System.Drawing.Size(350,30)
$label22.Text = 'AcceptEndUserLicenseAgreement: [0|1]'
$form.Controls.Add($label22)

$label23 = New-Object System.Windows.Forms.Label
$label23.Location = New-Object System.Drawing.Point(450,580)
#This is adjust the length and height of the name of the label
$label23.Size = New-Object System.Drawing.Size(350,30)
$label23.Text = 'Installation Path e.g: C:\System Center Operations Manager 2019'
$form.Controls.Add($label23)

$label24 = New-Object System.Windows.Forms.Label
$label24.Location = New-Object System.Drawing.Point(850,580)
#This is adjust the length and height of the name of the label
$label24.Size = New-Object System.Drawing.Size(350,30)
$label24.Text = 'Pre-Req Software Path e.g: C:\Softwares'
$form.Controls.Add($label24)



$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$textBox1.Text=$T_adusers
$form.Controls.Add($textBox1)


$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$textBox2.Text=$T_password
$form.Controls.Add($textBox2)


$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$textBox3.Text=$T_domain
$form.Controls.Add($textBox3)


$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$textBox4.Text=$T_MGName
$form.Controls.Add($textBox4)

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$textBox5.Text=$T_OpsDBSQL
$form.Controls.Add($textBox5)


$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(850,130)
$textBox6.Size = New-Object System.Drawing.Size(280,20)
$textBox6.Text=$T_OpsDBPort
$form.Controls.Add($textBox6)



$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(20,210)
$textBox7.Size = New-Object System.Drawing.Size(280,20)
$textBox7.Text=$T_OpsDBName
$form.Controls.Add($textBox7)


$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(450,210)
$textBox8.Size = New-Object System.Drawing.Size(280,20)
$textBox8.Text=$T_OpsDWSQL
$form.Controls.Add($textBox8)

$textBox9 = New-Object System.Windows.Forms.TextBox
$textBox9.Location = New-Object System.Drawing.Point(850,210)
$textBox9.Size = New-Object System.Drawing.Size(280,20)
$textBox9.Text=$T_OpsDWPort
$form.Controls.Add($textBox9)


$textBox10 = New-Object System.Windows.Forms.TextBox
$textBox10.Location = New-Object System.Drawing.Point(20,290)
$textBox10.Size = New-Object System.Drawing.Size(280,20)
$textBox10.Text=$T_OpsDWName
$form.Controls.Add($textBox10)


$textBox11 = New-Object System.Windows.Forms.TextBox
$textBox11.Location = New-Object System.Drawing.Point(450,290)
$textBox11.Size = New-Object System.Drawing.Size(280,20)
$textBox11.Text=$T_MSACC
$form.Controls.Add($textBox11)


$textBox12 = New-Object System.Windows.Forms.TextBox
$textBox12.Location = New-Object System.Drawing.Point(850,290)
$textBox12.Size = New-Object System.Drawing.Size(280,20)
$textBox12.Text=$T_MSACCPassword
$form.Controls.Add($textBox12)


$textBox13 = New-Object System.Windows.Forms.TextBox
$textBox13.Location = New-Object System.Drawing.Point(20,370)
$textBox13.Size = New-Object System.Drawing.Size(280,20)
$textBox13.Text=$T_DASACC
$form.Controls.Add($textBox13)


$textBox14 = New-Object System.Windows.Forms.TextBox
$textBox14.Location = New-Object System.Drawing.Point(450,370)
$textBox14.Size = New-Object System.Drawing.Size(280,20)
$textBox14.Text=$T_DASACCPassword
$form.Controls.Add($textBox14)


$textBox15 = New-Object System.Windows.Forms.TextBox
$textBox15.Location = New-Object System.Drawing.Point(850,370)
$textBox15.Size = New-Object System.Drawing.Size(280,20)
$textBox15.Text=$T_RDRACC
$form.Controls.Add($textBox15)


$textBox16 = New-Object System.Windows.Forms.TextBox
$textBox16.Location = New-Object System.Drawing.Point(20,450)
$textBox16.Size = New-Object System.Drawing.Size(280,20)
$textBox16.Text=$T_RDRPassword
$form.Controls.Add($textBox16)


$textBox17 = New-Object System.Windows.Forms.TextBox
$textBox17.Location = New-Object System.Drawing.Point(450,450)
$textBox17.Size = New-Object System.Drawing.Size(280,20)
$textBox17.Text=$T_WTRACC
$form.Controls.Add($textBox17)


$textBox18 = New-Object System.Windows.Forms.TextBox
$textBox18.Location = New-Object System.Drawing.Point(850,450)
$textBox18.Size = New-Object System.Drawing.Size(280,20)
$textBox18.Text=$T_WTRPassword
$form.Controls.Add($textBox18)


$textBox19 = New-Object System.Windows.Forms.TextBox
$textBox19.Location = New-Object System.Drawing.Point(20,530)
$textBox19.Size = New-Object System.Drawing.Size(280,20)
$textBox19.Text=$T_EnableErrorReporting
$form.Controls.Add($textBox19)

$textBox20 = New-Object System.Windows.Forms.TextBox
$textBox20.Location = New-Object System.Drawing.Point(450,530)
$textBox20.Size = New-Object System.Drawing.Size(280,20)
$textBox20.Text=$T_SendCEIPReports
$form.Controls.Add($textBox20)

$textBox21 = New-Object System.Windows.Forms.TextBox
$textBox21.Location = New-Object System.Drawing.Point(850,530)
$textBox21.Size = New-Object System.Drawing.Size(280,20)
$textBox21.Text=$T_UseMicrosoftUpdate
$form.Controls.Add($textBox21)

$textBox22 = New-Object System.Windows.Forms.TextBox
$textBox22.Location = New-Object System.Drawing.Point(20,610)
$textBox22.Size = New-Object System.Drawing.Size(280,20)
$textBox22.Text=$T_AcceptLicense
$form.Controls.Add($textBox22)

$textBox23 = New-Object System.Windows.Forms.TextBox
$textBox23.Location = New-Object System.Drawing.Point(450,610)
$textBox23.Size = New-Object System.Drawing.Size(280,20)
$textBox23.Text=$T_InstallationPath
$form.Controls.Add($textBox23)

$textBox24 = New-Object System.Windows.Forms.TextBox
$textBox24.Location = New-Object System.Drawing.Point(850,610)
$textBox24.Size = New-Object System.Drawing.Size(280,20)
$textBox24.Text=$T_PreReqPath
$form.Controls.Add($textBox24)


$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $global:adusers = $textBox1.Text
    $global:password = $textBox2.Text
    #$global:domain=$textBox3.Text
    $global:MGName=$textBox4.Text
    $global:OpsDBSQL=$textBox5.Text
    $global:OpsDBPort=$textBox6.Text
    $global:OpsDBName=$textBox7.Text
    $global:OpsDWSQL=$textBox8.Text
    $global:OpsDWPort=$textBox9.Text
    $global:OpsDWName=$textBox10.Text
    $global:MSACC=$textBox11.Text
    $global:MSACCPassword=$textBox12.Text
    $global:DASACC=$textBox13.Text
    $global:DASACCPassword=$textBox14.Text
    $global:RDRACC=$textBox15.Text
    $global:RDRPassword=$textBox16.Text
    $global:WTRACC=$textBox17.Text
    $global:WTRPassword=$textBox18.Text
    $global:EnableErrorReporting=$textBox19.Text
    $global:SendCEIPReports=$textBox20.Text
    $global:UseMicrosoftUpdate=$textBox21.Text
    $global:AcceptLicense=$textBox22.Text
    $global:InstallationPath=$textBox23.Text
    $global:PreReqPath=$textBox24.Text


Write-Host "   adusers:"   $adusers
Write-Host "    password:"    $password
Write-Host "    domain:"    $domain
Write-Host "    MGName:"    $MGName
Write-Host "    OpsDBSQL:"    $OpsDBSQL
Write-Host "    OpsDBPort:"    $OpsDBPort
Write-Host "    OpsDBName:"    $OpsDBName
Write-Host "    OpsDWSQL:"    $OpsDWSQL
Write-Host "    OpsDWPort:"    $OpsDWPort
Write-Host "    OpsDWName:"    $OpsDWName
Write-Host "    MSACC:"    $MSACC
Write-Host "    MSACCPassword:"    $MSACCPassword
Write-Host "    DASACC:"    $DASACC
Write-Host "    DASACCPassword:"    $DASACCPassword
Write-Host "    RDRACC:"    $RDRACC
Write-Host "    RDRPassword:"    $RDRPassword
Write-Host "    WTRACC:"    $WTRACC
Write-Host "    WTRPassword:"    $WTRPassword
Write-Host "    EnableErrorReporting:"    $EnableErrorReporting
Write-Host "    SendCEIPReports:"    $SendCEIPReports
Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
Write-Host "    AcceptLicense:"    $AcceptLicense
Write-Host "    InstallationPath:"    $InstallationPath
Write-Host "    PreReqPath:"    $PreReqPath

$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Default Secondary MS Template form
Function FormSecondaryMS(){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. Secondary Management Server'
$form.Size = New-Object System.Drawing.Size(1200,430)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,340)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,340)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)


$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'SQL Server Name. eg: SQL2016\Instance,customport'
$form.Controls.Add($label1)


$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'SqlInstancePort: <SQL instance port number>'
$form.Controls.Add($label2)



$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'DatabaseName (Default: OperationsManager)'
$form.Controls.Add($label3)



$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'Management Server ActionAccount: <domain\username> '
$form.Controls.Add($label4)

$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'Management Server ActionAccount Password '
$form.Controls.Add($label5)

$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(850,100)
#This is adjust the length and height of the name of the label
$label6.Size = New-Object System.Drawing.Size(350,30)
$label6.Text = 'DASActionAccountUser: <domain\username> '
$form.Controls.Add($label6)


$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(20,180)
#This is adjust the length and height of the name of the label
$label7.Size = New-Object System.Drawing.Size(350,30)
$label7.Text = 'DASActionAccountPassword'
$form.Controls.Add($label7)


$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(450,180)
#This is adjust the length and height of the name of the label
$label8.Size = New-Object System.Drawing.Size(350,30)
$label8.Text = 'EnableErrorReporting: [Never|Queued|Always]'
$form.Controls.Add($label8)

$label9 = New-Object System.Windows.Forms.Label
$label9.Location = New-Object System.Drawing.Point(850,180)
#This is adjust the length and height of the name of the label
$label9.Size = New-Object System.Drawing.Size(350,30)
$label9.Text = 'SendCEIPReports: [0|1]'
$form.Controls.Add($label9)

$label10 = New-Object System.Windows.Forms.Label
$label10.Location = New-Object System.Drawing.Point(20,260)
#This is adjust the length and height of the name of the label
$label10.Size = New-Object System.Drawing.Size(350,30)
$label10.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label10)

$label11 = New-Object System.Windows.Forms.Label
$label11.Location = New-Object System.Drawing.Point(450,260)
#This is adjust the length and height of the name of the label
$label11.Size = New-Object System.Drawing.Size(350,30)
$label11.Text = 'AcceptEndUserLicenseAgreement: [0|1]'
$form.Controls.Add($label11)


$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$textBox1.Text=$T_OpsDBSQL
$form.Controls.Add($textBox1)


$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$textBox2.Text=$T_OpsDBPort
$form.Controls.Add($textBox2)



$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$textBox3.Text=$T_OpsDBName
$form.Controls.Add($textBox3)


$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$textBox4.Text=$T_MSACC
$form.Controls.Add($textBox4)


$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$textBox5.Text=$T_MSACCPassword
$form.Controls.Add($textBox5)


$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(850,130)
$textBox6.Size = New-Object System.Drawing.Size(280,20)
$textBox6.Text=$T_DASACC
$form.Controls.Add($textBox6)


$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(20,210)
$textBox7.Size = New-Object System.Drawing.Size(280,20)
$textBox7.Text=$T_DASACCPassword
$form.Controls.Add($textBox7)


$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(450,210)
$textBox8.Size = New-Object System.Drawing.Size(280,20)
$textBox8.Text=$T_EnableErrorReporting
$form.Controls.Add($textBox8)


$textBox9 = New-Object System.Windows.Forms.TextBox
$textBox9.Location = New-Object System.Drawing.Point(850,210)
$textBox9.Size = New-Object System.Drawing.Size(280,20)
$textBox9.Text=$T_SendCEIPReports
$form.Controls.Add($textBox9)

$textBox10 = New-Object System.Windows.Forms.TextBox
$textBox10.Location = New-Object System.Drawing.Point(20,290)
$textBox10.Size = New-Object System.Drawing.Size(280,20)
$textBox10.Text=$T_UseMicrosoftUpdate
$form.Controls.Add($textBox10)

$textBox11 = New-Object System.Windows.Forms.TextBox
$textBox11.Location = New-Object System.Drawing.Point(450,290)
$textBox11.Size = New-Object System.Drawing.Size(280,20)
$textBox11.Text=$T_AcceptLicense
$form.Controls.Add($textBox11)


$form.Topmost = $true

#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $global:OpsDBSQL = $textBox1.Text
    $global:OpsDBPort = $textBox2.Text
    $global:OpsDBName=$textBox3.Text
    $global:MSACC=$textBox4.Text
    $global:MSACCPassword=$textBox5.Text
    $global:DASACC=$textBox6.Text
    $global:DASACCPassword=$textBox7.Text
    $global:EnableErrorReporting=$textBox8.Text
    $global:SendCEIPReports=$textBox9.Text
    $global:UseMicrosoftUpdate=$textBox10.Text
    $global:AcceptLicense=$textBox11.Text
   


Write-Host "    OpsDBSQL:"    $OpsDBSQL
Write-Host "    OpsDBPort:"    $OpsDBPort
Write-Host "    OpsDBName:"    $OpsDBName
Write-Host "    MSACC:"    $MSACC
Write-Host "    MSACCPassword:"    $MSACCPassword
Write-Host "    DASACC:"    $DASACC
Write-Host "    DASACCPassword:"    $DASACCPassword
Write-Host "    EnableErrorReporting:"    $EnableErrorReporting
Write-Host "    SendCEIPReports:"    $SendCEIPReports
Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
Write-Host "    AcceptLicense:"    $AcceptLicense


$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t  Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Custom Primary MS Template form
Function  FormCustomPrimaryMS (){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. Primary MS Custom Form'
$form.Size = New-Object System.Drawing.Size(1200,800)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,700)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,700)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'Enter the users to be created in AD with comma seperated'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'Enter the password. Same password will be set for all the users'
$form.Controls.Add($label2)


$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'Domain Name e.g: mydomain.com'
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'Management Group Name'
$form.Controls.Add($label4)

$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'SQL Server Name. eg: SQL2016\Instance,customport'
$form.Controls.Add($label5)


$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(850,100)
#This is adjust the length and height of the name of the label
$label6.Size = New-Object System.Drawing.Size(350,30)
$label6.Text = 'SqlInstancePort: <SQL instance port number>'
$form.Controls.Add($label6)



$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(20,180)
#This is adjust the length and height of the name of the label
$label7.Size = New-Object System.Drawing.Size(350,30)
$label7.Text = 'DatabaseName (Default: OperationsManager)'
$form.Controls.Add($label7)


$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(450,180)
#This is adjust the length and height of the name of the label
$label8.Size = New-Object System.Drawing.Size(350,30)
$label8.Text = 'DWSqlServerInstance: eg: SQL2016\Instance,customport)'
$form.Controls.Add($label8)


$label9 = New-Object System.Windows.Forms.Label
$label9.Location = New-Object System.Drawing.Point(850,180)
#This is adjust the length and height of the name of the label
$label9.Size = New-Object System.Drawing.Size(350,30)
$label9.Text = 'DWSqlInstancePort: <SQL instance port number>)'
$form.Controls.Add($label9)

$label10 = New-Object System.Windows.Forms.Label
$label10.Location = New-Object System.Drawing.Point(20,260)
#This is adjust the length and height of the name of the label
$label10.Size = New-Object System.Drawing.Size(350,30)
$label10.Text = 'DWDatabaseName: (Default: OperationsManagerDW)'
$form.Controls.Add($label10)

$label11 = New-Object System.Windows.Forms.Label
$label11.Location = New-Object System.Drawing.Point(450,260)
#This is adjust the length and height of the name of the label
$label11.Size = New-Object System.Drawing.Size(350,30)
$label11.Text = 'Management Server ActionAccount: <domain\username> '
$form.Controls.Add($label11)

$label12 = New-Object System.Windows.Forms.Label
$label12.Location = New-Object System.Drawing.Point(850,260)
#This is adjust the length and height of the name of the label
$label12.Size = New-Object System.Drawing.Size(350,30)
$label12.Text = 'Management Server ActionAccount Password '
$form.Controls.Add($label12)

$label13 = New-Object System.Windows.Forms.Label
$label13.Location = New-Object System.Drawing.Point(20,340)
#This is adjust the length and height of the name of the label
$label13.Size = New-Object System.Drawing.Size(350,30)
$label13.Text = 'DASActionAccountUser: <domain\username> '
$form.Controls.Add($label13)


$label14 = New-Object System.Windows.Forms.Label
$label14.Location = New-Object System.Drawing.Point(450,340)
#This is adjust the length and height of the name of the label
$label14.Size = New-Object System.Drawing.Size(350,30)
$label14.Text = 'DASActionAccountPassword'
$form.Controls.Add($label14)


$label15 = New-Object System.Windows.Forms.Label
$label15.Location = New-Object System.Drawing.Point(850,340)
#This is adjust the length and height of the name of the label
$label15.Size = New-Object System.Drawing.Size(350,30)
$label15.Text = 'DataReaderAction Account: <domain\username>'
$form.Controls.Add($label15)

$label16 = New-Object System.Windows.Forms.Label
$label16.Location = New-Object System.Drawing.Point(20,420)
#This is adjust the length and height of the name of the label
$label16.Size = New-Object System.Drawing.Size(350,30)
$label16.Text = 'DataReaderAction Account Password'
$form.Controls.Add($label16)

$label17 = New-Object System.Windows.Forms.Label
$label17.Location = New-Object System.Drawing.Point(450,420)
#This is adjust the length and height of the name of the label
$label17.Size = New-Object System.Drawing.Size(350,30)
$label17.Text = 'DataWriterAction Account: <domain\username>'
$form.Controls.Add($label17)

$label18 = New-Object System.Windows.Forms.Label
$label18.Location = New-Object System.Drawing.Point(850,420)
#This is adjust the length and height of the name of the label
$label18.Size = New-Object System.Drawing.Size(350,30)
$label18.Text = 'DataWriterAction Account Password'
$form.Controls.Add($label18)

$label19 = New-Object System.Windows.Forms.Label
$label19.Location = New-Object System.Drawing.Point(20,500)
#This is adjust the length and height of the name of the label
$label19.Size = New-Object System.Drawing.Size(350,30)
$label19.Text = 'EnableErrorReporting: [Never|Queued|Always]'
$form.Controls.Add($label19)

$label20 = New-Object System.Windows.Forms.Label
$label20.Location = New-Object System.Drawing.Point(450,500)
#This is adjust the length and height of the name of the label
$label20.Size = New-Object System.Drawing.Size(350,30)
$label20.Text = 'SendCEIPReports: [0|1]'
$form.Controls.Add($label20)

$label21 = New-Object System.Windows.Forms.Label
$label21.Location = New-Object System.Drawing.Point(850,500)
#This is adjust the length and height of the name of the label
$label21.Size = New-Object System.Drawing.Size(350,30)
$label21.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label21)

$label22 = New-Object System.Windows.Forms.Label
$label22.Location = New-Object System.Drawing.Point(20,580)
#This is adjust the length and height of the name of the label
$label22.Size = New-Object System.Drawing.Size(350,30)
$label22.Text = 'AcceptEndUserLicenseAgreement: [0|1]'
$form.Controls.Add($label22)

$label23 = New-Object System.Windows.Forms.Label
$label23.Location = New-Object System.Drawing.Point(450,580)
#This is adjust the length and height of the name of the label
$label23.Size = New-Object System.Drawing.Size(350,30)
$label23.Text = 'Installation Path e.g: C:\System Center Operations Manager 2019'
$form.Controls.Add($label23)

$label24 = New-Object System.Windows.Forms.Label
$label24.Location = New-Object System.Drawing.Point(850,580)
#This is adjust the length and height of the name of the label
$label24.Size = New-Object System.Drawing.Size(350,30)
$label24.Text = 'Pre-Req Software Path e.g: C:\Softwares'
$form.Controls.Add($label24)


$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox1)
$textbox1.AutoCompleteSource = 'CustomSource'
$textbox1.AutoCompleteMode='SuggestAppend'
$textbox1.AutoCompleteCustomSource=$autocomplete
"2019-scomsvc-ms,2019-scomsvc-das,2019-scomsvc-rdr,2019-scomsvc-wtr" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"1801-scomsvc-ms,1801-scomsvc-das,1801-scomsvc-rdr,1801-scomsvc-wtr" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"1807-scomsvc-ms,1807-scomsvc-das,1807-scomsvc-rdr,1807-scomsvc-wtr" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"2016-scomsvc-ms,2016-scomsvc-das,2016-scomsvc-rdr,2016-scomsvc-wtr" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"2012R2-scomsvc-ms,2012R2-scomsvc-das,2012R2-scomsvc-rdr,2012R2-scomsvc-wtr" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }

$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox2)
$textbox2.AutoCompleteSource = 'CustomSource'
$textbox2.AutoCompleteMode='SuggestAppend'
$textbox2.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox2.AutoCompleteCustomSource.AddRange($_) }

$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox3)
$textbox3.AutoCompleteSource = 'CustomSource'
$textbox3.AutoCompleteMode='SuggestAppend'
$textbox3.AutoCompleteCustomSource=$autocomplete
"$domainsuffix.lab" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }

$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox4)
$textbox4.AutoCompleteSource = 'CustomSource'
$textbox4.AutoCompleteMode='SuggestAppend'
$textbox4.AutoCompleteCustomSource=$autocomplete
"SCOM2019_MG" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }
"SCOM1801_MG" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }
"SCOM1807_MG" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }
"SCOM2016_MG" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }
"SCOM2012_MG" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox5)
$textbox5.AutoCompleteSource = 'CustomSource'
$textbox5.AutoCompleteMode='SuggestAppend'
$textbox5.AutoCompleteCustomSource=$autocomplete
"SQL" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }
"SQL2012" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }
"SQL2014" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }
"SQL2016" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }
"SQL2017" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }

$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(850,130)
$textBox6.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox6)
$textbox6.AutoCompleteSource = 'CustomSource'
$textbox6.AutoCompleteMode='SuggestAppend'
$textbox6.AutoCompleteCustomSource=$autocomplete
"1433" | % {$textbox6.AutoCompleteCustomSource.AddRange($_) }


$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(20,210)
$textBox7.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox7)
$textbox7.AutoCompleteSource = 'CustomSource'
$textbox7.AutoCompleteMode='SuggestAppend'
$textbox7.AutoCompleteCustomSource=$autocomplete
"OperationsManager" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2012" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2017" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager1801" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager1807" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2019" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }

$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(450,210)
$textBox8.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox8)
$textbox8.AutoCompleteSource = 'CustomSource'
$textbox8.AutoCompleteMode='SuggestAppend'
$textbox8.AutoCompleteCustomSource=$autocomplete
"SQL" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }
"SQL2012" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }
"SQL2014" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }
"SQL2016" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }
"SQL2017" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }

$textBox9 = New-Object System.Windows.Forms.TextBox
$textBox9.Location = New-Object System.Drawing.Point(850,210)
$textBox9.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox9)
$textbox9.AutoCompleteSource = 'CustomSource'
$textbox9.AutoCompleteMode='SuggestAppend'
$textbox9.AutoCompleteCustomSource=$autocomplete
"1433" | % {$textbox9.AutoCompleteCustomSource.AddRange($_) }

$textBox10 = New-Object System.Windows.Forms.TextBox
$textBox10.Location = New-Object System.Drawing.Point(20,290)
$textBox10.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox10)
$textbox10.AutoCompleteSource = 'CustomSource'
$textbox10.AutoCompleteMode='SuggestAppend'
$textbox10.AutoCompleteCustomSource=$autocomplete
"OperationsManagerDW" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2012DW" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2016DW" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager1801DW" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager1807DW" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2019DW" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }

$textBox11 = New-Object System.Windows.Forms.TextBox
$textBox11.Location = New-Object System.Drawing.Point(450,290)
$textBox11.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox11)
$textbox11.AutoCompleteSource = 'CustomSource'
$textbox11.AutoCompleteMode='SuggestAppend'
$textbox11.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-ms" | % {$textbox11.AutoCompleteCustomSource.AddRange($_) }

$textBox12 = New-Object System.Windows.Forms.TextBox
$textBox12.Location = New-Object System.Drawing.Point(850,290)
$textBox12.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox12)
$textbox12.AutoCompleteSource = 'CustomSource'
$textbox12.AutoCompleteMode='SuggestAppend'
$textbox12.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox12.AutoCompleteCustomSource.AddRange($_) }

$textBox13 = New-Object System.Windows.Forms.TextBox
$textBox13.Location = New-Object System.Drawing.Point(20,370)
$textBox13.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox13)
$textbox13.AutoCompleteSource = 'CustomSource'
$textbox13.AutoCompleteMode='SuggestAppend'
$textbox13.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-das" | % {$textbox13.AutoCompleteCustomSource.AddRange($_) }

$textBox14 = New-Object System.Windows.Forms.TextBox
$textBox14.Location = New-Object System.Drawing.Point(450,370)
$textBox14.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox14)
$textbox14.AutoCompleteSource = 'CustomSource'
$textbox14.AutoCompleteMode='SuggestAppend'
$textbox14.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox14.AutoCompleteCustomSource.AddRange($_) }

$textBox15 = New-Object System.Windows.Forms.TextBox
$textBox15.Location = New-Object System.Drawing.Point(850,370)
$textBox15.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox15)
$textbox15.AutoCompleteSource = 'CustomSource'
$textbox15.AutoCompleteMode='SuggestAppend'
$textbox15.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-rdr" | % {$textbox15.AutoCompleteCustomSource.AddRange($_) }

$textBox16 = New-Object System.Windows.Forms.TextBox
$textBox16.Location = New-Object System.Drawing.Point(20,450)
$textBox16.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox16)
$textbox16.AutoCompleteSource = 'CustomSource'
$textbox16.AutoCompleteMode='SuggestAppend'
$textbox16.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox16.AutoCompleteCustomSource.AddRange($_) }

$textBox17 = New-Object System.Windows.Forms.TextBox
$textBox17.Location = New-Object System.Drawing.Point(450,450)
$textBox17.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox17)
$textbox17.AutoCompleteSource = 'CustomSource'
$textbox17.AutoCompleteMode='SuggestAppend'
$textbox17.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-wtr" | % {$textbox17.AutoCompleteCustomSource.AddRange($_) }

$textBox18 = New-Object System.Windows.Forms.TextBox
$textBox18.Location = New-Object System.Drawing.Point(850,450)
$textBox18.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox18)
$textbox18.AutoCompleteSource = 'CustomSource'
$textbox18.AutoCompleteMode='SuggestAppend'
$textbox18.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox18.AutoCompleteCustomSource.AddRange($_) }

$textBox19 = New-Object System.Windows.Forms.TextBox
$textBox19.Location = New-Object System.Drawing.Point(20,530)
$textBox19.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox19)
$textbox19.AutoCompleteSource = 'CustomSource'
$textbox19.AutoCompleteMode='SuggestAppend'
$textbox19.AutoCompleteCustomSource=$autocomplete
"Never" | % {$textbox19.AutoCompleteCustomSource.AddRange($_) }
"Queued" | % {$textbox19.AutoCompleteCustomSource.AddRange($_) }
"Always" | % {$textbox19.AutoCompleteCustomSource.AddRange($_) }

$textBox20 = New-Object System.Windows.Forms.TextBox
$textBox20.Location = New-Object System.Drawing.Point(450,530)
$textBox20.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox20)
$textbox20.AutoCompleteSource = 'CustomSource'
$textbox20.AutoCompleteMode='SuggestAppend'
$textbox20.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox20.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox20.AutoCompleteCustomSource.AddRange($_) }

$textBox21 = New-Object System.Windows.Forms.TextBox
$textBox21.Location = New-Object System.Drawing.Point(850,530)
$textBox21.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox21)
$textbox21.AutoCompleteSource = 'CustomSource'
$textbox21.AutoCompleteMode='SuggestAppend'
$textbox21.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox21.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox21.AutoCompleteCustomSource.AddRange($_) }


$textBox22 = New-Object System.Windows.Forms.TextBox
$textBox22.Location = New-Object System.Drawing.Point(20,610)
$textBox22.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox22)
$textbox22.AutoCompleteSource = 'CustomSource'
$textbox22.AutoCompleteMode='SuggestAppend'
$textbox22.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox22.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox22.AutoCompleteCustomSource.AddRange($_) }

$textBox23 = New-Object System.Windows.Forms.TextBox
$textBox23.Location = New-Object System.Drawing.Point(450,610)
$textBox23.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox23)

$textBox24 = New-Object System.Windows.Forms.TextBox
$textBox24.Location = New-Object System.Drawing.Point(850,610)
$textBox24.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox24)

$form.Topmost = $true

#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $global:adusers = $textBox1.Text
    $global:password = $textBox2.Text
    $global:domain=$textBox3.Text
    $global:MGName=$textBox4.Text
    $global:OpsDBSQL=$textBox5.Text
    $global:OpsDBPort=$textBox6.Text
    $global:OpsDBName=$textBox7.Text
    $global:OpsDWSQL=$textBox8.Text
    $global:OpsDWPort=$textBox9.Text
    $global:OpsDWName=$textBox10.Text
    $global:MSACC=$textBox11.Text
    $global:MSACCPassword=$textBox12.Text
    $global:DASACC=$textBox13.Text
    $global:DASACCPassword=$textBox14.Text
    $global:RDRACC=$textBox15.Text
    $global:RDRPassword=$textBox16.Text
    $global:WTRACC=$textBox17.Text
    $global:WTRPassword=$textBox18.Text
    $global:EnableErrorReporting=$textBox19.Text
    $global:SendCEIPReports=$textBox20.Text
    $global:UseMicrosoftUpdate=$textBox21.Text
    $global:AcceptLicense=$textBox22.Text
    $global:InstallationPath=$textBox23.Text
    $global:PreReqPath=$textBox24.Text

Write-Host "   adusers:"   $adusers
Write-Host "    password:"    $password
Write-Host "    domain:"    $domain
Write-Host "    MGName:"    $MGName
Write-Host "    OpsDBSQL:"    $OpsDBSQL
Write-Host "    OpsDBPort:"    $OpsDBPort
Write-Host "    OpsDBName:"    $OpsDBName
Write-Host "    OpsDWSQL:"    $OpsDWSQL
Write-Host "    OpsDWPort:"    $OpsDWPort
Write-Host "    OpsDWName:"    $OpsDWName
Write-Host "    MSACC:"    $MSACC
Write-Host "    MSACCPassword:"    $MSACCPassword
Write-Host "    DASACC:"    $DASACC
Write-Host "    DASACCPassword:"    $DASACCPassword
Write-Host "    RDRACC:"    $RDRACC
Write-Host "    RDRPassword:"    $RDRPassword
Write-Host "    WTRACC:"    $WTRACC
Write-Host "    WTRPassword:"    $WTRPassword
Write-Host "    EnableErrorReporting:"    $EnableErrorReporting
Write-Host "    SendCEIPReports:"    $SendCEIPReports
Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
Write-Host "    AcceptLicense:"    $AcceptLicense
Write-Host "    InstallationPath:"    $InstallationPath
Write-Host "    PreReqPath:"    $PreReqPath

$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t  Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t  Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Custom Additional MS Template form
Function  FormCustomAdditionalMS (){

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form'
$form.Size = New-Object System.Drawing.Size(1200,430)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,340)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,340)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'SQL Server Name. eg: SQL2016\Instance,customport'
$form.Controls.Add($label1)


$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'SqlInstancePort: <SQL instance port number>'
$form.Controls.Add($label2)



$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'DatabaseName (Default: OperationsManager)'
$form.Controls.Add($label3)



$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'Management Server ActionAccount: <domain\username> '
$form.Controls.Add($label4)

$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'Management Server ActionAccount Password '
$form.Controls.Add($label5)

$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(850,100)
#This is adjust the length and height of the name of the label
$label6.Size = New-Object System.Drawing.Size(350,30)
$label6.Text = 'DASActionAccountUser: <domain\username> '
$form.Controls.Add($label6)


$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(20,180)
#This is adjust the length and height of the name of the label
$label7.Size = New-Object System.Drawing.Size(350,30)
$label7.Text = 'DASActionAccountPassword'
$form.Controls.Add($label7)


$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(450,180)
#This is adjust the length and height of the name of the label
$label8.Size = New-Object System.Drawing.Size(350,30)
$label8.Text = 'EnableErrorReporting: [Never|Queued|Always]'
$form.Controls.Add($label8)

$label9 = New-Object System.Windows.Forms.Label
$label9.Location = New-Object System.Drawing.Point(850,180)
#This is adjust the length and height of the name of the label
$label9.Size = New-Object System.Drawing.Size(350,30)
$label9.Text = 'SendCEIPReports: [0|1]'
$form.Controls.Add($label9)

$label10 = New-Object System.Windows.Forms.Label
$label10.Location = New-Object System.Drawing.Point(20,260)
#This is adjust the length and height of the name of the label
$label10.Size = New-Object System.Drawing.Size(350,30)
$label10.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label10)

$label11 = New-Object System.Windows.Forms.Label
$label11.Location = New-Object System.Drawing.Point(450,260)
#This is adjust the length and height of the name of the label
$label11.Size = New-Object System.Drawing.Size(350,30)
$label11.Text = 'AcceptEndUserLicenseAgreement: [0|1]'
$form.Controls.Add($label11)

$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox1)
$textbox1.AutoCompleteSource = 'CustomSource'
$textbox1.AutoCompleteMode='SuggestAppend'
$textbox1.AutoCompleteCustomSource=$autocomplete
"SQL" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SQL2012" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SQL2014" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SQL2016" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SQL2017" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }




$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox2)
$textbox2.AutoCompleteSource = 'CustomSource'
$textbox2.AutoCompleteMode='SuggestAppend'
$textbox2.AutoCompleteCustomSource=$autocomplete
"1433" | % {$textbox2.AutoCompleteCustomSource.AddRange($_) }



$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox3)
$textbox3.AutoCompleteSource = 'CustomSource'
$textbox3.AutoCompleteMode='SuggestAppend'
$textbox3.AutoCompleteCustomSource=$autocomplete
"OperationsManager" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2012" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2017" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager1801" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager1807" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }
"OperationsManager2019" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }


$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox4)
$textbox4.AutoCompleteSource = 'CustomSource'
$textbox4.AutoCompleteMode='SuggestAppend'
$textbox4.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-ms" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }


$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox5)
$textbox5.AutoCompleteSource = 'CustomSource'
$textbox5.AutoCompleteMode='SuggestAppend'
$textbox5.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }


$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(850,130)
$textBox6.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox6)
$textbox6.AutoCompleteSource = 'CustomSource'
$textbox6.AutoCompleteMode='SuggestAppend'
$textbox6.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-das" | % {$textbox6.AutoCompleteCustomSource.AddRange($_) }



$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(20,210)
$textBox7.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox7)
$textbox7.AutoCompleteSource = 'CustomSource'
$textbox7.AutoCompleteMode='SuggestAppend'
$textbox7.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }


$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(450,210)
$textBox8.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox8)
$textbox8.AutoCompleteSource = 'CustomSource'
$textbox8.AutoCompleteMode='SuggestAppend'
$textbox8.AutoCompleteCustomSource=$autocomplete
"Never" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }
"Queued" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }
"Always" | % {$textbox8.AutoCompleteCustomSource.AddRange($_) }



$textBox9 = New-Object System.Windows.Forms.TextBox
$textBox9.Location = New-Object System.Drawing.Point(850,210)
$textBox9.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox9)
$textbox9.AutoCompleteSource = 'CustomSource'
$textbox9.AutoCompleteMode='SuggestAppend'
$textbox9.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox9.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox9.AutoCompleteCustomSource.AddRange($_) }

$textBox10 = New-Object System.Windows.Forms.TextBox
$textBox10.Location = New-Object System.Drawing.Point(20,290)
$textBox10.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox10)
$textbox10.AutoCompleteSource = 'CustomSource'
$textbox10.AutoCompleteMode='SuggestAppend'
$textbox10.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox10.AutoCompleteCustomSource.AddRange($_) }

$textBox11 = New-Object System.Windows.Forms.TextBox
$textBox11.Location = New-Object System.Drawing.Point(450,290)
$textBox11.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox11)
$textbox11.AutoCompleteSource = 'CustomSource'
$textbox11.AutoCompleteMode='SuggestAppend'
$textbox11.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox11.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox11.AutoCompleteCustomSource.AddRange($_) }

$form.Topmost = $true

#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()


if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $global:OpsDBSQL = $textBox1.Text
    $global:OpsDBPort = $textBox2.Text
    $global:OpsDBName=$textBox3.Text
    $global:MSACC=$textBox4.Text
    $global:MSACCPassword=$textBox5.Text
    $global:DASACC=$textBox6.Text
    $global:DASACCPassword=$textBox7.Text
    $global:EnableErrorReporting=$textBox8.Text
    $global:SendCEIPReports=$textBox9.Text
    $global:UseMicrosoftUpdate=$textBox10.Text
    $global:AcceptLicense=$textBox11.Text
   


Write-Host "    OpsDBSQL:"    $OpsDBSQL
Write-Host "    OpsDBPort:"    $OpsDBPort
Write-Host "    OpsDBName:"    $OpsDBName
Write-Host "    MSACC:"    $MSACC
Write-Host "    MSACCPassword:"    $MSACCPassword
Write-Host "    DASACC:"    $DASACC
Write-Host "    DASACCPassword:"    $DASACCPassword
Write-Host "    EnableErrorReporting:"    $EnableErrorReporting
Write-Host "    SendCEIPReports:"    $SendCEIPReports
Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
Write-Host "    AcceptLicense:"    $AcceptLicense

$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Default Reporting Template form
Function DefaultFormReporting(){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. Reporting'
$form.Size = New-Object System.Drawing.Size(1200,400)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,310)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,310)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'Management Server Name'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'SSRS Instance Name <server\instance>'
$form.Controls.Add($label2)


$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'DataReaderAction Account: <domain\username>'
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'DataReaderAction Account Password'
$form.Controls.Add($label4)



$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'SendODRReports [0|1]'
$form.Controls.Add($label5)



$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(850,100)
#This is adjust the length and height of the name of the label
$label6.Size = New-Object System.Drawing.Size(350,30)
$label6.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label6)

$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(20,180)
#This is adjust the length and height of the name of the label
$label7.Size = New-Object System.Drawing.Size(350,30)
$label7.Text = 'AcceptEndUserLicenseAgreement: [0|1]'
$form.Controls.Add($label7)

$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(450,180)
#This is adjust the length and height of the name of the label
$label8.Size = New-Object System.Drawing.Size(350,30)
$label8.Text = 'Installation Path e.g: C:\System Center Operations Manager 2019'
$form.Controls.Add($label8)



$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$textBox1.Text=$T_ManagementServer
$form.Controls.Add($textBox1)


$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$textBox2.Text=$T_SRSInstance
$form.Controls.Add($textBox2)


$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$textBox3.Text=$T_RDRACC
$form.Controls.Add($textBox3)


$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$textBox4.Text=$T_RDRPassword
$form.Controls.Add($textBox4)

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$textBox5.Text=$T_SendODRReports
$form.Controls.Add($textBox5)


$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(850,130)
$textBox6.Size = New-Object System.Drawing.Size(280,20)
$textBox6.Text=$T_UseMicrosoftUpdate
$form.Controls.Add($textBox6)



$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(20,210)
$textBox7.Size = New-Object System.Drawing.Size(280,20)
$textBox7.Text=$T_AcceptLicense
$form.Controls.Add($textBox7)


$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(450,210)
$textBox8.Size = New-Object System.Drawing.Size(280,20)
$textBox8.Text=$T_installationpath
$form.Controls.Add($textBox8)

$form.Topmost = $true
$Form.Add_Shown({$Form.Activate()})
#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $global:ManagementServer = $textBox1.Text
    $global:SRSInstance = $textBox2.Text
    $global:RDRACC=$textBox3.Text
    $global:RDRPassword=$textBox4.Text
    $global:SendODRReports=$textBox5.Text
    $global:UseMicrosoftUpdate=$textBox6.Text
    $global:AcceptLicense=$textBox7.Text
    $global:installationpath=$textBox8.Text
   


Write-Host "    ManagementServer:"   $ManagementServer
Write-Host "    SRSInstance:"    $SRSInstance
Write-Host "    RDRACC:"    $RDRACC
Write-Host "    RDRPassword:"    $RDRPassword
Write-Host "    SendODRReports:"    $SendODRReports
Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
Write-Host "    AcceptLicense:"    $AcceptLicense
Write-Host "    installationpath:"    $installationpath



$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Template Reporting selection window
#Creating an user window
Function TemplateReporting{
    $a = new-object -comobject wscript.shell 
    $ConsoleAnswer = $a.popup("Do you want to use Default Reporting Template?",0,"Choose Template?",4)

    if($ConsoleAnswer -eq 6)
    {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $Form = New-Object system.Windows.Forms.Form
        $Form.Text = "Default Reporting Template Selection"
        $Label = New-Object System.Windows.Forms.Label
        #$Label.Text = "This form is very simple."
        $form.Size = New-Object System.Drawing.Size(500,300)
        $form.StartPosition = 'CenterScreen'
        $Form.Controls.Add($Label)

        $OKButton = New-Object System.Windows.Forms.Button
        #$OKButton.Location = New-Object System.Drawing.Point(75,120)
        $OKButton.Location = New-Object System.Drawing.Point(160,150)
        $OKButton.Size = New-Object System.Drawing.Size(75,23)
        $OKButton.Text = 'OK'
        $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $OKButton
        $form.Controls.Add($OKButton)

        $CancelButton = New-Object System.Windows.Forms.Button
        #$CancelButton.Location = New-Object System.Drawing.Point(150,120)
        $CancelButton.Location = New-Object System.Drawing.Point(260,150)
        $CancelButton.Size = New-Object System.Drawing.Size(75,23)
        $CancelButton.Text = 'Cancel'
        $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $CancelButton
        $form.Controls.Add($CancelButton)


        #Adding template drop down
        $DropDownArray = "2012R2_Template","2016_Template","1801_Template","1807_Template","2019_Template"
        $DropDown = New-object System.Windows.Forms.ComboBox
        $DropDown.Location = New-object System.Drawing.Size(140,40)
        $DropDown.Size = New-object System.Drawing.Size(200,20)

        ForEach ($Item in $DropDownArray) {
   
	    $DropDown.Items.Add($Item) | Out-Null
    }
  
        $Form.Controls.Add($DropDown)
        $result = $form.ShowDialog()    
        $templatename = $DropDown.Text
    
        If($templatename -eq "2012R2_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM2012MS"
        $global:T_SRSInstance = hostname
        $global:T_RDRACC="$domainsuffix\2012R2-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_SendODRReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:T_installationpath="C:\SC 2012 RTM SCOM"
       
    }
        If($templatename -eq "2016_Template")
                                                                                                        {
        
        $global:T_ManagementServer = "SCOM2016MS"
        $global:T_SRSInstance = hostname
        $global:T_RDRACC="$domainsuffix\2016-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_SendODRReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:T_installationpath="C:\SC 2016 RTM SCOM"
          
    }
        If($templatename -eq "1801_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM1801MS"
        $global:T_SRSInstance = hostname
        $global:T_RDRACC="$domainsuffix\1801-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_SendODRReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:T_installationpath="C:\System Center Operations Manager"
       
             
    }
        If($templatename -eq "1807_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM1807MS"
        $global:T_SRSInstance = hostname
        $global:T_RDRACC="$domainsuffix\1807-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_SendODRReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:T_installationpath="C:\System Center Operations Manager"
          
    }
        If($templatename -eq "2019_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM2019MS"
        $global:T_SRSInstance = hostname
        $global:T_RDRACC="$domainsuffix\2019-scomsvc-rdr"
        $global:T_RDRPassword="P@ssw0rd"
        $global:T_SendODRReports="0"
        $global:T_UseMicrosoftUpdate="0"
        $global:T_AcceptLicense="1" 
        $global:T_installationpath="C:\System Center Operations Manager 2019"
         
    }
     
        DefaultFormReporting
    }
    elseif ($ConsoleAnswer -eq 7)
    {
        FormCustomReport
    }
}
#endregion

#region Custom Report Template form
Function  FormCustomReport (){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. Reporting'
$form.Size = New-Object System.Drawing.Size(1200,400)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,310)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,310)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'Management Server Name'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'SSRS Instance Name <server\instance>'
$form.Controls.Add($label2)


$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'DataReaderAction Account: <domain\username>'
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'DataReaderAction Account Password'
$form.Controls.Add($label4)



$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'SendODRReports [0|1]'
$form.Controls.Add($label5)



$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(850,100)
#This is adjust the length and height of the name of the label
$label6.Size = New-Object System.Drawing.Size(350,30)
$label6.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label6)

$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(20,180)
#This is adjust the length and height of the name of the label
$label7.Size = New-Object System.Drawing.Size(350,30)
$label7.Text = 'AcceptEndUserLicenseAgreement: [0|1]'
$form.Controls.Add($label7)

$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(450,180)
#This is adjust the length and height of the name of the label
$label8.Size = New-Object System.Drawing.Size(350,30)
$label8.Text = 'Installation Path e.g: C:\System Center Operations Manager 2019'
$form.Controls.Add($label8)



$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox1)
$textbox1.AutoCompleteSource = 'CustomSource'
$textbox1.AutoCompleteMode='SuggestAppend'
$textbox1.AutoCompleteCustomSource=$autocomplete
"SCOM2019MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM1801MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM1807MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM2016MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM2012MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }


$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox2)
$textbox2.AutoCompleteSource = 'CustomSource'
$textbox2.AutoCompleteMode='SuggestAppend'
$textbox2.AutoCompleteCustomSource=$autocomplete
hostname | % {$textbox2.AutoCompleteCustomSource.AddRange($_) }


$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox3)
$textbox3.AutoCompleteSource = 'CustomSource'
$textbox3.AutoCompleteMode='SuggestAppend'
$textbox3.AutoCompleteCustomSource=$autocomplete
"$domainsuffix\2019-scomsvc-rdr" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }

$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox4)
$textbox4.AutoCompleteSource = 'CustomSource'
$textbox4.AutoCompleteMode='SuggestAppend'
$textbox4.AutoCompleteCustomSource=$autocomplete
"P@ssw0rd" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox5)
$textbox5.AutoCompleteSource = 'CustomSource'
$textbox5.AutoCompleteMode='SuggestAppend'
$textbox5.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox5.AutoCompleteCustomSource.AddRange($_) }

$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(850,130)
$textBox6.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox6)
$textbox6.AutoCompleteSource = 'CustomSource'
$textbox6.AutoCompleteMode='SuggestAppend'
$textbox6.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox6.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox6.AutoCompleteCustomSource.AddRange($_) }



$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(20,210)
$textBox7.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox7)
$textbox7.AutoCompleteSource = 'CustomSource'
$textbox7.AutoCompleteMode='SuggestAppend'
$textbox7.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox7.AutoCompleteCustomSource.AddRange($_) }


$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(450,210)
$textBox8.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox8)

$form.Topmost = $true

#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    
    $global:ManagementServer = $textBox1.Text
    $global:SRSInstance = $textBox2.Text
    $global:RDRACC=$textBox3.Text
    $global:RDRPassword=$textBox4.Text
    $global:SendODRReports=$textBox5.Text
    $global:UseMicrosoftUpdate=$textBox6.Text
    $global:AcceptLicense=$textBox7.Text
    $global:installationpath=$textBox8.Text
   


    Write-Host "    ManagementServer:"   $ManagementServer
    Write-Host "    SRSInstance:"    $SRSInstance
    Write-Host "    RDRACC:"    $RDRACC
    Write-Host "    RDRPassword:"    $RDRPassword
    Write-Host "    SendODRReports:"    $SendODRReports
    Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
    Write-Host "    AcceptLicense:"    $AcceptLicense
    Write-Host "    installationpath:"    $installationpath
    
$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t  Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t  Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Default WebConsole Template form
Function DefaultFormWebConsole(){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. Webconsole'
$form.Size = New-Object System.Drawing.Size(1200,400)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,310)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,310)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'Management Server Name'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'WebSiteName'
$form.Controls.Add($label2)


$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'WebConsoleAuthorizationMode'
$form.Controls.Add($label3)



$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'UseMicrosoftUpdate: [0|1]'
$form.Controls.Add($label4)



$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'Installation Path e.g: C:\System Center Operations Manager 2019'
$form.Controls.Add($label5)



$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$textBox1.Text=$T_ManagementServer
$form.Controls.Add($textBox1)


$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$textBox2.Text=$T_WebSiteName
$form.Controls.Add($textBox2)


$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$textBox3.Text=$T_WebConsoleAuthorizationMode
$form.Controls.Add($textBox3)




$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$textBox4.Text=$T_UseMicrosoftUpdate
$form.Controls.Add($textBox4)




$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$textBox5.Text=$T_installationpath
$form.Controls.Add($textBox5)

$form.Topmost = $true
$Form.Add_Shown({$Form.Activate()})
#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $global:ManagementServer = $textBox1.Text
    $global:WebSiteName = $textBox2.Text
    $global:WebConsoleAuthorizationMode=$textBox3.Text
    $global:UseMicrosoftUpdate=$textBox4.Text  
    $global:installationpath=$textBox5.Text
   


Write-Host "    ManagementServer:"   $ManagementServer
Write-Host "    WebSiteName:"    $WebSiteName
Write-Host "    WebConsoleAuthorizationMode:"    $WebConsoleAuthorizationMode
Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
Write-Host "    installationpath:"    $installationpath

$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region Template WebConsole selection window
#Creating an user window
Function TemplateWebConsole{
    $a = new-object -comobject wscript.shell 
    $ConsoleAnswer = $a.popup("Do you want to use Default WebConsole Template?",0,"Choose Template?",4)

    if($ConsoleAnswer -eq 6)
    {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $Form = New-Object system.Windows.Forms.Form
        $Form.Text = "Default WebConsole Template Selection"
        $Label = New-Object System.Windows.Forms.Label
        #$Label.Text = "This form is very simple."
        $form.Size = New-Object System.Drawing.Size(500,300)
        $form.StartPosition = 'CenterScreen'
        $Form.Controls.Add($Label)

        $OKButton = New-Object System.Windows.Forms.Button
        #$OKButton.Location = New-Object System.Drawing.Point(75,120)
        $OKButton.Location = New-Object System.Drawing.Point(160,150)
        $OKButton.Size = New-Object System.Drawing.Size(75,23)
        $OKButton.Text = 'OK'
        $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $OKButton
        $form.Controls.Add($OKButton)

        $CancelButton = New-Object System.Windows.Forms.Button
        #$CancelButton.Location = New-Object System.Drawing.Point(150,120)
        $CancelButton.Location = New-Object System.Drawing.Point(260,150)
        $CancelButton.Size = New-Object System.Drawing.Size(75,23)
        $CancelButton.Text = 'Cancel'
        $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $CancelButton
        $form.Controls.Add($CancelButton)


        #Adding template drop down
        $DropDownArray = "2012R2_Template","2016_Template","1801_Template","1807_Template","2019_Template"
        $DropDown = New-object System.Windows.Forms.ComboBox
        $DropDown.Location = New-object System.Drawing.Size(140,40)
        $DropDown.Size = New-object System.Drawing.Size(200,20)

        ForEach ($Item in $DropDownArray) {
   
	    $DropDown.Items.Add($Item) | Out-Null
    }
  
        $Form.Controls.Add($DropDown)
        $result = $form.ShowDialog()    
        $templatename = $DropDown.Text
    
        If($templatename -eq "2012R2_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM2012MS"
        $global:T_WebSiteName="Default Web Site"
        $global:T_WebConsoleAuthorizationMode="Mixed" 
        $global:T_UseMicrosoftUpdate="0"
        $global:T_installationpath="C:\SC 2012 RTM SCOM"
       
    }
        If($templatename -eq "2016_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM2016MS"
        $global:T_WebSiteName="Default Web Site"
        $global:T_WebConsoleAuthorizationMode="Mixed" 
        $global:T_UseMicrosoftUpdate="0"
        $global:T_installationpath="C:\SC 2016 RTM SCOM"       
                  
    }
        If($templatename -eq "1801_Template")
        {
        
        $global:T_ManagementServer = "SCOM1801MS"
        $global:T_WebSiteName="Default Web Site"
        $global:T_WebConsoleAuthorizationMode="Mixed" 
        $global:T_UseMicrosoftUpdate="0"
        $global:T_installationpath="C:\System Center Operations Manager"
       
             
    }
        If($templatename -eq "1807_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM1807MS"
        $global:T_WebSiteName="Default Web Site"
        $global:T_WebConsoleAuthorizationMode="Mixed" 
        $global:T_UseMicrosoftUpdate="0"
        $global:T_installationpath="C:\System Center Operations Manager"
          
    }
        If($templatename -eq "2019_Template")
                                                                                                        {
        $global:T_ManagementServer = "SCOM2019MS"
        $global:T_WebSiteName="Default Web Site"
        $global:T_WebConsoleAuthorizationMode="Mixed" 
        $global:T_UseMicrosoftUpdate="0"
        $global:T_installationpath="C:\System Center Operations Manager 2019"
         
    }
     
        DefaultFormWebConsole
    }
    elseif ($ConsoleAnswer -eq 7)
    {
        FormCustomWebConsole
    }
}
#endregion

#region Custom Report Template form
Function  FormCustomWebConsole (){
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'SCOM LAB Setup Form. WebConsole'
$form.Size = New-Object System.Drawing.Size(1200,400)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(500,310)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(600,310)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20,20)
#This is adjust the length and height of the name of the label
$label1.Size = New-Object System.Drawing.Size(350,30)
$label1.Text = 'Management Server Name'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(450,20)
#This is adjust the length and height of the name of the label
$label2.Size = New-Object System.Drawing.Size(350,30)
$label2.Text = 'WebSiteName'
$form.Controls.Add($label2)


$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(850,20)
#This is adjust the length and height of the name of the label
$label3.Size = New-Object System.Drawing.Size(350,30)
$label3.Text = 'WebConsoleAuthorizationMode'
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(20,100)
#This is adjust the length and height of the name of the label
$label4.Size = New-Object System.Drawing.Size(350,30)
$label4.Text = 'UseMicrosoftUpdate: [0|1'
$form.Controls.Add($label4)



$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(450,100)
#This is adjust the length and height of the name of the label
$label5.Size = New-Object System.Drawing.Size(350,30)
$label5.Text = 'installationpath e.g: C:\System Center Operations Manager 2019'
$form.Controls.Add($label5)


$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(20,50)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox1)
$textbox1.AutoCompleteSource = 'CustomSource'
$textbox1.AutoCompleteMode='SuggestAppend'
$textbox1.AutoCompleteCustomSource=$autocomplete
"SCOM2019MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM1801MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM1807MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM2016MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }
"SCOM2012MS" | % {$textbox1.AutoCompleteCustomSource.AddRange($_) }


$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(450,50)
$textBox2.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox2)
$textbox2.AutoCompleteSource = 'CustomSource'
$textbox2.AutoCompleteMode='SuggestAppend'
$textbox2.AutoCompleteCustomSource=$autocomplete
"Default Web Site" | % {$textbox2.AutoCompleteCustomSource.AddRange($_) }


$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(850,50)
$textBox3.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox3)
$textbox3.AutoCompleteSource = 'CustomSource'
$textbox3.AutoCompleteMode='SuggestAppend'
$textbox3.AutoCompleteCustomSource=$autocomplete
"Mixed" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }
"Network" | % {$textbox3.AutoCompleteCustomSource.AddRange($_) }

$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(20,130)
$textBox4.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox4)
$textbox4.AutoCompleteSource = 'CustomSource'
$textbox4.AutoCompleteMode='SuggestAppend'
$textbox4.AutoCompleteCustomSource=$autocomplete
"0" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }
"1" | % {$textbox4.AutoCompleteCustomSource.AddRange($_) }

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(450,130)
$textBox5.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textBox5)

$form.Topmost = $true

#$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    
    $global:ManagementServer = $textBox1.Text
    $global:WebSiteName = $textBox2.Text
    $global:WebConsoleAuthorizationMode=$textBox3.Text
    $global:UseMicrosoftUpdate=$textBox4.Text
    $global:installationpath=$textBox5.Text
       


    Write-Host "    ManagementServer:"   $ManagementServer
    Write-Host "    WebSiteName:"    $WebSiteName
    Write-Host "    WebConsoleAuthorizationMode:"    $WebConsoleAuthorizationMode
    Write-Host "    UseMicrosoftUpdate:"    $UseMicrosoftUpdate
    Write-Host "    installationpath:"    $installationpath
    
$readhost=Read-Host "Are the above information correct? (Y/N)"
If ($readhost -eq "N")
{
    Write-Host "$(logtime) `t  Exiting script. Re run the script with correct information.." -ForegroundColor Red
    Sleep 2
    Exit
} 
}
else
{
  Write-Host "$(logtime) `t  Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#endregion

#region OM Feature Selection Form
Function OMFeatureSelection() {
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#This creates the form and sets its size and position
$Form = New-Object System.Windows.Forms.Form 
$Form.Text = "OM product selection"
$Form.Size = New-Object System.Drawing.Size(500,350) 
$Form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
#$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Location = New-Object System.Drawing.Point(160,250)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Location = New-Object System.Drawing.Point(260,250)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

#This creates a checkbox 
$global:CheckboxPrimaryMS = New-Object System.Windows.Forms.Checkbox 
$CheckboxPrimaryMS.Location = New-Object System.Drawing.Size(100,20) 
$CheckboxPrimaryMS.Size = New-Object System.Drawing.Size(200,20)
$CheckboxPrimaryMS.Text = "Primary Management Server"
#$CheckboxPrimaryMS.TabIndex = 1
$Form.Controls.Add($CheckboxPrimaryMS)


$global:CheckboxAdditionalMS = New-Object System.Windows.Forms.Checkbox 
$CheckboxAdditionalMS.Location = New-Object System.Drawing.Size(100,60) 
$CheckboxAdditionalMS.Size = New-Object System.Drawing.Size(200,20)
$CheckboxAdditionalMS.Text = "Additional Management Server"
#$CheckboxAdditionalMS.TabIndex = 1
$Form.Controls.Add($CheckboxAdditionalMS)


$global:CheckboxOMConsole = New-Object System.Windows.Forms.Checkbox 
$CheckboxOMConsole.Location = New-Object System.Drawing.Size(100,100) 
$CheckboxOMConsole.Size = New-Object System.Drawing.Size(200,20)
$CheckboxOMConsole.Text = "OM console"
$Form.Controls.Add($CheckboxOMConsole)

$global:CheckboxOMReporting = New-Object System.Windows.Forms.Checkbox 
$CheckboxOMReporting.Location = New-Object System.Drawing.Size(100,140) 
$CheckboxOMReporting.Size = New-Object System.Drawing.Size(200,20)
$CheckboxOMReporting.Text = "OM Reporting"
$Form.Controls.Add($CheckboxOMReporting)

$global:CheckboxOMWebConsole = New-Object System.Windows.Forms.Checkbox 
$CheckboxOMWebConsole.Location = New-Object System.Drawing.Size(100,180) 
$CheckboxOMWebConsole.Size = New-Object System.Drawing.Size(200,20)
$CheckboxOMWebConsole.Text = "OM WebConsole"
$Form.Controls.Add($CheckboxOMWebConsole)
#>

$form.Topmost = $true
$Form.Add_Shown({$Form.Activate()})
#$form.ShowDialog()
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    If($CheckboxPrimaryMS.Checked -eq $True)
    {

        Write-Host "$(logtime) `t Primary MS is selected" -ForegroundColor Green
        sleep 2
        TemplatePrimary
    }

    If($CheckboxAdditionalMS.Checked -eq $True)
    {

        Write-Host "$(logtime) `t Addtional MS is selected" -ForegroundColor Green
        Sleep 2
        TemplateAdditional
    }

    If($CheckboxOMConsole.Checked -eq $True)
    {
        Write-Host "$(logtime) `t OM Console is selected" -ForegroundColor Green
        #This creates the form and sets its size and position
        $Form = New-Object System.Windows.Forms.Form 
        $Form.Text = "OM console version selection"
        $Form.Size = New-Object System.Drawing.Size(500,200) 
        $Form.StartPosition = "CenterScreen"

        $OKButton = New-Object System.Windows.Forms.Button
        #$OKButton.Location = New-Object System.Drawing.Point(75,120)
        $OKButton.Location = New-Object System.Drawing.Point(160,120)
        $OKButton.Size = New-Object System.Drawing.Size(75,23)
        $OKButton.Text = 'OK'
        $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $OKButton
        $form.Controls.Add($OKButton)

        $CancelButton = New-Object System.Windows.Forms.Button
        #$CancelButton.Location = New-Object System.Drawing.Point(150,120)
        $CancelButton.Location = New-Object System.Drawing.Point(260,120)
        $CancelButton.Size = New-Object System.Drawing.Size(75,23)
        $CancelButton.Text = 'Cancel'
        $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $CancelButton
        $form.Controls.Add($CancelButton)

        #This creates a checkbox 
        $global:CheckboxOMConsole2012 = New-Object System.Windows.Forms.Checkbox 
        $CheckboxOMConsole2012.Location = New-Object System.Drawing.Size(100,20) 
        $CheckboxOMConsole2012.Size = New-Object System.Drawing.Size(200,20)
        $CheckboxOMConsole2012.Text = "OM Console 2012 R2"
        #$CheckboxPrimaryMS.TabIndex = 1
        $Form.Controls.Add($CheckboxOMConsole2012)


        $global:CheckboxOMConsoleRest = New-Object System.Windows.Forms.Checkbox 
        $CheckboxOMConsoleRest.Location = New-Object System.Drawing.Size(100,60) 
        $CheckboxOMConsoleRest.Size = New-Object System.Drawing.Size(200,20)
        $CheckboxOMConsoleRest.Text = "OM Console 2016/1801/1807/2019"
        #$CheckboxAdditionalMS.TabIndex = 1
        $Form.Controls.Add($CheckboxOMConsoleRest)

        $form.Topmost = $true
        $Form.Add_Shown({$Form.Activate()})
        #$form.ShowDialog()
        $result = $form.ShowDialog()

        if ($result -eq [System.Windows.Forms.DialogResult]::OK)
        {
              If($CheckboxOMConsole2012.Checked -eq $True)
            {

                $global:rptvwr1="Microsoft Report Viewer 2012 Runtime"
                $global:clrtype1="Microsoft System CLR Types for SQL Server 2012 (x64)"
            }
              If($CheckboxOMConsoleRest.Checked -eq $True)
            {

              $global:rptvwr1="Microsoft Report Viewer 2015 Runtime"
              $global:clrtype1="Microsoft System CLR Types for SQL Server 2014"
            }
            
        }
        else
            {
              Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
              Sleep 2
              Exit
            }

        }

    If($CheckboxOMReporting.Checked -eq $True)
    {

        Write-Host "$(logtime) `t SCOM Reporting is selected" -ForegroundColor Green
        sleep 2
        TemplateReporting
    }

    If($CheckboxOMWebConsole.Checked -eq $True)
    {

        Write-Host "$(logtime) `t SCOM WebConsole is selected" -ForegroundColor Green
        sleep 2
        TemplateWebConsole
    }
} 

else
{
  Write-Host "$(logtime) `t Exiting script as the form is cancelled..." -ForegroundColor Red
  Sleep 2
  Exit
}
}
#Write-Host "OMFeatureSelection"
OMFeatureSelection
#endregion

#region Create AD Users
Function CreateUser() {
    CheckADModule
    sleep 2
    Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
    #$Adusers="Test1","Test2"
    $Adusers=$Adusers.split(',')
    #$AdUsers
    #$password
    $password = $password | ConvertTo-SecureString -AsPlainText -Force
    #$domain="pop1.lab"
    $Domain=$Domain.split('.')
    $domain1=$Domain[0]
    $domain2=$domain[1]
    $path="DC=$domain1,DC=$domain2"
    #$path
    Write-host "$(logtime) `t Checking if SystemCenter OU is created.." -ForegroundColor Cyan
    sleep 2
    $OU=Get-ADOrganizationalUnit -Filter 'Name -like "SystemCenter"'
    $OU=$OU.DistinguishedName
    $myOU="OU=SystemCenter" + ',' + "$path"
    if($OU -eq $myOU)
    {
        Write-Host "$(logtime) `t OU SystemCenter is already created.." -ForegroundColor Green
        Sleep 2
    }
    elseif($OU -eq $null)
    {
         Write-host "$(logtime) `t SystemCenter OU is not created. Creating.. " -ForegroundColor Magenta
         Sleep 2
         New-ADOrganizationalUnit -Name SystemCenter -Path $path
         $OU=Get-ADOrganizationalUnit -Filter 'Name -like "SystemCenter"' 
         if($OU.DistinguishedName -eq $myOU)
         {
           Write-host "$(logtime) `t OU SystemCenter is successfully created..." -ForegroundColor Green
           Sleep 2
         }
         else
         {
           Write-host "$(logtime) `t OU SystemCenter cannot be created. Exiting.." -ForegroundColor Red
           Sleep 2
           Exit
         }
    }

        
    $OU=Get-ADOrganizationalUnit -Filter 'Name -like "SystemCenter"'
    Foreach ($Aduser in $Adusers)
    {
        Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
        #$Aduser="TestReport1"
        Write-host "$(logtime) `t Checking if $Aduser is already created.." -ForegroundColor Cyan
        Sleep 2
        $user=Get-ADUser $Aduser -ErrorAction SilentlyContinue
        If($user -eq $null)
        { 
            Write-Host "$(logtime) `t $Aduser is not found. Creating $Aduser user.." -ForegroundColor Yellow 
            Sleep 2     
            New-ADUser -Name $Aduser -AccountPassword $password -PasswordNeverExpires $True -Path $OU -CannotChangePassword $true -Enabled $True
            $user=Get-ADUser -Filter $Aduser  $ErrorActionPreference
        If($user -eq $null)
        { 
            Write-Host "$(logtime) `t $Aduser user is created now.." -ForegroundColor Green 
            Sleep 2   
        }
        else
        {
            Write-Host "$(logtime) `t $Aduser cannot be created. Exiting.." -ForegroundColor Red
            Sleep 2  
            Exit  
        }
        }
        else
        {
            Write-Host "$(logtime) `t $Aduser is found. Skipping user creation.." -ForegroundColor Green
            Sleep 2     
        }         
    } 
}
#endregion

#region Create AD Group
Function CreateOMGroup(){
Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
    Write-Host "$(logtime) `t Checking if $group group is created in AD.." -ForegroundColor Cyan
    Sleep 2
    $OMAdminGroup=Get-ADGroup -Filter 'Name -like $group'
    If($OMAdminGroup)
    {
        Write-Host "$(logtime) `t $group group is already created.." -ForegroundColor Green
        Sleep 2     
    }
    else
    {
         Write-Host "$(logtime) `t $group not found. Creating $group group.." -ForegroundColor Yellow
         sleep 2
         $OU=Get-ADOrganizationalUnit -Filter 'Name -like "SystemCenter"'
         New-ADGroup –name $group –groupscope Global –path $OU | Out-Null
         $OMAdminGroup=Get-ADGroup -Filter 'Name -like $group'
         Write-Host "$(logtime) `t Checking if $group group is created in AD now.." -ForegroundColor Cyan
         Sleep 2
         $OMAdminGroup=Get-ADGroup -Filter 'Name -like $group'
         If($OMAdminGroup)
         {
            Write-Host "$(logtime) `t $group group is  created now.." -ForegroundColor Green
            Sleep 2     
         }
         Else
         {
            Write-Host "$(logtime) `t $group group cannot be created or found..Exiting.." -ForegroundColor Red
            Sleep 2
            Exit
         }
    }
     Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
     Write-Host "$(logtime) `t Checking MS and DAS Action Account are added $group group.." -ForegroundColor Cyan
     sleep 2
     #$MSAcc="scomms-svc"
     #$DASAcc="scomdas-svc"
     #$MSAcc="pop1\2019-scomsvc-ms"
     $MsAcc1=$MSAcc.split('\')
     $MSAcc1=$MsAcc1[1]
     #$group = "OM2019Admins"
     $members = Get-ADGroupMember -Identity $group -Recursive | Select -ExpandProperty Name

     #Checking and adding MS account to the group
     If($members -contains $MSAcc1)
     {
         Write-Host "$(logtime) `t MS Action Account $MsAcc is already added to $group group.." -ForegroundColor Green
         Sleep 2
     }
     else
     {
     Write-Host "$(logtime) `t Adding $MSAcc Action Account to $group group.." -ForegroundColor Yellow
     Sleep 2
    
     Add-ADGroupMember -Identity $group -Members $MSAcc1
     $members = Get-ADGroupMember -Identity $group -Recursive | Select -ExpandProperty Name
     If($members -contains $MSAcc1)
     {
         Write-Host "$(logtime) `t MS Action Account $MSAcc is added to $group group now.." -ForegroundColor Green
         Sleep 2
     }
     Else
     {
        Write-Host "$(logtime) `t MS Acction Account $MSAcc cannot be added to $group group ..Exiting.." -ForegroundColor Red
        Sleep 2
        Exit
     }

     }

     #Checking and adding DAS account to the group
      #$DasAcc="pop1\2019-scomsvc-das"
     $DasAcc1=$DasAcc.split('\')
     $DasAcc1=$DasAcc1[1]
     If($members -contains $DASAcc1)
     {
         Write-Host "$(logtime) `t DAS Action Account $DASAcc is already added to $group group.." -ForegroundColor Green
         Sleep 2
     }
     else
     {
     Write-Host "$(logtime) `t Adding DAS Action Account $DASAcc to $group group.." -ForegroundColor Yellow
     Sleep 2
     #$DasAcc="pop1\2019-scomsvc-das"
     $DasAcc1=$DasAcc.split('\')
     $DasAcc1=$DasAcc1[1]
     Add-ADGroupMember -Identity $group -Members $DASAcc1
     $members = Get-ADGroupMember -Identity $group -Recursive | Select -ExpandProperty Name
     If($members -contains $DASAcc1)
     {
         Write-Host "$(logtime) `t DAS Action Account $DASAcc is added to $group group now.." -ForegroundColor Green
         Sleep 2
     }
      Else
     {
        Write-Host "$(logtime) `t DAS Action Account $DASAcc cannot be added to $group group..Exiting.." -ForegroundColor Red
        Sleep 2
        Exit
     }
     }

     Write-host "$(logtime) `t Checking $group group to the local administrator of the Management Server.." -ForegroundColor Cyan
     sleep 2
     $localadmin=Get-LocalGroupMember -Group Administrators | where {$_.Name -match $group}

     if($localadmin)
     {
        Write-host "$(logtime) `t $group group is already added to the local administrator of the Management Server.." -ForegroundColor Green
        sleep 2
     }
     Else
     {     
         Write-host "$(logtime) `t Adding $group group to the local administrator of the Management Server.." -ForegroundColor Yellow
         sleep 2
         Add-LocalGroupMember -Group Administrators -Member $group     
         $localadmin=Get-LocalGroupMember -Group Administrators | where {$_.Name -match $group}
         if($localadmin)
         {
            Write-host "$(logtime) `t $group group is added to the local administrator of the Management Server now.." -ForegroundColor Green
            sleep 2
         }
         else
         {
             Write-Host "$(logtime) `t $group group cannot be added to the local administrator of the Management Server..Exiting.." -ForegroundColor Red
             Sleep 2
             Exit         
         }
}

}
#endregion

#region Check AD Module
Function CheckADModule() {
        Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
        Write-Host "$(logtime) `t Checking if AD Modules are imported" -ForegroundColor Cyan
        $ADModule=Get-Module ActiveDirectory

        If ($ADModule -ne $null)
        {
            Write-Host "$(logtime) `t ADModule is already installed...." -ForegroundColor Green
        }
        else
        {
            Write-Host "$(logtime) `t Installating AD Module through Remote Server Administration Role...." -ForegroundColor Cyan
            Add-WindowsFeature RSAT-AD-PowerShell 
            Import-Module ActiveDirectory 
            $ADModule=Get-Module ActiveDirectory
            If ($ADModule -eq $null)
            {
                 Write-Host "$(logtime) `t AD Module cannot be installed. Exiting..." -ForegroundColor Red
                 Exit
            }
            else
            {
                Write-Host "$(logtime) `t ADModule installed successfully" -ForegroundColor Green
            }
        }
    }
#endregion

#region Pre-Requisites Software
Function ConsolePreReq(){
Param ($rptvwr,$clrtype)

Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White

Write-Host "$(logtime) `t Checking Pre-Requisites softwares" -ForegroundColor Cyan
Sleep 2
$RuntimePackage=Get-Package -name $rptvwr -ErrorAction SilentlyContinue
$ClrTypesPackage=Get-Package -name $clrtype -ErrorAction SilentlyContinue


#Checking Clr Types Package
If ($ClrTypesPackage)
{
  Write-Host "$(logtime) `t $clrtype package is already installed" -ForegroundColor Green
  Sleep 2
}
Else
{

 Write-Host "$(logtime) `t Checking if the path $PreReqPath specified for the PreReq software is present" -ForegroundColor Cyan
 $path=Test-Path -Path $PreReqPath -ErrorAction SilentlyContinue
 if($path)
 {
 Write-host "$(logtime) `t $PreReqPath is found on the machine.." -ForegroundColor Green
 Write-Host "$(logtime) `t Checking if $clrtype package is copied to $PreReqPath...." -ForegroundColor Cyan
 Sleep 2
 $SQLSysClrTypes = Get-Item "$PreReqPath\SQLSysClrTypes.msi" -ErrorAction SilentlyContinue
 #$SQLSysClrTypes
 If($SQLSysClrTypes)
 {
    Write-Host "$(logtime) `t $clrtype package is found" -ForegroundColor Green 
    Sleep 2
 }
 else
 {
    Write-Host "$(logtime) `t $clrtype package is NOT found" -ForegroundColor Magenta 
    Sleep 2
    Write-Host "$(logtime) `t Copy $clrtype package to $PreReqPath....and continue" -ForegroundColor Cyan
    Sleep 2
    Pause
    $SQLSysClrTypes = Get-Item "$path\SQLSysClrTypes.msi"
    If( $SQLSysClrTypes)
    {
        Write-Host "$(logtime) `t $clrtype package is found" -ForegroundColor Green
        Sleep 2 
    }
}
    Write-Host "$(logtime) `t Installing $clrtype package" -ForegroundColor Cyan
    Sleep 2
    msiexec /qb /i "$SQLSysClrTypes" IACCEPTSQLNCLILICENSETERMS=YES | Out-Null
    Write-Host "$(logtime) `t Checking if the $clrtype package is installed now" -ForegroundColor Cyan
    Sleep 2
    $ClrTypesPackage=Get-Package -name $clrtype -ErrorAction Continue

    If ($ClrTypesPackage)
    {
        Write-Host "$(logtime) `t $clrtype package is installed now..." -ForegroundColor Green
        Sleep 2
    }
    else
    {
        Write-Host "$(logtime) `t $clrtype package is not installed. Exiting...." -ForegroundColor Red
        Sleep 2
        Exit  
    }
 }
 else
 {
    Write-Host "$(logtime) `t $PreReqPath is not present in this machine. Exiting...." -ForegroundColor Red
    Sleep 2
    Exit
 }
 }
    
#Checking RunTIme Viewer Package

If ($RuntimePackage)
{
  Write-Host "$(logtime) `t $rptvwr package is already installed" -ForegroundColor Green
  Sleep 2
}
Else
{ 
 Write-Host "$(logtime) `t Checking if $rptvwr package is copied to C:Temp...." -ForegroundColor Cyan
 Sleep 2
 $ReportViewer = Get-Item "$PreReqPath\ReportViewer.msi"
 If($ReportViewer)
 {
    Write-Host "$(logtime) `t $rptvwr package is found" -ForegroundColor Green 
    Sleep 2
 }
 else
 {
    Write-Host "$(logtime) `t $rptvwr package is NOT found" -ForegroundColor Magenta 
    Sleep 2
    Write-Host "$(logtime) `t Copy $rptvwr package to $PreReqPath....and continue" -ForegroundColor Cyan
    Sleep 2
    Pause
    $ReportViewer = Get-Item "$PreReqPath\ReportViewer.msi"
    If( $ReportViewer)
    {
        Write-Host "$(logtime) `t $rptvwr package is found" -ForegroundColor Green
        Sleep 2 
    }
    }
    Write-Host "$(logtime) `t Installing $rptvwr package" -ForegroundColor Cyan
    Sleep 2
    msiexec /qb /i "$ReportViewer" IACCEPTSQLNCLILICENSETERMS=YES | Out-Null
    Write-Host "$(logtime) `t Checking if the $rptvwr package is installed now" -ForegroundColor Cyan
    Sleep 2
    $ReportViewer=Get-Package -name $rptvwr -ErrorAction Continue

    If ($ReportViewer)
    {
        Write-Host "$(logtime) `t $rptvwr package is installed now..." -ForegroundColor Green
        Sleep 2
    }
    else
    {
        Write-Host "$(logtime) `t $rptvwr package is not installed. Exiting...." -ForegroundColor Red
        Sleep 2
        Exit  
    }
 }   
   
} 

#endregion

#region SQL Connectivity
FUnction SQLConnectivity(){
Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
If($OpsDBSQL -eq $OpsDWSQL)
{
    Write-Host "$(logtime) `t Since OpsDBSQL and OpsDWSQL server are same so checking the connectivty to only OpsDB SQL server.." -ForegroundColor Cyan
     Sleep 2
    OpsDBSQLConnectivity
    Sleep 2
}
else
{
    Write-Host "$(logtime) `t Since OpsDBSQL and OpsDWSQL server are different so checking the connectivty to both OpsDB and Ops DW SQL server.." -ForegroundColor Cyan
    Sleep 2
    OpsDBSQLConnectivity
    Sleep 2
    OpsDWSQLConnectivity
}
}
#endregion

#region OpsDB SQL Connectivity
Function OpsDBSQLConnectivity(){
Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
    Write-Host "$(logtime) `t Checking Ops DB SQL connectivity..." -ForegroundColor Cyan
    Sleep 2

    #$OpsDBSQL="SQL2017"
    $dataSource = $OpsDBSQL
    $database = "Master"
    $connectionString = “Server=$dataSource;Database=$database;Integrated Security=True;”

    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString

    $connection.Open()


    $query = "select @@version;"

    $command = $connection.CreateCommand()

    $command.CommandText = $query
    $result = $command.ExecuteReader()

    $table = new-object “System.Data.DataTable”
    $table.Load($result)
    $connection.Close()

    If ($table -ne $null)
    {
        Write-Host "$(logtime) `t OPS DB SQL connectivity is good..." -ForegroundColor Green
        Sleep 2
    } 
    Else
    {
        Write-Host "$(logtime) `t Ops DB SQL connectivity is broken...Exiting.." -ForegroundColor Red
        Sleep 2
        Exit
    }
     
}
#endregion

#region OpsDW SQL Connectivity
Function OpsDWSQLConnectivity(){
Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
    Write-Host "$(logtime) `t Checking Ops DW SQL connectivity..." -ForegroundColor Cyan
    Sleep 2

    #$OpsDBSQL="SQL2017"
    $dataSource = $OpsDWSQL
    $database = "Master"
    $connectionString = “Server=$dataSource;Database=$database;Integrated Security=True;”

    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString

    $connection.Open()


    $query = "select @@version;"

    $command = $connection.CreateCommand()
    $command.CommandText = $query

    $result = $command.ExecuteReader()

    $table = new-object “System.Data.DataTable”
    $table.Load($result)
    $connection.Close()

    If ($table -ne $null)
    {
        Write-Host "$(logtime) `t Ops DW SQL connectivity is good..." -ForegroundColor Green
        Sleep 2
    } 
    Else
    {
        Write-Host "$(logtime) `t Ops DW SQL connectivity is broken...Exiting.." -ForegroundColor Red
        Sleep 2
        Exit
    }
     
}
#endregion

#region Install ManagementServer
Function InstallManagementServer(){
#Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
Write-Host "$(logtime) `t Installting SCOM Management Server Role. It might take sometime.." -ForegroundColor Cyan
   
   $fileExe = $installationpath

   
   & $fileExe\setup.exe  /silent /install /components:OMServer /ManagementGroupName: $MGName /SqlServerInstance: $OpsDBSQL /SqlInstancePort: $OpsDBPort /DatabaseName: $OpsDBName /DWSqlServerInstance: $OpsDWSQL /DWSqlInstancePort: $OpsDWPort /DWDatabaseName: $OpsDWName /ActionAccountUser: $MSACC /ActionAccountPassword: $MSACCPassword /DASAccountUser: $DASACC /DASAccountPassword: $DASACCPassword /DatareaderUser: $RDRACC /DatareaderPassword: $RDRPassword /DataWriterUser: $WTRACC /DataWriterPassword: $WTRPassword /EnableErrorReporting: $EnableErrorReporting  /SendCEIPReports: $SendCEIPReports /UseMicrosoftUpdate: $UseMicrosoftUpdate /AcceptEndUserLicenseAgreement: $AcceptLicense
   #& 'C:\System Center Operations Manager 2019\setup.exe /silent /install /components:OMServer /ManagementGroupName: $MGName /SqlServerInstance: $OpsDBSQL /SqlInstancePort: $OpsDBPort /DatabaseName: $OpsDBName /DWSqlServerInstance: $OpsDWSQL /DWSqlInstancePort: $OpsDWPort /DWDatabaseName: $OpsDWName /ActionAccountUser: $MSACC /ActionAccountPassword: $MSACCPassword /DASAccountUser: $DASACC /DASAccountPassword: $DASACCPassword /DatareaderUser: $RDRACC /DatareaderPassword: $RDRPassword /DataWriterUser: $WTRACC /DataWriterPassword: $WTRPassword /EnableErrorReporting: $EnableErrorReporting  /SendCEIPReports: $SendCEIPReports /UseMicrosoftUpdate: $UseMicrosoftUpdate /AcceptEndUserLicenseAgreement: $AcceptLicense'


    
    Write-Host "$(logtime) `t Sleeping for 10 mins" -ForegroundColor Cyan
    sleep 600
    Write-Host "$(logtime) `t Checking if SCOM package is installed" -ForegroundColor Cyan
    Sleep 2
    $scompackage=Get-Package -name *Operations* -ProviderName Programs
    If($scompackage)
    {
       Write-Host "$(logtime) `t SCOM Package is installed.." -ForegroundColor Green
       Sleep 2
       Write-Host "$(logtime) `t Checking if SCOM services are running.." -ForegroundColor Cyan
       Sleep 2
       Get-Service healthservice,omsdk,cshost
       InstallSCOMConsole
    }
    else
    {
       Write-Host "$(logtime) `t SCOM Package is not installed. It might need more time.." -ForegroundColor Red
       Sleep 2
       
       Write-Host "$(logtime) `t Sleeping for 10 more mins and rechecking.." -ForegroundColor Cyan
       sleep 600
       $scompackage=Get-Package -name *Operations* -ProviderName Programs
        If($scompackage)
        {
           Write-Host "$(logtime) `t SCOM Package is installed.." -ForegroundColor Green
           Sleep 2
           Write-Host "$(logtime) `t Checking if SCOM services are running.." -ForegroundColor Cyan
           Get-Service healthservice,omsdk,cshost
           
        }
        Else
        {
           Write-Host "$(logtime) `t SCOM Package either failed installation or need more time to install. Check the logs to verify..Exiting...." -ForegroundColor Red
           Sleep 2
           Exit  
        }
    }

}
#endregion

#region Install Additional Management Server
Function InstallAdditionalMS () {


 $fileExe = $installationpath
 

    & $fileExe\setup.exe  /silent /install /components:OMServer /SqlServerInstance: $OpsDBSQL /SqlInstancePort: $OpsDBPort /DatabaseName: $OpsDBName  /ActionAccountUser: $MSACC /ActionAccountPassword: $MSACCPassword /DASAccountUser: $DASACC /DASAccountPassword: $DASACCPassword  /EnableErrorReporting: $EnableErrorReporting  /SendCEIPReports: $SendCEIPReports /UseMicrosoftUpdate: $UseMicrosoftUpdate /AcceptEndUserLicenseAgreement: $acceptlicense
    #setup.exe /silent /install /components:OMServer /SqlServerInstance: <server\instance or Always On availability group listener> /SqlInstancePort: <SQL instance port number> /DatabaseName: <OperationalDatabaseName> /UseLocalSystemActionAccount /UseLocalSystemDASAccount /DataReaderUser: <domain\username> /DataReaderPassword: <password> /DataWriterUser: <domain\username> /DataWriterPassword: <password> /EnableErrorReporting: [Never|Queued|Always] /SendCEIPReports: [0|1] /UseMicrosoftUpdate: [0|1] 


    
    Write-Host "$(logtime) `t Sleeping for 10 mins" -ForegroundColor Cyan
    sleep 600
    Write-Host "$(logtime) `t Checking if SCOM package is installed" -ForegroundColor Cyan
    Sleep 2
    $scompackage=Get-Package -name *Operations* -ProviderName Programs
    If($scompackage)
    {
       Write-Host "$(logtime) `t SCOM Package is installed.." -ForegroundColor Green
       Sleep 2
       Write-Host "$(logtime) `t Checking if SCOM services are running.." -ForegroundColor Cyan
       Sleep 2
       Get-Service healthservice,omsdk,cshost
       #InstallSCOMConsole
    }
    else
    {
       Write-Host "$(logtime) `t SCOM Package is not installed.." -ForegroundColor Red
       Sleep 2
       
       Write-Host "$(logtime) `t Sleeping for 5 more mins and rechecking.." -ForegroundColor Cyan
       sleep 300
       $scompackage=Get-Package -name *Operations* -ProviderName Programs
        If($scompackage)
        {
           Write-Host "$(logtime) `t SCOM Package is installed.." -ForegroundColor Green
           Sleep 2
           Write-Host "$(logtime) `t Checking if SCOM services are running.." -ForegroundColor Cyan
           Get-Service healthservice,omsdk,cshost
           
        }
        Else
        {
           Write-Host "$(logtime) `t SCOM Package either failed installation or need more time to install. Check the logs to verify..Exiting...." -ForegroundColor Red
           Sleep 2
           Exit  
        }
    } 
}
#endregion

#region Install SCOM console
Function InstallSCOMConsole{
Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
Write-Host "$(logtime) `t Installting SCOM Console Role. It might take sometime.." -ForegroundColor Cyan

 $fileExe = $installationpath 

    & $fileExe\setup.exe /silent /install /components:OMConsole /EnableErrorReporting: $EnableErrorReporting /SendCEIPReports: $SendCEIPReports /UseMicrosoftUpdate: $AcceptLicense
   
    Write-Host  "$(logtime) `t Sleeping for 5 mins" -ForegroundColor Cyan
    sleep 300
    Write-Host  "$(logtime) `t Checking if SCOM console is installed.." -ForegroundColor Cyan
    $consolelocation=Get-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft System Center 2016\Operations Manager"
    if($consolelocation)
    {
         Write-Host  "$(logtime) `t SCOM console is installed successfully.." -ForegroundColor Green
    }
    else
    {
         Write-Host  "$(logtime) `t SCOM console is not installed.." -ForegroundColor Red
    }
    
}
#endregion

#region Install SCOM reporting
Function InstallSCOMReporting {
    Write-Host "------------------------------------------------------------------------------------------------------------------------------"
    Write-Host "$(logtime) Checking SCOM Reporting Pre-Req" -ForegroundColor Cyan
    $cred=Get-Credential "$env:USERDOMAIN\$env:USERNAME"
    $webrequest1=Invoke-WebRequest -Uri "http://localhost/ReportServer" -Credential $cred
    $webrequest2=Invoke-WebRequest -Uri "http://localhost/Reports" -Credential $cred
    if($webrequest1.statuscode -eq 200 -and $webrequest2.statuscode -eq 200)
    {
        Write-Host "$(logtime) Reporting URLs are up and running. Continuing.." -ForegroundColor Green
        Write-Host "$(logtime) Installing SCOM Reporting" -ForegroundColor Cyan

           $fileExe = $installationpath 

           & $fileExe\setup.exe /silent /install /components:OMReporting /ManagementServer:$ManagementServer /SRSInstance:$SRSInstance /DataReaderUser:$RDRACC /DataReaderPassword:$RDRPassword /SendODRReports:$SendODRReports /UseMicrosoftUpdate:$UseMicrosoftUpdate /AcceptEndUserLicenseAgreement:$AcceptLicense

           Write-Host "$(logtime) `t Sleeping for 5 mins" -ForegroundColor Cyan
           sleep 300
           Write-Host "$(logtime) `t Checking if Reporting is installed" -ForegroundColor Cyan
           $Registry=Get-Item "HKLM:SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Reporting"
           if ($Registry)
           {
             Write-Host "$(logtime) `t Reporting is installed" -ForegroundColor Green
           }
           else
           {
              Write-Host "$(logtime) `t Reporting is not installed as of now. Sleeping for 5 more mins and rechecking" -ForegroundColor Cyan
              sleep 300
              $Registry=Get-Item "HKLM:SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Reporting"
               if ($Registry)
               {
                 Write-Host "$(logtime) `t Reporting is installed" -ForegroundColor Green
               }
               else
               {
                  Write-Host "$(logtime) `t Reporting is not installed. Exiting.." -ForegroundColor Red
                  sleep 2
                  Exit
               }
           }
    }
    else
    {
        Write-Host "$(logtime) Reporting URLs are not acceessible. Exiting.." -ForegroundColor Red
        Sleep 2
        Exit
    }
    
}
#endregion

#region WebConsole install
Function InstallSCOMWebConsole
{
 Write-Host "------------------------------------------------------------------------------------------------------------------------------"
 Write-host "$(logtime) `t Checking WebConsole Pre-Requisites" -ForegroundColor Cyan
$Windowsfeatures=Get-WindowsFeature NET-WCF-HTTP-Activation45,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors,Web-Http-Logging,Web-Request-Monitor,Web-Filtering,Web-Stat-Compression,Web-Mgmt-Console,Web-Metabase,Web-Asp-Net,Web-Windows-Auth
foreach ($Windowsfeature in $Windowsfeatures)
{
    if ($Windowsfeature.installstate -ne 'Installed')
    {
        Add-WindowsFeature $Windowsfeature
    }
    else
    {
        Write-host $Windowsfeature.displayname "     : is already installed" -ForegroundColor Green
    }
}

Write-Host "$(logtime) `t  If the features are installed, we need to REBOOT the machine. Do you want to reboot the machine now. Save or close all the other application before rebooting?" -ForegroundColor Cyan
$readhost=Read-host "Y/N? (If no features are installed press N)"
If($readhost -eq 'Y')
{
    Restart-Computer
}
else
{
    Write-host "Continuing with WebConsole Installation" -ForegroundColor Cyan

}

   $fileExe = $installationpath 
  
   & $fileExe\setup.exe /silent /install /components:OMWebConsole /ManagementServer:$ManagementServer /WebSiteName: $WebSiteName /WebConsoleAuthorizationMode:$WebConsoleAuthorizationMode  /UseMicrosoftUpdate:$UseMicrosoftUpdate
   
   Write-Host "$(logtime) `t Sleeping for 5 mins" -ForegroundColor Cyan
   sleep 300

}

#endregion

#region Function Calls

if($CheckboxPrimaryMS.Checked -eq $True)
{
    CreateUser
    CreateOMGroup
    SQLConnectivity
    Write-Host "$(logtime) `t  Installating Primary MS" -ForegroundColor Cyan
    Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
    InstallManagementServer

}
if($CheckboxAdditionalMS.Checked -eq $True)
{
    CreateUser
    CreateOMGroup
    OpsDBSQLConnectivity
    Write-Host "Installating Additional MS" -ForegroundColor Cyan
    Write-Host "-----------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor White
    InstallAdditionalMS

}
if($CheckboxOMConsole.Checked -eq $True)
{
    #$rptvwr1 
    #$clrtype1 
    ConsolePreReq $rptvwr1 $clrtype1  
    InstallSCOMConsole
}
if($CheckboxOMReporting.Checked -eq $True)
{
    InstallSCOMReporting
}
if($CheckboxOMWebConsole.Checked -eq $True)
{
    InstallSCOMWebconsole
}
Write-Host "$(logtime) `t Script Completed.." -ForegroundColor Magenta
#endregion



