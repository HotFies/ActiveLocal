if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
#Путь до скрипта
$scriptPath = $MyInvocation.MyCommand.Definition

function update{
# Параметры
$GitHubUser = "HotFies"
$GitHubRepo = "ActiveLocal"
$FileName = "ActiveLocal.ps1"
$LocalFilePath = "$PSScriptRoot\ActiveLocal.ps1"
$UpdateDateFile = "$PSScriptRoot\LatestUpdate.txt"

# Функция для загрузки файла
function DownloadFile($url, $outputPath) {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($url, $outputPath)
}

# Функция для получения даты последнего коммита файла на GitHub
function Get-LatestCommitDate($user, $repo, $fileName) {
    $url = "https://api.github.com/repos/$user/$repo/commits?path=$fileName"
    $response = Invoke-RestMethod -Uri $url
    return [System.DateTime]::Parse($response[0].commit.author.date)
}

# Проверка существования файла LatestUpdate.txt и выполнение обновления
if (-not (Test-Path $UpdateDateFile)) {
    Write-Host "Скачиваю обновление"
    # Скачивание файла
    $url = "https://raw.githubusercontent.com/$GitHubUser/$GitHubRepo/master/$FileName"
    DownloadFile $url $LocalFilePath
    # Создание файла LatestUpdate.txt и запись даты последнего обновления
    New-Item -ItemType file -Path $UpdateDateFile -Force
    $latestCommitDate = Get-LatestCommitDate $GitHubUser $GitHubRepo $FileName
    Set-Content -Path $UpdateDateFile -Value $latestCommitDate
    # Обновление даты последней модификации файла на дату последнего commit'a
    (Get-Item $LocalFilePath).LastWriteTime = $latestCommitDate
    Write-Host "Файл LatestUpdate.txt создан."
    Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -Wait
    Break
}
else {
    # Получение даты последнего обновления из файла LatestUpdate.txt
    $localLatestUpdate = Get-Content $UpdateDateFile
    # Получение даты последнего коммита файла на GitHub
    $latestCommitDate = Get-LatestCommitDate $GitHubUser $GitHubRepo $FileName

    # Сравнение дат
    if ($latestCommitDate -gt [System.DateTime]::Parse($localLatestUpdate)) {
        # Скачивание файла
        $url = "https://raw.githubusercontent.com/$GitHubUser/$GitHubRepo/master/$FileName"
        DownloadFile $url $LocalFilePath
        # Обновление даты последней модификации файла на дату последнего commit'a
        (Get-Item $LocalFilePath).LastWriteTime = $latestCommitDate
        # Запись новой даты обновления в файл LatestUpdate.txt
        Set-Content -Path $UpdateDateFile -Value $latestCommitDate
        Write-Host "Файл обновлен и дата последнего обновления записана в файл LatestUpdate.txt."
        Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -NoNewWindow
        Break
    }
    else {
        Write-Host "Обновлений нет. Используется прежний код."
    }
}
}
update

Add-Type -AssemblyName System.Windows.Forms
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

#Основные переменные
$player = New-Object System.Media.SoundPlayer
$global:loadingForm = $null
$loadimg = "$PSScriptRoot\Icons\loading.png"
$SoundDone = "$PSScriptRoot\Sounds\Done.wav"
$SoundError = "$PSScriptRoot\Sounds\Error.wav"
$SoundStart = "$PSScriptRoot\Sounds\Start.wav"

