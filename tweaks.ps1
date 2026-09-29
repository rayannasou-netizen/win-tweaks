# Adjust Console Encoding
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Check Administrator Privileges
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "======================================================" -ForegroundColor Red
    Write-Host " [!] ERROR: Please run this script as Administrator!" -ForegroundColor Red
    Write-Host "======================================================" -ForegroundColor Red
    Pause
    Exit
}

function Show-Menu {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "               TWEAK SUITE UTILITY v1.0               " -ForegroundColor Yellow
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host " [1] CPU Optimization" -ForegroundColor Green
    Write-Host " [2] GPU & Power Plan Optimization" -ForegroundColor Green
    Write-Host " [3] Network & Ping Optimization" -ForegroundColor Green
    Write-Host " [4] Memory & RAM Cleaner" -ForegroundColor Green
    Write-Host " [5] Apply All Tweaks" -ForegroundColor Magenta
    Write-Host " [0] Exit" -ForegroundColor Red
    Write-Host "======================================================" -ForegroundColor Cyan
}

function CPU-Tweak {
    Clear-Host
    Write-Host "=== [1] CPU OPTIMIZATION ===" -ForegroundColor Yellow
    Write-Host "Info: Disables telemetry services to lower CPU usage." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] Turn ON Tweak" -ForegroundColor Green
    Write-Host " [2] Turn OFF Tweak (Restore)" -ForegroundColor Red
    Write-Host " [B] Back to Main Menu" -ForegroundColor Cyan
    
    $opt = Read-Host "Select Option"
    switch ($opt) {
        "1" {
            Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Write-Host "`n[V] CPU Tweak Applied Successfully!" -ForegroundColor Green
            Pause
            CPU-Tweak
        }
        "2" {
            Set-Service -Name "DiagTrack" -StartupType Automatic -ErrorAction SilentlyContinue
            Start-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Write-Host "`n[X] CPU Settings Restored!" -ForegroundColor Yellow
            Pause
            CPU-Tweak
        }
        "B" { return }
        "b" { return }
        Default { CPU-Tweak }
    }
}

function GPU-Tweak {
    Clear-Host
    Write-Host "=== [2] GPU OPTIMIZATION ===" -ForegroundColor Yellow
    Write-Host "Info: Sets Ultimate/High Performance power plan for higher FPS." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] Turn ON Tweak" -ForegroundColor Green
    Write-Host " [2] Turn OFF Tweak (Restore)" -ForegroundColor Red
    Write-Host " [B] Back to Main Menu" -ForegroundColor Cyan
    
    $opt = Read-Host "Select Option"
    switch ($opt) {
        "1" {
            powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
            Write-Host "`n[V] High Performance Mode Activated!" -ForegroundColor Green
            Pause
            GPU-Tweak
        }
        "2" {
            powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
            Write-Host "`n[X] Restored to Balanced Power Plan!" -ForegroundColor Yellow
            Pause
            GPU-Tweak
        }
        "B" { return }
        "b" { return }
        Default { GPU-Tweak }
    }
}

function Network-Tweak {
    Clear-Host
    Write-Host "=== [3] NETWORK OPTIMIZATION ===" -ForegroundColor Yellow
    Write-Host "Info: Clears DNS cache and optimizes TCP settings for better Ping." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] Turn ON Tweak" -ForegroundColor Green
    Write-Host " [2] Turn OFF Tweak (Restore)" -ForegroundColor Red
    Write-Host " [B] Back to Main Menu" -ForegroundColor Cyan
    
    $opt = Read-Host "Select Option"
    switch ($opt) {
        "1" {
            netsh int tcp set global autotuninglevel=normal | Out-Null
            Clear-DnsClientCache
            Write-Host "`n[V] Network Tweaks Applied Successfully!" -ForegroundColor Green
            Pause
            Network-Tweak
        }
        "2" {
            netsh int tcp set global autotuninglevel=disabled | Out-Null
            Write-Host "`n[X] Network Settings Restored!" -ForegroundColor Yellow
            Pause
            Network-Tweak
        }
        "B" { return }
        "b" { return }
        Default { Network-Tweak }
    }
}

function RAM-Tweak {
    Clear-Host
    Write-Host "=== [4] RAM CLEANER ===" -ForegroundColor Yellow
    Write-Host "Info: Clears standby memory and background system cache." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] Clean RAM Cache Now" -ForegroundColor Green
    Write-Host " [B] Back to Main Menu" -ForegroundColor Cyan
    
    $opt = Read-Host "Select Option"
    switch ($opt) {
        "1" {
            [System.GC]::Collect()
            Write-Host "`n[V] Memory Cache Cleared Successfully!" -ForegroundColor Green
            Pause
            RAM-Tweak
        }
        "B" { return }
        "b" { return }
        Default { RAM-Tweak }
    }
}

function Apply-All {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Yellow
    Write-Host "            APPLYING ALL SYSTEM TWEAKS...             " -ForegroundColor Yellow
    Write-Host "======================================================" -ForegroundColor Yellow
    
    Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
    Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    netsh int tcp set global autotuninglevel=normal | Out-Null
    Clear-DnsClientCache
    [System.GC]::Collect()
    
    Write-Host "`n[V] ALL TWEAKS APPLIED SUCCESSFULLY!" -ForegroundColor Green
    Pause
}

# Main Execution Loop
do {
    Show-Menu
    $inputChoice = Read-Host "Select Option"
    switch ($inputChoice) {
        "1" { CPU-Tweak }
        "2" { GPU-Tweak }
        "3" { Network-Tweak }
        "4" { RAM-Tweak }
        "5" { Apply-All }
        "0" { Write-Host "Exiting Tweak Suite..."; exit }
    }
} while ($true)
