# Laravel + React Fullstack Setup Script
# Run this in PowerShell from the project root directory

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Laravel + React Fullstack Setup" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Function to print section headers
function Print-Section {
    param([string]$title)
    Write-Host ""
    Write-Host ">>> $title" -ForegroundColor Green
    Write-Host "---" -ForegroundColor Green
}

# Function to execute command and check result
function Execute-Command {
    param([string]$command, [string]$description)
    Write-Host "Executing: $description..." -ForegroundColor Yellow
    Invoke-Expression $command
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[!] Warning: Command may have issues" -ForegroundColor Yellow
    } else {
        Write-Host "[OK] Success!" -ForegroundColor Green
    }
}

# =================
# BACKEND SETUP
# =================

Print-Section "1. Setting up Laravel Backend"

# Change to backend directory
Push-Location "laravel-api-app"

# Install composer dependencies
Write-Host "Installing PHP dependencies (this may take a few minutes)..." -ForegroundColor Yellow
Execute-Command "composer install" "Composer Install"

# Create .env file
Print-Section "2. Configuring Environment"
if (Test-Path ".env") {
    Write-Host ".env file already exists" -ForegroundColor Cyan
} else {
    Copy-Item ".env.example" ".env"
    Write-Host "[OK] Created .env file" -ForegroundColor Green
}

# Generate app key
Execute-Command "php artisan key:generate" "Generate App Key"

# Create SQLite database
Print-Section "3. Setting up Database"
if (-not (Test-Path "database\database.sqlite")) {
    New-Item -Path "database\database.sqlite" -ItemType File | Out-Null
    Write-Host "[OK] Created SQLite database" -ForegroundColor Green
} else {
    Write-Host "[OK] Database file already exists" -ForegroundColor Green
}

# Run migrations
Execute-Command "php artisan migrate --force" "Running Migrations"

# Optional: Seed database
Write-Host ""
Write-Host "Would you like to seed the database with sample data? (Y/n)" -ForegroundColor Cyan
$seedChoice = Read-Host
if ($seedChoice -ne 'n' -and $seedChoice -ne 'N') {
    Execute-Command "php artisan db:seed" "Seeding Database"
    Write-Host "[OK] Database seeded with sample data" -ForegroundColor Green
}

Pop-Location

# =================
# FRONTEND SETUP
# =================

Print-Section "4. Setting up React Frontend"

Push-Location "laravel-api-react-app"

# Install npm dependencies
Write-Host "Installing Node dependencies (this may take a few minutes)..." -ForegroundColor Yellow
Execute-Command "npm install" "NPM Install"

Pop-Location

# =================
# SUMMARY
# =================

Print-Section "5. Setup Complete!"

Write-Host ""
Write-Host "[OK] Backend setup completed" -ForegroundColor Green
Write-Host "[OK] Frontend setup completed" -ForegroundColor Green
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Start the Laravel backend:" -ForegroundColor White
Write-Host "   cd laravel-api-app" -ForegroundColor Gray
Write-Host "   php artisan serve" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Start the React frontend (in a new terminal):" -ForegroundColor White
Write-Host "   cd laravel-api-react-app" -ForegroundColor Gray
Write-Host "   npm run dev" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Open your browser:" -ForegroundColor White
Write-Host "   Backend:  http://localhost:8000" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5173" -ForegroundColor Cyan
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