function AL{
$form = New-Object System.Windows.Forms.Form
$form.Text = "Удаленное управление"
$form.ShowIcon = $false
$form.Size = New-Object System.Drawing.Size(625, 860)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.BackColor = [System.Drawing.SystemColors]::ActiveCaption

# Создание элемента DataGridView для отображения данных
$dataGridView = New-Object System.Windows.Forms.DataGridView
$dataGridView.Location = New-Object System.Drawing.Point(5, 110)
$dataGridView.Size = New-Object System.Drawing.Size(243, 150)

# Создание заголовков столбцов
$dataGridView.ColumnCount = 2
$dataGridView.Columns[0].Name = "Сервер"
$dataGridView.Columns[1].Name = "Статус"

$imagedata = New-Object System.Windows.Forms.ImageList
$imagedata.ImageSize = New-Object System.Drawing.Size(25,25)
# Изображения онлайна и оффлайна
$imagePath4 = Join-Path $PSScriptRoot "\Icons\online.png"
$imagePath5 = Join-Path $PSScriptRoot "\Icons\offline.png"
$imagedata.Images.Add([System.Drawing.Image]::FromFile($imagePath4))
$imagedata.Images.Add([System.Drawing.Image]::FromFile($imagePath5))

# Добавление данных в таблицу с изображениями
foreach ($server in $serverStatus) {
    $row = $dataGridView.Rows.Add($server.Company)

    # Проверка, есть ли уже изображение в столбце "Статус"
    if (-not $dataGridView.Rows[$row].Cells["Статус"].Value) {
        # Создайте объект DataGridViewImageCell
        $imageCell = New-Object System.Windows.Forms.DataGridViewImageCell

        # Определите, какое изображение использовать в зависимости от статуса сервера
        if ($server.Status -eq "Активен") {
            $imageCell.Value = $imagedata.Images[0]
        } else {
            $imageCell.Value = $imagedata.Images[1]
        }

        # Установите созданный объект DataGridViewImageCell для ячейки столбца "Status"
        $dataGridView.Rows[$row].Cells["Статус"] = $imageCell
    }
}

# Создаем бегущую строки
$RunningLabel = New-Object System.Windows.Forms.Label
$RunningLabel.Location = New-Object System.Drawing.Point(0, 795)
$RunningLabel.Size = New-Object System.Drawing.Size(300, 20)
$RunningLabel.Text = "By Dem1ch"
$RunningLabel.ForeColor = [System.Drawing.Color]::Black
$RunningLabel.TextAlign = [System.Drawing.ContentAlignment]::BottomRight

# Определяем скорость бегущей строки (сколько пикселей сдвигается за один шаг)
$Speed = 2

# Создаем таймер для обновления метки
$Timer = New-Object System.Windows.Forms.Timer
$Timer.Interval = 20  # Интервал обновления в миллисекундах
$Timer.Add_Tick({
    $RunningLabel.Left -= $Speed  # Сдвигаем метку влево
    if ($RunningLabel.Left + $RunningLabel.Width -le 0) {  # Если метка ушла за пределы формы
        $RunningLabel.Left = ($Form.Width - 270) # Перемещаем метку вправо за границу формы
    }
})

$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.Size = New-Object System.Drawing.Size(355, 150)
$checkedListBox.Location = New-Object System.Drawing.Point(10, 40)

# Добавим в начало списка элемент "Выбрать все"
$checkedListBox.Items.Add("Выбрать все")

foreach ($server in $activeServers) {
    $checkedListBox.Items.Add($server.Company)
}

# Добавим обработчик события для того чтобы выбрать или снять выбор всех элементов
$checkedListBox.Add_ItemCheck({
    param(
        [System.Object]$sender,
        [System.Windows.Forms.ItemCheckEventArgs]$e
    )

    # Проверка, выбран ли элемент "Выбрать все"
    if ($e.Index -eq 0) {
        # Если "Выбрать все" выбран, выбрать/отменить выбор всех остальных элементов
        $selectedState = $e.NewValue
        for ($i = 1; $i -lt $checkedListBox.Items.Count; $i++) {
            $checkedListBox.SetItemChecked($i, $selectedState)
        }
    }
})

$checkedListBox2 = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox2.Size = New-Object System.Drawing.Size(200, 150)
$checkedListBox2.Location = New-Object System.Drawing.Point(375, 40)

$checkedListBox2.Items.Add("Получить список пользователей")
$checkedListBox2.Items.Add("Добавить пользователя")
$checkedListBox2.Items.Add("Блокировка пользователя")
$checkedListBox2.Items.Add("Разблокировать пользователя")
$checkedListBox2.Items.Add("Изменить пользователя")
$checkedListBox2.Items.Add("Изменить группу пользователя")
$checkedListBox2.Items.Add("Узнать статус учетки")

$checkedListBox2.Add_ItemCheck({
    param(
        [System.Object]$s,
        [System.Windows.Forms.ItemCheckEventArgs]$e
    )

    # Проверяем, что состояние элемента меняется на "Checked"
    if ($e.NewValue -eq "Checked") {
        # Отменяем выбор всех остальных элементов
        for ($i = 0; $i -lt $checkedListBox2.Items.Count; $i++) {
            if ($i -ne $e.Index) {
                $checkedListBox2.SetItemChecked($i, $false)
            }
        }
    }

    # Проверяем, выбрано ли действие "Получить список пользователей"
    $actionIsGetUsers = "Получить список пользователей" -eq $checkedListBox2.Items[$e.Index]

    # Устанавливаем видимость элементов в зависимости от выбранного действия
    $textBox.Visible = !$actionIsGetUsers
    $labelText.Visible = !$actionIsGetUsers

    # Показываем checkedListBox3, если выбрано одно из определенных действий
    $checkedListBox3.Visible = ("Добавить пользователя","Изменить группу пользователя" -contains $checkedListBox2.Items[$e.Index])
    $labelGroup.Visible = ("Добавить пользователя","Изменить группу пользователя" -contains $checkedListBox2.Items[$e.Index])

})

$checkedListBox3 = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox3.Size = New-Object System.Drawing.Size(200, 150)
$checkedListBox3.Location = New-Object System.Drawing.Point(375, 290)
$checkedListBox3.Items.Add("Удалить из групп")
$checkedListBox3.Items.Add("Пользователи УРС")
$checkedListBox3.Items.Add("Пользователи")
$checkedListBox3.Items.Add("Администраторы")
$checkedListBox3.Visible = $false

$checkedListBox3.Add_ItemCheck({
    param(
        [System.Object]$s,
        [System.Windows.Forms.ItemCheckEventArgs]$e
    )

    # Проверяем, что состояние элемента меняется на "Checked"
    if ($e.NewValue -eq "Checked") {
        # Отменяем выбор всех остальных элементов
        for ($i = 0; $i -lt $checkedListBox3.Items.Count; $i++) {
            if ($i -ne $e.Index) {
                $checkedListBox3.SetItemChecked($i, $false)
            }
        }
    }
})

#Создаем Labels
$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Text = "Информация"
$labelStatus.Location = New-Object System.Drawing.Point(125, 260)
$labelStatus.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelStatus.AutoSize = $true

$labelServers = New-Object System.Windows.Forms.Label
$labelServers.Text = "Сервера"
$labelServers.Location = New-Object System.Drawing.Point(155,10)
$labelServers.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelServers.AutoSize = $true

$labelActions = New-Object System.Windows.Forms.Label
$labelActions.Text = "Действия"
$labelActions.Location = New-Object System.Drawing.Point(440,10)
$labelActions.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelActions.AutoSize = $true

$labelText = New-Object System.Windows.Forms.Label
$labelText.Text = "Ввод"
$labelText.Location = New-Object System.Drawing.Point(155,195)
$labelText.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelText.Visible = $false
$labelText.AutoSize = $true

$labelGroup = New-Object System.Windows.Forms.Label
$labelGroup.Text = "Группы"
$labelGroup.Location = New-Object System.Drawing.Point(450,260)
$labelGroup.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelGroup.Visible = $false
$labelGroup.AutoSize = $true

# Создание TextBox
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 220)
$textBox.Size = New-Object System.Drawing.Size(355, 20)
$textBox.Visible = $false
$textBox.Text = "Введите текст..."

