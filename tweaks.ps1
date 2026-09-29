# Electronic Encoding Setup
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# التأكد من تشغيل السكربت كمسؤول (Administrator)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "======================================================" -ForegroundColor Red
    Write-Host " [!] Please run this script as Administrator!" -ForegroundColor Red
    Write-Host " [!] يرجى تشغيل السكربت كمسؤول!" -ForegroundColor Red
    Write-Host "======================================================" -ForegroundColor Red
    Pause
    Exit
}

function Show-Menu {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "         قائمة تحسين أداء البيسي (Tweak Suite)        " -ForegroundColor Yellow
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host " [1] تحسين أداء المعالج (CPU Optimization)" -ForegroundColor Green
    Write-Host " [2] تحسين أداء كرت الشاشة (GPU & Power Plan)" -ForegroundColor Green
    Write-Host " [3] تحسين شبكة الإنترنت والـ Ping (Network Tweak)" -ForegroundColor Green
    Write-Host " [4] تفريغ ذاكرة الرام والكاش (RAM Cleaner)" -ForegroundColor Green
    Write-Host " [5] تطبيق جميع التحسينات دفعة واحدة (Apply All)" -ForegroundColor Magenta
    Write-Host " [0] خروج (Exit)" -ForegroundColor Red
    Write-Host "======================================================" -ForegroundColor Cyan
}

function CPU-Tweak {
    Clear-Host
    Write-Host "=== [1] إعدادات تحسين المعالج ===" -ForegroundColor Yellow
    Write-Host "الشرح: إيقاف خدمات التتبع الخفية وتقليل استهلاك المعالج." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] تشغيل التويك (ON)" -ForegroundColor Green
    Write-Host " [2] إطفاء التويك وإعادة الافتراضي (OFF)" -ForegroundColor Red
    Write-Host " [B] العودة للقائمة الرئيسية" -ForegroundColor Cyan
    
    $opt = Read-Host "اختر الخيار"
    switch ($opt) {
        "1" {
            Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Write-Host "`n[V] تم تطبيق تحسين المعالج بنجاح!" -ForegroundColor Green
            Pause
            CPU-Tweak
        }
        "2" {
            Set-Service -Name "DiagTrack" -StartupType Automatic -ErrorAction SilentlyContinue
            Start-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Write-Host "`n[X] تم استعادة إعدادات المعالج الافتراضية!" -ForegroundColor Yellow
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
    Write-Host "=== [2] إعدادات تحسين كرت الشاشة ===" -ForegroundColor Yellow
    Write-Host "الشرح: تفعيل خطة الطاقة القصوى للحصول على أعلى FPS." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] تشغيل التويك (ON)" -ForegroundColor Green
    Write-Host " [2] إطفاء التويك وإعادة الافتراضي (OFF)" -ForegroundColor Red
    Write-Host " [B] العودة للقائمة الرئيسية" -ForegroundColor Cyan
    
    $opt = Read-Host "اختر الخيار"
    switch ($opt) {
        "1" {
            powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
            Write-Host "`n[V] تم تفعيل خطة الطاقة الأقصى!" -ForegroundColor Green
            Pause
            GPU-Tweak
        }
        "2" {
            powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
            Write-Host "`n[X] تم إعادة خطة الطاقة الافتراضية!" -ForegroundColor Yellow
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
    Write-Host "=== [3] إعدادات تحسين الإنترنت ===" -ForegroundColor Yellow
    Write-Host "الشرح: تنظيف الـ DNS وتعديل إعدادات TCP لتخفيض البنج." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] تشغيل التويك (ON)" -ForegroundColor Green
    Write-Host " [2] إطفاء التويك وإعادة الافتراضي (OFF)" -ForegroundColor Red
    Write-Host " [B] العودة للقائمة الرئيسية" -ForegroundColor Cyan
    
    $opt = Read-Host "اختر الخيار"
    switch ($opt) {
        "1" {
            netsh int tcp set global autotuninglevel=normal | Out-Null
            Clear-DnsClientCache
            Write-Host "`n[V] تم تحسين استجابة الشبكة وتنظيف الـ DNS!" -ForegroundColor Green
            Pause
            Network-Tweak
        }
        "2" {
            netsh int tcp set global autotuninglevel=disabled | Out-Null
            Write-Host "`n[X] تم إعادة إعدادات الشبكة للافتراضي!" -ForegroundColor Yellow
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
    Write-Host "=== [4] إعدادات تحسين الرام ===" -ForegroundColor Yellow
    Write-Host "الشرح: تفريغ ذاكرة الكاش والعمليات غير الضرورية." -ForegroundColor Gray
    Write-Host ""
    Write-Host " [1] تنظيف الرام الآن" -ForegroundColor Green
    Write-Host " [B] العودة للقائمة الرئيسية" -ForegroundColor Cyan
    
    $opt = Read-Host "اختر الخيار"
    switch ($opt) {
        "1" {
            [System.GC]::Collect()
            Write-Host "`n[V] تم تفريغ ذاكرة النظام المؤقتة!" -ForegroundColor Green
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
    Write-Host "         جاري تطبيق كافة التحسينات دفعة واحدة...     " -ForegroundColor Yellow
    Write-Host "======================================================" -ForegroundColor Yellow
    
    Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
    Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    netsh int tcp set global autotuninglevel=normal | Out-Null
    Clear-DnsClientCache
    [System.GC]::Collect()
    
    Write-Host "`n[V] تم تطبيق جميع الإعدادات والتحسينات بنجاح!" -ForegroundColor Green
    Pause
}

# الحلقة الرئيسية للبرنامج
do {
    Show-Menu
    $inputChoice = Read-Host "اختر رقم الخيار المطلوب"
    switch ($inputChoice) {
        "1" { CPU-Tweak }
        "2" { GPU-Tweak }
        "3" { Network-Tweak }
        "4" { RAM-Tweak }
        "5" { Apply-All }
        "0" { Write-Host "شكراً لاستخدامك السكربت!"; exit }
    }
} while ($true)
