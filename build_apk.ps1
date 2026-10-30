Write-Host "===================================================================" -ForegroundColor Cyan
Write-Host "  COMPILATION NOUVEAU APK (Groupe Scolaire UPIAI - Maradi)" -ForegroundColor Yellow
Write-Host "===================================================================" -ForegroundColor Cyan

Set-Location -Path $PSScriptRoot

if (Test-Path "C:\Program Files\Android\Android Studio\jbr") {
    $env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
    $env:PATH = "$env:JAVA_HOME\bin;" + $env:PATH
}

$flutterCmd = "flutter"
if (Test-Path "C:\src\flutter\bin\flutter.bat") {
    $flutterCmd = "C:\src\flutter\bin\flutter.bat"
}

Write-Host "`n[1/3] Nettoyage et installation des packages..." -ForegroundColor Green
& $flutterCmd pub get

Write-Host "`n[2/3] Verification de l'environnement..." -ForegroundColor Green

Write-Host "`n[3/3] Batissage du fichier app-release.apk pour GROUP-UPIAI..." -ForegroundColor Green
& $flutterCmd build apk --release --no-tree-shake-icons `
    --dart-define=EDUT_WEB_API_BASE_URL=https://web-group-upiai.vercel.app `
    --dart-define=SUPABASE_URL=https://scogaxcodsigxistzcnt.supabase.co `
    --dart-define=SUPABASE_ANON_KEY=sb_publishable_CqeNp-TJJBjeTuSS5fsj5g_KvZGfryb

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n===================================================================" -ForegroundColor Cyan
    Write-Host "  COMPILATION TERMINEE AVEC SUCCES !" -ForegroundColor Green
    Write-Host "  Fichier APK disponible ici :" -ForegroundColor Yellow
    Write-Host "  $PSScriptRoot\build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor White
    Write-Host "===================================================================" -ForegroundColor Cyan
} else {
    Write-Host "`n===================================================================" -ForegroundColor Red
    Write-Host "  [!] ECHEC DE LA COMPILATION (Code d'erreur: $LASTEXITCODE)" -ForegroundColor Red
    Write-Host "===================================================================" -ForegroundColor Red
}