$textBox.Add_Enter({
    # Очищаем текстовое поле при вводе текста
    $textBox.Clear()
})


$button1 = New-Object System.Windows.Forms.Button
$button1.Size = New-Object System.Drawing.Size(100, 35)
$button1.Location = New-Object System.Drawing.Point(475, 200)
$button1.Text = "Очистить инфу"
$button1.Add_Click({
    $listBox.Items.Clear()
})

$button2 = New-Object System.Windows.Forms.Button
$button2.Size = New-Object System.Drawing.Size(100, 35)
$button2.Location = New-Object System.Drawing.Point(375, 200)
$button2.Text = "Выполнить"

$button2.Add_Click({
    $selectedAction = $checkedListBox2.CheckedItems
    $selectedServers = $checkedListBox.CheckedItems
    if ($selectedAction.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Выберите действие", "Ошибка")
        return}
    if ($selectedServers.Count -eq 0){
        [System.Windows.Forms.MessageBox]::Show("Выберите сервер", "Ошибка")
        return}
    # Проверяем, что выбрана группа для определенных действий
    $actionNeedsGroup = ("Добавить пользователя","Изменить группу пользователя" -contains $selectedAction[0].ToString())
    if ($actionNeedsGroup -and $checkedListBox3.CheckedItems.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Выберите группу", "Ошибка")
        return
    }
    $selectedGroups = $checkedListBox3.CheckedItems | ForEach-Object { $_.ToString() }
    $group = $selectedGroups -join ", "
    $listBox.Items.Clear()

    for ($i = 1; $i -lt $checkedListBox.Items.Count; $i++) {
        if ($checkedListBox.GetItemCheckState($i) -eq "Checked") {
            $company = $checkedListBox.Items[$i]
            $credentials = $companyAndCredentials[$company]
            $sessionOption = New-PSSessionOption -SkipCNCheck
            $ip = $credentials["IP"]
            $username = $credentials["Username"]
            $password = $credentials["Password"]
            $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
            $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

            $action = $selectedAction[0].ToString()

            # Берем имя пользователя из TextBox
            $username = $textBox.Text

            # Проверяем, занесено ли действие Блокировать пользователя
            $actionIsNotGetUsers = "Получить список пользователей" -ne $selectedAction[0].ToString()

            # Проверяем, что пользователь ввел имя
            if ($actionIsNotGetUsers -and (-not $username -or $username.Equals("Введите текст..."))) {
                [System.Windows.Forms.MessageBox]::Show("Введите имя пользователя", "Ошибка")
                return
            }

        switch ($action) {
            "Получить список пользователей" {
                $listBox.Items.Add("Получение списка пользователей на $company...")
                $scriptBlock = {
                    $users = Get-LocalUser
                    foreach ($user in $users) {
                        $blockedStatus = if ($user.Enabled -eq $false) { "Заблокирован" } else { "Не заблокирован" }
                        $userInfo = $user.Name + " - " + $blockedStatus
                        $userInfo}
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                        $listBox.Items.Add($_)}
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")}
            }
            "Добавить пользователя" {
                $listBox.Items.Add("Добавление пользователя на $company...")
                $userInfo = $textBox.Text -split "\t"
                if($userInfo.Count -ne 3) {
                    $listBox.Items.Add("Ошибка в входных данных")
                    return
                }
                $usernameToAdd = $userInfo[0]
                $passwordToAdd = $userInfo[1]
                $descriptionToAdd = $userInfo[2]
                $scriptBlock = {
                    $existingUser = Get-LocalUser -Name $using:usernameToAdd -ErrorAction SilentlyContinue
                    if($null -eq $existingUser) {
                        if (!($using:group -contains "Удалить из групп")){
                            $UserParams = @{
                                'Name'        = $using:usernameToAdd
                                'FullName'    = $using:usernameToAdd
                                'Description' = $using:descriptionToAdd
                                'Password'    = (ConvertTo-SecureString -String $using:passwordToAdd -AsPlainText -Force)
                                'UserMayNotChangePassword' = $true
                                'PasswordNeverExpires' = $true
                            }
                            $newUser = New-LocalUser @UserParams
                            "Пользователь $using:usernameToAdd добавлен на сервер"
                            $groupNamesMap = @{
                                "Удалить из групп" = $null
                                "Пользователи УРС" = @("Пользователи удаленного рабочего стола", "Remote Desktop Users")
                                "Пользователи" = @("Пользователи", "Users")
                                "Администраторы" = @("Администраторы", "Administrators")
                            }
                        if ($groupNamesMap.ContainsKey($using:group)) {
                            try {
                                Add-LocalGroupMember -Group $groupNamesMap[$using:group][0] -Member $using:usernameToAdd -ErrorAction Stop
                                "Пользователю добавлена группа " +$groupNamesMap[$using:group][0]
                            } catch {
                                try {
                                    Add-LocalGroupMember -Group $groupNamesMap[$using:group][1] -Member $using:usernameToAdd -ErrorAction Stop
                                    "Пользователю добавлена группа " +$groupNamesMap[$using:group][1]
                                } catch {
                                    "Не удалось добавить пользователя в группу $using:group"
                                }
                            }
                        } else {
                            "Выбрана недопустимая группа: $using:group"
                        }
                        } else{
                            "Нельзя выбрать опцию 'Удалить из групп'"
                        }
                    } else {
                        "Пользователь $using:usernameToAdd уже существует"
                    }
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                        $listBox.Items.Add("$_")
                    }
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")}
            }
            "Блокировка пользователя" {
                $listBox.Items.Add("Блокировка пользователя на $company...")
                $scriptBlock = {
                    $user = Get-LocalUser -Name $using:userName
                    if ($user -ne $null) {
                        if ($user.Enabled -eq $true) {
                            # Если пользователь не заблокирован, блокируем его
                            Disable-LocalUser -Name $using:userName
                            "Пользователь $($user.Name) теперь заблокирован"
                        } else {
                            # Если пользователь уже заблокирован
                            "Пользователь $($user.Name) уже заблокирован"
                        }
                    } else {
                        "Пользователь $($using:userName) не найден."}
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                        $listBox.Items.Add("$_")}
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")
                }
            }
            "Изменить пользователя" {
                $listBox.Items.Add("Изменение пользователя на $company...")
                $userInfo = $textBox.Text -split "\t"
                if($userInfo.Count -ne 3) {
                    $listBox.Items.Add("Ошибка в входных данных")
                    return
                }
                $usernameToLocal = $userInfo[0]
                $passwordToChange = $userInfo[1]
                $descriptionToChange = $userInfo[2]
                $securePasswordToChange = ConvertTo-SecureString -String $passwordToChange -AsPlainText -Force
                $scriptBlock = {
                    $existingUser = Get-LocalUser -Name $using:usernameToLocal -ErrorAction SilentlyContinue
                    if($null -ne $existingUser) {
                        $existingUser | Set-LocalUser -Password $using:securePasswordToChange -Description $using:descriptionToChange -ErrorAction SilentlyContinue
                        "Пользователь $using:usernameToLocal изменен"
                    } else {
                        "Пользователь $using:usernameToLocal не существует"
                    }
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                        $listBox.Items.Add("$_")
                    }
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")}
            }
            "Изменить группу пользователя" {
                $listBox.Items.Add("Изменение группы пользователя на $company...")
                $scriptBlock = {
                    $user = Get-LocalUser -Name $using:username
                    if ($user -ne $null) {
                        $groupNamesMap = @{
                            "Пользователи УРС" = @("Пользователи удаленного рабочего стола", "Remote Desktop Users")
                            "Пользователи" = @("Пользователи", "Users")
                            "Администраторы" = @("Администраторы", "Administrators")
                        }
                        switch ($using:group) {
                            "Удалить из групп" {
                                try{
                                    Get-LocalGroup | Where-Object { $_ | Get-LocalGroupMember -Member $using:username -ErrorAction SilentlyContinue } | ForEach-Object {Remove-LocalGroupMember -Group $_ -Member $using:username}
                                    "Удалены все группы для пользователя: $using:username"
                                }
                                catch{
                                    "Не удалось удалить пользователя $using:username из групп"
                                }
                            }
                            default {
                                if ($groupNamesMap.ContainsKey($using:group)) {
                                    try {
                                        Add-LocalGroupMember -Group $groupNamesMap[$using:group][0] -Member $using:username -ErrorAction Stop
                                        "Пользователю" +$using:username +" добавлена группа " +$groupNamesMap[$using:group][0]
                                    } catch {
                                        try {
                                            Add-LocalGroupMember -Group $groupNamesMap[$using:group][1] -Member $using:username -ErrorAction Stop
                                            "Пользователю" +$using:username +" добавлена группа " +$groupNamesMap[$using:group][1]
                                        } catch {
                                            "Не удалось добавить в группу $using:group"
                                        }
                                    }
                                } else {
                                   "Выбрана недопустимая группа: $using:group"
                                }
                            }
                        }
                    }
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                        $listBox.Items.Add("$_")
                    }
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")
                }
            }
            "Узнать статус учетки" {
                $listBox.Items.Add("Узнаем статус учетки на - $company...")
                $scriptBlock = {
                    $user = Get-LocalUser -Name $using:userName
                    if ($user -ne $null) {
                        $blockedStatus = if ($user.Enabled -eq $false) { "Заблокирован" } else { "Не заблокирован" }
                        # Получаем группы, в которых находится пользователь
                        $groups = Get-LocalGroup | Where-Object { $_ | Get-LocalGroupMember -Member $user.Name -ErrorAction SilentlyContinue }
                        $groupList = $groups -join ', '
                        "Пользователь $($user.Name) - $blockedStatus"
                        "В группах: $groupList"  # выводим список групп
                    } else {
                        "Пользователь $($using:userName) не найден"
                    }
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                        $listBox.Items.Add("$_")
                    }
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")
                }
            }
            "Разблокировать пользователя" {
                $listBox.Items.Add("Разблокируем пользователя на - $company...")
                $scriptBlock = {
                    $user = Get-LocalUser -Name $using:username
                    if ($user -ne $null) {
                        if ($user.Enabled -eq $false) {
                            #разблокировка пользователя
                            $user | Enable-LocalUser
                            "Пользователь $using:userName разблокирован"
                        } else {
                            "Пользователь $using:userName не заблокирован"
                        }
                    } else {
                        "Пользователь $using:userName не найден"
                    }
                }
                try {
                    Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                    $listBox.Items.Add("$_")}
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Не удалось подключиться к $company")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBox.Items.Add("Ошибка: $errorMessage")
                }
            }
            default {
                # Другие действия...
            }
        }
    }
}
})

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Size = New-Object System.Drawing.Size(340, 450)
$listBox.Location = New-Object System.Drawing.Point(10, 290)

