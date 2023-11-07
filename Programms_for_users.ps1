#if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
#{  
  #$arguments = "& '" +$myinvocation.mycommand.definition + "'"
  #Start-Process powershell -Verb runAs -ArgumentList $arguments
  #Break
#}
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#Не трогать, оно работает и слава богу
$ErrorActionPreference = 'Stop'
#Ссылки на программы
$WinRaR_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1W_aWUaxNq0DCo3jVdVkseRDoaaWlUv-Q"
$Adobe_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1zmyu2GgmfqpMNHNoxNmfbHbIFxRqndn_"
$Office_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1VU36GAF_QEDF9cjnHLR9FAB5NB_P70JR"
$naps2_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1RU_32KW-BApJ6aWoyMjkehW64uMmJVTg"
$Crypto_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1bHThhae4SKboJMuNSHk6u_mR2-4Gn_zr"
$Cryptoplug_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=16AwmWD9mSGUl_GSv2glwZkrzw6j2bJXc"
$Chrome_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1xcoh8MDtqlW52D0YhmkzHOVIm3sMI1C5"
$Yandex_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=17lyy620Sy2siBMmeZOGxM66arQo0O0ku"
$rutoken_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1zHjltoZ-bE3hoZq_AYkkt4b6snrVV32W"
$rutokenplug_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=17j2e4dOebut_IZVWKME28ohJLpT_Ay8p"
$kyocer_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1iGy2Lsg5wnmNO0VD6Q6QR_Z1_uwHGwHl"
$kyocertwain_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1BBkqcSxHSnIk8FPDKniJiVAFqcZo6vj3"
$kyocer1020_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1V7CuHUo_0DoPe-utt_JlvkH81btvuU5O"
$Ricoh_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1Z3TRoZGZHBg9LcduVv5uP8Ix5ban5tHC"
$ricohhtwain_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1hQCxuibRiPAxw6nYNP4b2H3JP0fr8CJD"
$canon_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1kvM8ju4-zOWSiMZ6o5DTswH0R0mApPR_"
$hp_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1MyrpQac6ItuBMZQD6ZNLcnSG83LtOqba"
$xerox_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1NFpFtAJILCX-jRwWg2tG4YX8PGuWF7lh"
$pantum_download = "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1IgosPQO2AYa7LYVB2hvhBFVH6AXg_VVp"
$winrar_path = ".\Winrar.7z"
$Adobe_Path = ".\Reader.exe"
$Office_path = ".\Office.zip"
$naps2_path = ".\Naps2.exe"
$Crypto_path = ".\Crypto.exe"
$Cryptoplug_path = ".\CadesPlugin.exe"
$Chrome_path = ".\Chrome.exe"
$Yandex_path = ".\Yandex.exe"
$rutoken_path = ".\Rutoken.exe"
$rutokenplug_path = ".\RuTokenPlugin.msi"
$kyocer_path = ".\Kyocer.zip"
$kyocertwain_path = ".\KyocerTwain.zip"
$kyocer1020_path = ".\Kyocer1020.7z"
$ricoh_path = ".\Ricoh.exe"
$ricohtwain_path = ".\RicohTwain.exe"
$canon_path = ".\CanonMFDriver.exe"
$hp_path = ".\HP.exe"
$xerox_path = ".\Xerox.exe"
$pantum_path = ".\Pantum.exe"
#Основная функция

