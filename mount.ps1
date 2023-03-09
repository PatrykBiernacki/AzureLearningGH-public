$connectTestResult = Test-NetConnection -ComputerName stdevlog01.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"stdevlog01.file.core.windows.net`" /user:`"localhost\stdevlog01`" /pass:`"4AWtm4dIMdwZrjFWksjzXwbEvqvw3CZDXRshMDDWa9njnGI0bURTRYSWGiVfOT6dvXbd0VYHKdpg+AStbBoRbw==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\stdevlog01.file.core.windows.net\simplefileshare" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}