# Создание TabControl
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(600, 780)
$tabControl.Location = New-Object System.Drawing.Point(5, 10)

# Создание ImageList
$imageList = New-Object System.Windows.Forms.ImageList
$imageList.ImageSize = New-Object System.Drawing.Size(25,25) # Установите размер изображения
$imagePath1 = Join-Path $PSScriptRoot "\Icons\users.png"
$imagePath2 = Join-Path $PSScriptRoot "\Icons\comp.png"
$imagePath3 = Join-Path $PSScriptRoot "\Icons\soon.png"
$imageList.Images.Add([System.Drawing.Image]::FromFile($imagePath1))
$imageList.Images.Add([System.Drawing.Image]::FromFile($imagePath2))
$imageList.Images.Add([System.Drawing.Image]::FromFile($imagePath3))

$tabControl.ImageList = $imageList

$tabPage1 = New-Object System.Windows.Forms.TabPage
$tabPage1.ImageIndex = 0 

$tabPage2 = New-Object System.Windows.Forms.TabPage
$tabPage2.ImageIndex = 1

# Создание ComboBox для списка серверов
$comboBoxServerList = New-Object System.Windows.Forms.ComboBox
$comboBoxServerList.Location = New-Object System.Drawing.Point(20, 35)
$comboBoxServerList.Size = New-Object System.Drawing.Size(200, 30)