function form{
$Form1 = New-Object System.Windows.Forms.Form
$tabControl1 = New-Object System.Windows.Forms.TabControl
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
$tabPage1 = New-Object System.Windows.Forms.TabPage
$tabPage2 = New-Object System.Windows.Forms.TabPage
$tabPage3 = New-Object System.Windows.Forms.TabPage
$tabPage4 = New-Object System.Windows.Forms.TabPage
$checkedListBox1 = New-Object System.Windows.Forms.CheckedListBox
$label1 = New-Object System.Windows.Forms.Label
$label2 = New-Object System.Windows.Forms.Label
$checkBox1 = New-Object System.Windows.Forms.CheckBox
$checkBox2 = New-Object System.Windows.Forms.CheckBox
$checkBox3 = New-Object System.Windows.Forms.CheckBox
$checkBox4 = New-Object System.Windows.Forms.CheckBox
$checkBox5 = New-Object System.Windows.Forms.CheckBox
$checkBox6 = New-Object System.Windows.Forms.CheckBox
$checkBox7 = New-Object System.Windows.Forms.CheckBox
$checkBox8 = New-Object System.Windows.Forms.CheckBox
$checkBox9 = New-Object System.Windows.Forms.CheckBox
$checkBox11 = New-Object System.Windows.Forms.CheckBox
$checkBox13 = New-Object System.Windows.Forms.CheckBox
$checkBox14 = New-Object System.Windows.Forms.CheckBox
$checkBox15 = New-Object System.Windows.Forms.CheckBox
$checkBox16 = New-Object System.Windows.Forms.CheckBox
$checkBox17 = New-Object System.Windows.Forms.CheckBox
$checkBox18 = New-Object System.Windows.Forms.CheckBox
$checkBox19 = New-Object System.Windows.Forms.CheckBox
$checkBox20 = New-Object System.Windows.Forms.CheckBox
$checkBox21 = New-Object System.Windows.Forms.CheckBox
$button1 = New-Object System.Windows.Forms.Button
$button2 = New-Object System.Windows.Forms.Button
$button3 = New-Object System.Windows.Forms.Button
$button4 = New-Object System.Windows.Forms.Button
$progressBar3 = New-Object System.Windows.Forms.ProgressBar
$progressBar4 = New-Object System.Windows.Forms.ProgressBar
$progressBar2 = New-Object System.Windows.Forms.ProgressBar
$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$button7 = New-Object System.Windows.Forms.Button
$listBox1 = New-Object System.Windows.Forms.ListBox

$listBox1.FormattingEnabled = $True
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 260
$System_Drawing_Size.Height = 80
$listBox1.Size = $System_Drawing_Size
$listBox1.DataBindings.DefaultDataSourceUpdateMode = 0
$listBox1.Name = "listBox1"
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 10
$System_Drawing_Point.Y = 320
$listBox1.Location = $System_Drawing_Point
$listBox1.TabIndex = 3

#Обработчик1
$handler_button1_Click= 
{
    $listBox1.Items.Clear();

    if ($checkBox1.Checked){
    $button1.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю AdobeReader")
    Invoke-WebRequest -Uri $Adobe_download -OutFile $Adobe_Path
    $button1.Text = "Готово"
    $checkedListBox1.Items.Add("AdobeReader")
    $listBox1.Items.Clear();
    }

    if ($checkBox2.Checked){
    $button1.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю WinRaR")
    Invoke-WebRequest -Uri $WinRaR_download -OutFile $winrar_path
    $button1.Text = "Готово"
    $checkedListBox1.Items.Add("WinRaR")
    $listBox1.Items.Clear();
    }

    if ($checkBox3.Checked){
    $button1.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Naps2") 
    Invoke-WebRequest -Uri $naps2_download -OutFile $naps2_path
    $button1.Text = "Готово"
    $checkedListBox1.Items.Add("Naps2")
    $listBox1.Items.Clear();
    }

    if ($checkBox13.Checked){
    $button1.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Yandex") 
    Invoke-WebRequest -Uri $Yandex_download -OutFile $Yandex_path
    $button1.Text = "Готово"
    $checkedListBox1.Items.Add("Yandex")
    $listBox1.Items.Clear();
    }
    
    if ($checkBox14.Checked){
    $button1.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Chrome")
    Invoke-WebRequest -Uri $Chrome_download -OutFile $Chrome_path
    $button1.Text = "Готово"
    $checkedListBox1.Items.Add("Chrome")
    $listBox1.Items.Clear();
    }

    if ($checkBox15.Checked){
    $button1.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Office")
    Invoke-WebRequest -Uri $Office_download -OutFile $Office_path
    $button1.Text = "Готово"
    $checkedListBox1.Items.Add("Office")
    $listBox1.Items.Clear();
    }

    if ( !$checkBox1.Checked -and !$checkBox2.Checked -and !$checkBox3.Checked -and !$checkBox13.Checked -and !$checkBox14.Checked -and !$checkBox15.Checked) {   $listBox1.Items.Add("Ничего не выбрано")} 
}

#Обработчик2
$handler_button2_Click= 
{
    $listBox1.Items.Clear();

    if ($checkBox4.Checked){
    $button2.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Крипто-Про")
    Invoke-WebRequest -Uri $Crypto_download -OutFile $Crypto_path
    $button2.Text = "Готово"
    $checkedListBox1.Items.Add("Крипто-Про")
    $listBox1.Items.Clear();
    }

    if ($checkBox5.Checked){
    $button2.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Крипто-Плагин")
    Invoke-WebRequest -Uri $Cryptoplug_download -OutFile $Cryptoplug_path
    $button2.Text = "Готово"
    $checkedListBox1.Items.Add("Крипто-Плагин")
    $listBox1.Items.Clear();
    }

    if ($checkBox6.Checked){
    $button2.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Рутокен") 
    Invoke-WebRequest -Uri $rutoken_download -OutFile $rutoken_path
    Invoke-WebRequest -Uri $rutokenplug_download -OutFile $rutokenplug_path
    $button2.Text = "Готово"
    $checkedListBox1.Items.Add("Рутокен")
    $listBox1.Items.Clear();
    }

    if ( !$checkBox4.Checked -and !$checkBox5.Checked -and !$checkBox6.Checked) {   $listBox1.Items.Add("Ничего не выбрано")} 
}

#Обработчик3
$handler_button3_Click= 
{
    $listBox1.Items.Clear();

    if ($checkBox8.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Kyocer")
    Invoke-WebRequest -Uri $kyocer_download -OutFile $kyocer_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Kyocer")
    $listBox1.Items.Clear();
    }

    if ($checkBox9.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Kyocer 1020 mfp")
    Invoke-WebRequest -Uri $kyocer1020_download -OutFile $kyocer1020_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Kyocer 1020 mfp")
    $listBox1.Items.Clear();
    }

    if ($checkBox16.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Kyocer Twain") 
    Invoke-WebRequest -Uri $kyocertwain_download -OutFile $kyocertwain_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Kyocer Twain")
    $listBox1.Items.Clear();
    }

    if ($checkBox17.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Ricoh") 
    Invoke-WebRequest -Uri $Ricoh_download -OutFile $ricoh_path
    Invoke-WebRequest -Uri $ricohhtwain_download -OutFile $ricohtwain_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Ricoh")
    $listBox1.Items.Clear();
    }
    
    if ($checkBox18.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Canon")
    Invoke-WebRequest -Uri $canon_download -OutFile $canon_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Canon")
    $listBox1.Items.Clear();
    }

    if ($checkBox19.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю HP")
    Invoke-WebRequest -Uri $hp_download -OutFile $hp_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("HP")
    $listBox1.Items.Clear();
    }

    if ($checkBox20.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Xerox")
    Invoke-WebRequest -Uri $xerox_download -OutFile $xerox_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Xerox")
    $listBox1.Items.Clear();
    }

    if ($checkBox21.Checked){
    $button3.Text = "Скачиваю.."
    $listBox1.Items.Add("Скачиваю Pantum")
    Invoke-WebRequest -Uri $pantum_download -OutFile $pantum_path
    $button3.Text = "Готово"
    $checkedListBox1.Items.Add("Pantum")
    $listBox1.Items.Clear();
    }

    if ( !$checkBox1.Checked -and !$checkBox2.Checked -and !$checkBox3.Checked -and !$checkBox13.Checked -and !$checkBox14.Checked -and !$checkBox15.Checked -and !$checkBox15.Checked) {   $listBox1.Items.Add("Ничего не выбрано")} 
}


#Обработчик4
$handler_button4_Click= 
{
    $listBox1.Items.Clear();

    if ($checkBox11.Checked){
    $button2.Text = "Активация.."
    $listBox1.Items.Add("Идет Активация")
    irm  https://massgrave.dev/get| iex
    $button2.Text = "Готово"
    $checkedListBox1.Items.Add("Активация")
    $listBox1.Items.Clear();
    }

    else { $listBox1.Items.Add("Ничего не выбрано")} 
}

#Иконки
$code = @"
using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace System
{
	public class IconExtractor
	{

	 public static Icon Extract(string file, int number, bool largeIcon)
	 {
	  IntPtr large;
	  IntPtr small;
	  ExtractIconEx(file, number, out large, out small, 1);
	  try
	  {
	   return Icon.FromHandle(largeIcon ? large : small);
	  }
	  catch
	  {
	   return null;
	  }

	 }
	 [DllImport("Shell32.dll", EntryPoint = "ExtractIconExW", CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
	 private static extern int ExtractIconEx(string sFile, int iIndex, out IntPtr piLargeVersion, out IntPtr piSmallVersion, int amountIcons);

	}
}
"@
Add-Type -TypeDefinition $code -ReferencedAssemblies System.Drawing
#Изменение курсора
$checkbox1.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox1.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox2.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox2.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox3.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox3.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox4.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox4.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox5.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox5.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox6.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox6.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox7.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox7.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox8.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox8.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox9.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox9.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})
$checkbox11.Add_MouseEnter({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Hand
})
$checkbox11.Add_MouseLeave({
    $Form1.Cursor = [System.Windows.Forms.Cursors]::Arrow
})

$banner = New-Object System.Windows.Forms.NotifyIcon
$ico = "$env:WINDIR\system32\WindowsPowerShell\v1.0\powershell.exe"
$banner.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($ico)
$banner.BalloonTipIcon  = [System.Windows.Forms.ToolTipIcon]'Info'
$banner.BalloonTipTitle = 'Установка завершена'
$banner.BalloonTipText  = 'Можно продолжать работу'
$banner.Visible = $true

$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop

#
# tabControl1
#
$tabControl1.Controls.Add($tabPage1)
$tabControl1.Controls.Add($tabPage2)
$tabControl1.Controls.Add($tabPage3)
$tabControl1.Controls.Add($tabPage4)
$tabControl1.Location = New-Object System.Drawing.Point(12, 36)
$tabControl1.Name = "tabControl1"
$tabControl1.Size = New-Object System.Drawing.Size(444, 274)
$tabControl1.TabIndex = 4
#
# tabPage1
#
$tabPage1.Controls.Add($progressBar1)
$tabPage1.Controls.Add($button1)
$tabPage1.Controls.Add($checkBox15)
$tabPage1.Controls.Add($checkBox14)
$tabPage1.Controls.Add($checkBox13)
$tabPage1.Controls.Add($checkBox3)
$tabPage1.Controls.Add($checkBox2)
$tabPage1.Controls.Add($checkBox1)
$tabPage1.Font = New-Object System.Drawing.Font("Calibri", 9,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$tabPage1.Location = New-Object System.Drawing.Point(4, 22)
$tabPage1.Name = "tabPage1"
$tabPage1.Padding = New-Object System.Windows.Forms.Padding(3)
$tabPage1.Size = New-Object System.Drawing.Size(436, 248)
$tabPage1.TabIndex = 0
$tabPage1.Text = "Основные"
$tabPage1.UseVisualStyleBackColor = $true
#
# tabPage2
#
$tabPage2.Controls.Add($checkBox6)
$tabPage2.Controls.Add($progressBar2)
$tabPage2.Controls.Add($checkBox5)
$tabPage2.Controls.Add($checkBox4)
$tabPage2.Controls.Add($button2)
$tabPage2.Font = New-Object System.Drawing.Font("Calibri", 9,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$tabPage2.Location = New-Object System.Drawing.Point(4, 22)
$tabPage2.Name = "tabPage2"
$tabPage2.Padding = New-Object System.Windows.Forms.Padding(3)
$tabPage2.Size = New-Object System.Drawing.Size(436, 248)
$tabPage2.TabIndex = 1
$tabPage2.Text = "Дополнительные"
$tabPage2.UseVisualStyleBackColor = $true
#
# tabPage3
#
$tabPage3.Controls.Add($checkBox9)
$tabPage3.Controls.Add($checkBox16)
$tabPage3.Controls.Add($checkBox17)
$tabPage3.Controls.Add($checkBox18)
$tabPage3.Controls.Add($checkBox19)
$tabPage3.Controls.Add($checkBox20)
$tabPage3.Controls.Add($checkBox21)
$tabPage3.Controls.Add($checkBox8)
$tabPage3.Controls.Add($progressBar3)
$tabPage3.Controls.Add($button3)
$tabPage3.Font = New-Object System.Drawing.Font("Calibri", 9,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$tabPage3.Location = New-Object System.Drawing.Point(4, 22)
$tabPage3.Name = "tabPage3"
$tabPage3.Padding = New-Object System.Windows.Forms.Padding(3)
$tabPage3.Size = New-Object System.Drawing.Size(436, 248)
$tabPage3.TabIndex = 2
$tabPage3.Text = "Драйвера"
$tabPage3.UseVisualStyleBackColor = $true
#
# tabPage4
#
$tabPage4.Controls.Add($checkBox11)
$tabPage4.Controls.Add($progressBar4)
$tabPage4.Controls.Add($button4)
$tabPage4.Font = New-Object System.Drawing.Font("Calibri", 9,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$tabPage4.Location = New-Object System.Drawing.Point(4, 22)
$tabPage4.Name = "tabPage4"
$tabPage4.Padding = New-Object System.Windows.Forms.Padding(3)
$tabPage4.Size = New-Object System.Drawing.Size(436, 248)
$tabPage4.TabIndex = 3
$tabPage4.Text = "Активация"
$tabPage4.UseVisualStyleBackColor = $true

#
# button7
#
$button7.Location = New-Object System.Drawing.Point(10, 390)
$button7.Name = "button7"
$button7.Size = New-Object System.Drawing.Size(40, 38)
$button7.Image = [System.Drawing.SystemIcons]::Information
$button7.UseVisualStyleBackColor = $true
$button7.add_Click({About})

function About{
    
    $iconPS   = [Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)
    $aboutForm          = New-Object System.Windows.Forms.Form
    $aboutFormExit      = New-Object System.Windows.Forms.Button
    $aboutFormImage     = New-Object System.Windows.Forms.PictureBox
    $aboutFormNameLabel = New-Object System.Windows.Forms.Label
    $aboutFormText      = New-Object System.Windows.Forms.Label

    
    $aboutForm.AcceptButton  = $aboutFormExit
    $aboutForm.CancelButton  = $aboutFormExit
    $aboutForm.ClientSize    = "350, 110"
    $aboutForm.ControlBox    = $false
    $aboutForm.ShowInTaskBar = $false
    $aboutForm.StartPosition = "CenterParent"
    $aboutForm.Text          = "Информация о программе"
    $aboutForm.Add_Load($aboutForm_Load)

    
    $aboutFormImage.Image    = $iconPS.ToBitmap()
    $aboutFormImage.Location = "55, 15"
    $aboutFormImage.Size     = "32, 32"
    $aboutFormImage.SizeMode = "StretchImage"
    $aboutForm.Controls.Add($aboutFormImage)

    
    $aboutFormNameLabel.Font     = New-Object Drawing.Font("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
    $aboutFormNameLabel.Location = "110, 20"
    $aboutFormNameLabel.Size     = "200, 18"
    $aboutFormNameLabel.Text     = "Программу создал -"
    $aboutForm.Controls.Add($aboutFormNameLabel)

    
    $aboutFormText.Location = "100, 40"
    $aboutFormText.Size     = "300, 30"
    $aboutFormText.Text     = "               Dem1ch `n`r   Для определенных лиц"
    $aboutForm.Controls.Add($aboutFormText)

    
    $aboutFormExit.Location = "135, 70"
    $aboutFormExit.Text     = "ОК"
    $aboutForm.Controls.Add($aboutFormExit)

    [void]$aboutForm.ShowDialog()
}

#
# checkedListBox1
#
$checkedListBox1.FormattingEnabled = $true
#$checkedListBox1.Items.AddRange(@())
$checkedListBox1.Location = New-Object System.Drawing.Point(485, 36)
$checkedListBox1.Name = "checkedListBox1"
$checkedListBox1.Size = New-Object System.Drawing.Size(163, 274)
$checkedListBox1.TabIndex = 6
#
# checkBox1
#
$checkBox1.AutoSize = $true
$checkBox1.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox1.Location = New-Object System.Drawing.Point(10, 18)
$checkBox1.Name = "checkBox1"
$checkBox1.Size = New-Object System.Drawing.Size(77, 22)
$checkBox1.TabIndex = 0
$checkBox1.Text = "Adobe Reader"
$checkBox1.UseVisualStyleBackColor = $true
#
# label1
#
$label1.AutoSize = $true
$label1.BackColor = [System.Drawing.SystemColors]::ButtonHighlight
$label1.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point, 204)
$label1.ForeColor = [System.Drawing.Color]::FromArgb(64,64,64)
$label1.Location = New-Object System.Drawing.Point(12, 9)
$label1.Name = "label1"
$label1.Size = New-Object System.Drawing.Size(75, 18)
$label1.TabIndex = 7
$label1.Text = "Программы"
#
# label2
#
$label2.AutoSize = $true
$label2.BackColor = [System.Drawing.SystemColors]::ButtonHighlight
$label2.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point, 204)
$label2.ForeColor = [System.Drawing.Color]::FromArgb(64,64,64)
$label2.Location = New-Object System.Drawing.Point(521, 10)
$label2.Name = "label2"
$label2.Size = New-Object System.Drawing.Size(83, 18)
$label2.TabIndex = 8
$label2.Text = "Скачаны"
#
# checkBox2
#
$checkBox2.AutoSize = $true
$checkBox2.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox2.Location = New-Object System.Drawing.Point(10, 98)
$checkBox2.Name = "checkBox2"
$checkBox2.Size = New-Object System.Drawing.Size(75, 22)
$checkBox2.TabIndex = 2
$checkBox2.Text = "WinRaR"
$checkBox2.UseVisualStyleBackColor = $true

#
# checkBox3
#
$checkBox3.AutoSize = $true
$checkBox3.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox3.Location = New-Object System.Drawing.Point(10, 57)
$checkBox3.Name = "checkBox3"
$checkBox3.Size = New-Object System.Drawing.Size(70, 22)
$checkBox3.TabIndex = 3
$checkBox3.Text = "Naps2"
$checkBox3.UseVisualStyleBackColor = $true

#
# checkBox13
#
$checkBox13.AutoSize = $true
$checkBox13.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox13.Location = New-Object System.Drawing.Point(10, 139)
$checkBox13.Name = "checkBox13"
$checkBox13.Size = New-Object System.Drawing.Size(70, 22)
$checkBox13.Text = "Yandex"
$checkBox13.UseVisualStyleBackColor = $true

#
# checkBox14
#
$checkBox14.AutoSize = $true
$checkBox14.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox14.Location = New-Object System.Drawing.Point(140, 18)
$checkBox14.Name = "checkBox14"
$checkBox14.Size = New-Object System.Drawing.Size(70, 22)
$checkBox14.Text = "Chrome"
$checkBox14.UseVisualStyleBackColor = $true

#
# checkBox15
#
$checkBox15.AutoSize = $true
$checkBox15.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox15.Location = New-Object System.Drawing.Point(140, 57)
$checkBox15.Name = "checkBox15"
$checkBox15.Size = New-Object System.Drawing.Size(70, 22)
$checkBox15.Text = "Office"
$checkBox15.UseVisualStyleBackColor = $true

#
# button1
#
$button1.BackColor = [System.Drawing.Color]::MistyRose
$button1.Font = New-Object System.Drawing.Font("Calibri", 12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$button1.ForeColor = [System.Drawing.Color]::DarkRed
$button1.Location = New-Object System.Drawing.Point(159, 174)
$button1.Name = "button1"
$button1.Size = New-Object System.Drawing.Size(107, 31)
$button1.TabIndex = 4
$button1.AutoSize = $true
$button1.Text = "Выполнить"
$button1.UseVisualStyleBackColor = $false
$button1.add_Click($handler_button1_Click)
#
# button2
#
$button2.BackColor = [System.Drawing.Color]::MistyRose
$button2.Font = New-Object System.Drawing.Font("Calibri", 12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$button2.ForeColor = [System.Drawing.Color]::DarkRed
$button2.Location = New-Object System.Drawing.Point(159, 174)
$button2.Name = "button2"
$button2.Size = New-Object System.Drawing.Size(107, 31)
$button2.TabIndex = 5
$button2.AutoSize = $true
$button2.Text = "Выполнить"
$button2.UseVisualStyleBackColor = $false
$button2.add_Click($handler_button2_Click)
#
# button3
#
$button3.BackColor = [System.Drawing.Color]::MistyRose
$button3.Font = New-Object System.Drawing.Font("Calibri", 12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$button3.ForeColor = [System.Drawing.Color]::DarkRed
$button3.Location = New-Object System.Drawing.Point(159, 174)
$button3.Name = "button3"
$button3.Size = New-Object System.Drawing.Size(107, 31)
$button3.TabIndex = 6
$button3.Text = "Выполнить"
$button3.AutoSize = $true
$button3.UseVisualStyleBackColor = $false
$button3.add_Click($handler_button3_Click)
#
# button4
#
$button4.BackColor = [System.Drawing.Color]::MistyRose
$button4.Font = New-Object System.Drawing.Font("Calibri", 12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$button4.ForeColor = [System.Drawing.Color]::DarkRed
$button4.Location = New-Object System.Drawing.Point(159, 174)
$button4.Name = "button4"
$button4.Size = New-Object System.Drawing.Size(107, 31)
$button4.TabIndex = 7
$button4.Text = "Выполнить"
$button4.AutoSize = $true
$button4.UseVisualStyleBackColor = $false
$button4.add_Click($handler_button4_Click)
#
# checkBox4
#
$checkBox4.AutoSize = $true
$checkBox4.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 204)
$checkBox4.Location = New-Object System.Drawing.Point(10, 18)
$checkBox4.Name = "checkBox4"
$checkBox4.Size = New-Object System.Drawing.Size(87, 22)
$checkBox4.TabIndex = 6
$checkBox4.Text = "Крипто-Про"
$checkBox4.UseVisualStyleBackColor = $true
#
# checkBox5
#
$checkBox5.AutoSize = $true
$checkBox5.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox5.Location = New-Object System.Drawing.Point(10, 58)
$checkBox5.Name = "checkBox5"
$checkBox5.Size = New-Object System.Drawing.Size(147, 22)
$checkBox5.TabIndex = 7
$checkBox5.Text = "Крипто-Плагин"
$checkBox5.UseVisualStyleBackColor = $true
#
# progressBar3
#
$progressBar3.Location = New-Object System.Drawing.Point(5, 211)
$progressBar3.Name = "progressBar3"
$progressBar3.Size = New-Object System.Drawing.Size(427, 31)
$progressBar3.TabIndex = 7
#
# progressBar4
#
$progressBar4.Location = New-Object System.Drawing.Point(5, 211)
$progressBar4.Name = "progressBar4"
$progressBar4.Size = New-Object System.Drawing.Size(427, 31)
$progressBar4.TabIndex = 8
#
# progressBar2
#
$progressBar2.Location = New-Object System.Drawing.Point(5, 211)
$progressBar2.Name = "progressBar2"
$progressBar2.Size = New-Object System.Drawing.Size(427, 31)
$progressBar2.TabIndex = 8
#
# progressBar1
#
$progressBar1.Location = New-Object System.Drawing.Point(5, 211)
$progressBar1.Name = "progressBar1"
$progressBar1.Size = New-Object System.Drawing.Size(427, 31)
$progressBar1.TabIndex = 6
#
# checkBox6
#
$checkBox6.AutoSize = $true
$checkBox6.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox6.Location = New-Object System.Drawing.Point(10, 98)
$checkBox6.Name = "checkBox6"
$checkBox6.Size = New-Object System.Drawing.Size(153, 22)
$checkBox6.Text = "Рутокен"
$checkBox6.UseVisualStyleBackColor = $true
#
# checkBox8
#
$checkBox8.AutoSize = $true
$checkBox8.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox8.Location = New-Object System.Drawing.Point(10, 18)
$checkBox8.Name = "checkBox8"
$checkBox8.Size = New-Object System.Drawing.Size(120, 22)
$checkBox8.Text = "Kyocer"
$checkBox8.UseVisualStyleBackColor = $true
#
# checkBox9
#
$checkBox9.AutoSize = $true
$checkBox9.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox9.Location = New-Object System.Drawing.Point(10, 58)
$checkBox9.Name = "checkBox9"
$checkBox9.Size = New-Object System.Drawing.Size(120, 22)
$checkBox9.Text = "Kyocer 1020 mfp"
$checkBox9.UseVisualStyleBackColor = $true
#
# checkBox16
#
$checkBox16.AutoSize = $true
$checkBox16.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox16.Location = New-Object System.Drawing.Point(10, 98)
$checkBox16.Name = "checkBox16"
$checkBox16.Size = New-Object System.Drawing.Size(120, 22)
$checkBox16.Text = "Kyocer Twain"
$checkBox16.UseVisualStyleBackColor = $true
#
# checkBox17
#
$checkBox17.AutoSize = $true
$checkBox17.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox17.Location = New-Object System.Drawing.Point(10, 138)
$checkBox17.Name = "checkBox17"
$checkBox17.Size = New-Object System.Drawing.Size(120, 22)
$checkBox17.Text = "Ricoh"
$checkBox17.UseVisualStyleBackColor = $true
#
# checkBox18
#
$checkBox18.AutoSize = $true
$checkBox18.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox18.Location = New-Object System.Drawing.Point(160, 18)
$checkBox18.Name = "checkBox18"
$checkBox18.Size = New-Object System.Drawing.Size(120, 22)
$checkBox18.Text = "Canon"
$checkBox18.UseVisualStyleBackColor = $true
#
# checkBox19
#
$checkBox19.AutoSize = $true
$checkBox19.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox19.Location = New-Object System.Drawing.Point(160, 58)
$checkBox19.Name = "checkBox19"
$checkBox19.Size = New-Object System.Drawing.Size(120, 22)
$checkBox19.Text = "HP"
$checkBox19.UseVisualStyleBackColor = $true
#
# checkBox20
#
$checkBox20.AutoSize = $true
$checkBox20.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox20.Location = New-Object System.Drawing.Point(160, 98)
$checkBox20.Name = "checkBox20"
$checkBox20.Size = New-Object System.Drawing.Size(120, 22)
$checkBox20.Text = "Xerox"
$checkBox20.UseVisualStyleBackColor = $true
#
# checkBox21
#
$checkBox21.AutoSize = $true
$checkBox21.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox21.Location = New-Object System.Drawing.Point(160, 138)
$checkBox21.Name = "checkBox21"
$checkBox21.Size = New-Object System.Drawing.Size(120, 22)
$checkBox21.Text = "Pantum"
$checkBox21.UseVisualStyleBackColor = $true
#
# checkBox11
#
$checkBox11.AutoSize = $true
$checkBox11.Font = New-Object System.Drawing.Font("Calibri", 11.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point, 0)
$checkBox11.Location = New-Object System.Drawing.Point(10, 18)
$checkBox11.Name = "checkBox11"
$checkBox11.Size = New-Object System.Drawing.Size(155, 22)
$checkBox11.Text = "Активация Windows/Office"
$checkBox11.UseVisualStyleBackColor = $true
#
# Form1
#
$Form1.BackColor = [System.Drawing.SystemColors]::ActiveCaption
$Form1.ClientSize = New-Object System.Drawing.Size(677, 431)
$Form1.Controls.Add($label2)
$Form1.Controls.Add($label1)
$Form1.Controls.Add($checkedListBox1)
$Form1.Controls.Add($tabControl1)
$Form1.Controls.Add($button7)
$Form1.Controls.Add($listBox1)
$Form1.Name = "Form1"
$Form1.ShowIcon = $false
$Form1.Text = "Программы для пользователей"
$InitialFormWindowState = $Form1.WindowState
$Form1.add_Load($OnLoadForm_StateCorrection)

$Form1.Add_Shown( { $Form1.Activate()} )
[void] $Form1.ShowDialog()
}
form