# Заполняем ComboBox именами серверов
foreach ($server in $activeServers) {
    $comboBoxServerList.Items.Add($server.Company)
}

# Создание ListBox для вывода данных и изображений
$listBoxOutput = New-Object System.Windows.Forms.ListBox
$listBoxOutput.Location = New-Object System.Drawing.Point(20, 290)
$listBoxOutput.Size = New-Object System.Drawing.Size(550, 450)

# Создание Label для "Сервера"
$labelServers2 = New-Object System.Windows.Forms.Label
$labelServers2.Text = "Сервера"
$labelServers2.Location = New-Object System.Drawing.Point(85,10)
$labelServers2.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelServers2.AutoSize = $true

# Создание Label для "Статус онлайна"
$labelServers3 = New-Object System.Windows.Forms.Label
$labelServers3.Text = "Статус онлайна"
$labelServers3.Location = New-Object System.Drawing.Point(65,80)
$labelServers3.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelServers3.AutoSize = $true

# Создание Label для "Действия"
$labelAction2 = New-Object System.Windows.Forms.Label
$labelAction2.Text = "Действия"
$labelAction2.Location = New-Object System.Drawing.Point(430,10)
$labelAction2.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelAction2.AutoSize = $true

# Создание Label для "Информация"
$labelinformation = New-Object System.Windows.Forms.Label
$labelinformation.Text = "Информация"
$labelinformation.Location = New-Object System.Drawing.Point(255,270)
$labelinformation.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelinformation.AutoSize = $true

# Создание CheckedListBox для выбора действий
$checkedListBoxActions = New-Object System.Windows.Forms.CheckedListBox
$checkedListBoxActions.Location = New-Object System.Drawing.Point(370, 30)
$checkedListBoxActions.Size = New-Object System.Drawing.Size(200, 80)
$checkedListBoxActions.Items.Add("Проверка места на дисках")
$checkedListBoxActions.Items.Add("Список активных пользователей")
$checkedListBoxActions.Items.Add("Скоро")

$checkedListBoxActions.Add_ItemCheck({
    param(
        [System.Object]$s,
        [System.Windows.Forms.ItemCheckEventArgs]$e
    )

    # Проверяем, что состояние элемента меняется на "Checked"
    if ($e.NewValue -eq "Checked") {
        # Отменяем выбор всех остальных элементов
        for ($i = 0; $i -lt $checkedListBoxActions.Items.Count; $i++) {
            if ($i -ne $e.Index) {
                $checkedListBoxActions.SetItemChecked($i, $false)
            }
        }
    }

    # Показываем checkedListBox3, если выбрано одно из определенных действий
    $checkedListBoxAddActions.Visible = ("Проверка места на дисках","Список активных пользователей" -contains $checkedListBoxActions.Items[$e.Index])
    $labelAddAction.Visible = ("Проверка места на дисках","Список активных пользователей" -contains $checkedListBoxActions.Items[$e.Index])
})

# Создание Label для "Доп.действие"
$labelAddAction = New-Object System.Windows.Forms.Label
$labelAddAction.Text = "Доп.действие"
$labelAddAction.Location = New-Object System.Drawing.Point(430,115)
$labelAddAction.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$labelAddAction.AutoSize = $true
$labelAddAction.Visible = $false # Сначала спрятан

# Создание CheckedListBox для выбора доп.действий
$checkedListBoxAddActions = New-Object System.Windows.Forms.CheckedListBox
$checkedListBoxAddActions.Location = New-Object System.Drawing.Point(370, 135)
$checkedListBoxAddActions.Size = New-Object System.Drawing.Size(200, 80)
$checkedListBoxAddActions.Items.Add("Объем памяти у пользователей")
$checkedListBoxAddActions.Items.Add("Скоро...")
$checkedListBoxAddActions.Items.Add("Скоро...")
$checkedListBoxAddActions.Visible = $false # Сначала спрятан

$checkedListBoxAddActions.Add_ItemCheck({
    param(
        [System.Object]$s,
        [System.Windows.Forms.ItemCheckEventArgs]$e
    )
    if ($e.NewValue -eq "Checked") {
        for ($i = 0; $i -lt $checkedListBoxAddActions.Items.Count; $i++) {
            if ($i -ne $e.Index) {
                $checkedListBoxAddActions.SetItemChecked($i, $false)
            }
        }
    }
})

$button3 = New-Object System.Windows.Forms.Button
$button3.Size = New-Object System.Drawing.Size(80, 35)
$button3.Location = New-Object System.Drawing.Point(255, 15)
$button3.Text = "Очистить инфу"
$button3.Add_Click({
    $listBoxOutput.Items.Clear()
})

# Создание кнопки "Выполнить"
$buttonExecute = New-Object System.Windows.Forms.Button
$buttonExecute.Location = New-Object System.Drawing.Point(255, 50)
$buttonExecute.Size = New-Object System.Drawing.Size(80, 35)
$buttonExecute.Text = "Выполнить"
$buttonExecute.Add_Click({
    $selectedAddAction = $checkedListBoxAddActions.CheckedItems
    $selectedAction = $checkedListBoxActions.CheckedItems
    $selectedServer = $comboBoxServerList.SelectedItem

    if ($selectedAction.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Выберите действие", "Ошибка")
        return
    }

    if ($selectedServer -eq $null) {
        [System.Windows.Forms.MessageBox]::Show("Выберите сервер", "Ошибка")
        return
    }

    $credentials = $companyAndCredentials[$selectedServer]

    $sessionOption = New-PSSessionOption -SkipCNCheck
    $ip = $credentials["IP"]
    $username = $credentials["Username"]
    $password = $credentials["Password"]
    $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

    $action = $selectedAction[0].ToString()

    switch ($action) {
        "Проверка места на дисках" {
            loading $loadimg
            if ($selectedAddAction.Count -gt 0) {
                $addAction = $selectedAddAction[0].ToString()
                if ($addAction -eq "Объем памяти у пользователей"){
                        $scriptBlock = {
                            $UserInformation = @()

                            $Users = Get-ChildItem -Path "C:\Users" -Directory

                            foreach ($User in $Users) {
                                $UserInfo = New-Object PSObject -Property @{
                                    UserName = $User.Name
                                    Path = $User.FullName
                                    TotalSize = 0
                                }

                                # Проверяем существование папки AppData
                                $AppDataPath = Join-Path $User.FullName "AppData"
                                if (Test-Path -Path $AppDataPath -PathType Container) {
                                    $Acl = Get-Acl -Path $AppDataPath
                                    $Acl.SetAccessRuleProtection($false, $true)
                                    Set-Acl -Path $AppDataPath -AclObject $Acl
                                }

                                # Подсчет размера
                                Get-ChildItem -Path $User.FullName -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
                                    $UserInfo.TotalSize += [math]::Round(($_.Length / 1MB), 0) # Пересчитываем в мегабайты и округляем до целых чисел
                                }

                                $UserInformation += $UserInfo
                            }

                            # Вывод информации
                            foreach ($Info in $UserInformation) {
                                $test = "Пользователь: $($Info.UserName), Размер: $($Info.TotalSize) MB"
                                $test
                            }
                        }
                        try {
                            $listBoxOutput.Items.Clear()
                            $diskInfo = Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                            $listBoxOutput.Items.Add($_)}
                        } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                            $errorMessage = $_.Exception.Message
                            $listBoxOutput.Items.Add("Не удалось подключиться к $selectedServer")
                        } catch {
                            $errorMessage = $_.Exception.Message
                            $listBoxOutput.Items.Add("Ошибка: $errorMessage")
                        }
                        closeLoadingForm $SoundDone
                }else{
                    closeLoadingForm $SoundError
                    [System.Windows.Forms.MessageBox]::Show("Выбрано не подходящее действие", "Ошибка")}
            } else {
                $scriptBlock = {
                    $disks = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
                    $disks
                }
                try {
                    $listBoxOutput.Items.Clear()
                    $diskInfo = Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop 
                    # Преобразование результатов в объекты и добавление их в ListBox
                    $diskInfo | ForEach-Object {
                        $output = "На диске "+ $_.DeviceID + "  " + "свободно " + [math]::Round(($_.FreeSpace / $_.Size) * 100) +"% места"
                        $listBoxOutput.Items.Add($output)
                        $listBoxOutput.Items.Add("")
                     }
                } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                    $errorMessage = $_.Exception.Message
                    $listBoxOutput.Items.Add("Не удалось подключиться к $selectedServer")
                } catch {
                    $errorMessage = $_.Exception.Message
                    $listBoxOutput.Items.Add("Ошибка: $errorMessage")
                }
                closeLoadingForm $SoundDone
            }
        }
"Список активных пользователей" {
    loading $loadimg
    if ($selectedAddAction.Count -gt 0) {
        $addAction = $selectedAddAction[0].ToString()
        if ($addAction -eq "Отключить неактивных") {
            $scriptBlock = {
                $qwinstaData = qwinsta
                $qwinstaData = $qwinstaData | Out-String
                $qwinstaData = $qwinstaData -split '\r\n' | Select-Object -Skip 1

                $usersData = @()

                foreach ($session in $qwinstaData) {
                    if ($session -match '\S') {
                        $sessionParts = $session -split '\s+'
                        $userName = $sessionParts[1]

                        # Проверка на исключение
                        if ($userName -notin "services", "console", "rdp-tcp") {
                            $userData = New-Object PSObject -Property @{
                                "User" = $userName
                                "ID" = $sessionParts[2]
                                "Status" = if ($sessionParts[3] -eq "Активно") {"Онлайн"} else {"Оффлайн"}
                            }
                            $usersData += $userData
                        }
                    }
                }

                # Завершение сеансов пользователей с статусом "Оффлайн"
                foreach ($user in $usersData) {
                    if ($user.Status -eq "Оффлайн") {
                        Logoff $user.ID
                    }
                }
            }

            try {
                $listBoxOutput.Items.Clear()
                $usersInfo = Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop 
                $listBoxOutput.Items.Add("Неактивные пользователи отключены")
            } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                $errorMessage = $_.Exception.Message
                $listBoxOutput.Items.Add("Не удалось подключиться к $selectedServer")
            } catch {
                $errorMessage = $_.Exception.Message
                $listBoxOutput.Items.Add("Ошибка: $errorMessage")
            }
        }
    else{
        closeLoadingForm $SoundError
        [System.Windows.Forms.MessageBox]::Show("Выбрано не подходящее дополнительное действие", "Ошибка")}
}else{
                $scriptBlock = {
                    # Получение списка пользователей из WMI
                    $wmiUsers = Get-WmiObject -Query "SELECT * FROM Win32_Process WHERE NOT Name LIKE 'System Idle Process'" | ForEach-Object {
                        $username = $_.GetOwner().User
                        $excludedUsersPattern = '^(DWM-|\bLOCAL SERVICE\b|\bNETWORK SERVICE\b|\bUSR1CV8\b|\bСИСТЕМА\b)'
    
                        if ($username -ne $null -and $username -notmatch $excludedUsersPattern) {
                            $username
                        }
                    } | Sort-Object -Unique

                    # Получение списка активных пользователей из записей журнала событий за последние 15 минут
                    $lastLoginTime = (Get-Date).AddMinutes(-15)
                    $loggedUsers = @()

                    $loginEvents = Get-EventLog -LogName Security | Where-Object { $_.EventID -eq 4624 -and $_.TimeGenerated -ge $lastLoginTime }

                    foreach ($event in $loginEvents) {
                        $user = $event.ReplacementStrings[5]
                        if ($user -notin $loggedUsers) {
                            $loggedUsers += $user
                        }
                    }

                    # Определение онлайн пользователей
                    $onlineUsers = @()

                    foreach ($wmiUser in $wmiUsers) {
                        if ($wmiUser -in $loggedUsers -or $wmiUser -eq $env:USERNAME) {
                            $onlineUsers += $wmiUser
                        }
                    }

                    # Определение оффлайн пользователей
                    $offlineUsers = $wmiUsers | Where-Object { $_ -notin $onlineUsers }

                    Write-Output "Пользователи Онлайн:"
                    $onlineUsers

                    Write-Output "`nПользователи Оффлайн:"
                    $offlineUsers
            }
            try {
                $listBoxOutput.Items.Clear()
                Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock $scriptBlock -ErrorAction Stop | ForEach-Object {
                    $listBoxOutput.Items.Add($_)
                }
            } catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                $errorMessage = $_.Exception.Message
                $listBoxOutput.Items.Add("Не удалось подключиться к $selectedServer")
            } catch {
                $errorMessage = $_.Exception.Message
                $listBoxOutput.Items.Add("Ошибка: $errorMessage")
            }
            closeLoadingForm $SoundDone
    }
}
        "Проверка активности" {
            #Скоро
        }
        default {
            [System.Windows.Forms.MessageBox]::Show("Выбрано недопустимое действие", "Ошибка")
        }
    }
})


$tabPage3 = New-Object System.Windows.Forms.TabPage
$tabPage3.ImageIndex = 2

# Добавление страниц к TabControl
$tabControl.Controls.Add($tabPage1)
$tabControl.Controls.Add($tabPage2)
$tabControl.Controls.Add($tabPage3)

# Добавление элементов на страницу "Пользователи"
$tabPage1.Controls.Add($checkedListBox)
$tabPage1.Controls.Add($checkedListBox2)
$tabPage1.Controls.Add($button1)
$tabPage1.Controls.Add($button2)
$tabPage1.Controls.Add($listBox)
$tabPage1.Controls.Add($labelStatus)
$tabPage1.Controls.Add($labelServers)
$tabPage1.Controls.Add($labelActions)
$tabPage1.Controls.Add($textBox)
$tabPage1.Controls.Add($labelText)
$tabPage1.Controls.Add($labelGroup)
$tabPage1.Controls.Add($checkedListBox3)

# Добавление элементов на страницу "Сервер"
$tabPage2.Controls.Add($comboBoxServerList)
$tabPage2.Controls.Add($listBoxOutput)
$tabPage2.Controls.Add($checkedListBoxActions)
$tabPage2.Controls.Add($buttonExecute)
$tabPage2.Controls.Add($button3)
$tabPage2.Controls.Add($labelServers2)
$tabPage2.Controls.Add($labelServers3)
$tabPage2.Controls.Add($labelAction2)
$tabPage2.Controls.Add($labelinformation)
$tabPage2.Controls.Add($labelAddAction)
$tabPage2.Controls.Add($checkedListBoxAddActions)
$tabPage2.Controls.Add($dataGridView)

# Добавление на форму
$form.Controls.Add($tabControl)
$form.Controls.Add($RunningLabel)
$Timer.Start()  # Запускаем таймер

# Закрытие таймера при закрытии формы
$Form.Add_Closing({
    $Timer.Stop()
    $Timer.Dispose()
})

$form.ShowDialog()
}


#Функция загрузки
function loading ($img) {
$global:loadingForm = New-Object Windows.Forms.Form
$loadingForm.Text = ""
$loadingForm.Width = 500
$loadingForm.Height = 500
$loadingForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$loadingForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

$loadingForm.TransparencyKey = [System.Drawing.Color]::White
$loadingForm.BackColor = [System.Drawing.Color]::White

# Убираем все кнопки и иконки
$loadingForm.ControlBox = $false  # Убираем иконку в заголовке
$loadingForm.MinimizeBox = $false  # Убираем кнопку сворачивания
$loadingForm.MaximizeBox = $false  # Убираем кнопку разворачивания
$loadingForm.ShowInTaskbar = $true  # Не показывать форму в панели задач

# Создаем PictureBox для отображения изображения
$loadingImage = New-Object Windows.Forms.PictureBox
$loadingImage.Image = [System.Drawing.Image]::FromFile($img)
$loadingImage.Width = 500  #ширина изображения
$loadingImage.Height = 500  #высота изображения
$loadingImage.Left = 0
$loadingImage.Top = 0
$loadingForm.Controls.Add($loadingImage)


$loadingForm.Show()
$loadingForm.Refresh()
}
#Функция закрытия программы
function closeLoadingForm($music) {
    if ($global:loadingForm -ne $null) {
        $global:loadingForm.Close()
        $global:loadingForm.Dispose()
    }
    $player.SoundLocation = $music
    $player.Play()
}
loading $loadimg

$companyAndCredentials = @{
    "РитейлЛогистикМосква" = @{
        "IP" = "46.148.233.28"
        "Username" = "Administrator"
        "Password" = "gOq7TuRgTTdn"
    }
    "РЛМСК2" = @{
        "IP" = "46.148.233.22"
        "Username" = "Administrator"
        "Password" = "gOq7TuRgTTdn"
    }
}

#Массив для хранения информации о серверах
$serverStatus = @()

foreach ($company in $companyAndCredentials.Keys) {
    $credentials = $companyAndCredentials[$company]
    $sessionOption = New-PSSessionOption -SkipCNCheck
    $ip = $credentials["IP"]
    $username = $credentials["Username"]
    $password = $credentials["Password"]
    $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

    try {
        $result = Invoke-Command -ComputerName $ip -UseSSL -Credential $credential -SessionOption $sessionOption -ScriptBlock { } -ErrorAction Stop
        $status = "Активен"
    } catch {
        $status = "Оффлайн"
    }

    $serverStatus += [PSCustomObject]@{
        "Company" = $company
        "Status" = $status
    }
}
$activeServers = $serverStatus | Where-Object { $_.Status -eq "Активен" }
closeLoadingForm $SoundStart
AL