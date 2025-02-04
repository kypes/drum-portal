# Docker Compose PowerShell Helper Script

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

function Show-Help {
    Write-Host @"
Docker Compose Helper Commands:
------------------------------
./docker-compose.ps1 up        - Start the application
./docker-compose.ps1 down      - Stop the application
./docker-compose.ps1 build     - Rebuild containers
./docker-compose.ps1 logs      - View logs
./docker-compose.ps1 shell     - Open shell in web container
./docker-compose.ps1 test      - Run tests
./docker-compose.ps1 restart   - Restart containers
./docker-compose.ps1 clean     - Remove all containers and volumes
"@
}

function Start-App {
    docker-compose up -d
    Write-Host "Application started at http://localhost:3000"
}

function Stop-App {
    docker-compose down
}

function Build-App {
    docker-compose build
}

function Show-Logs {
    docker-compose logs -f
}

function Open-Shell {
    docker-compose exec web bash
}

function Run-Tests {
    docker-compose run --rm web bundle exec rspec
}

function Restart-App {
    docker-compose restart
}

function Clean-Environment {
    docker-compose down -v
    Write-Host "Cleaned up containers and volumes"
}

switch ($Command) {
    "up" { Start-App }
    "down" { Stop-App }
    "build" { Build-App }
    "logs" { Show-Logs }
    "shell" { Open-Shell }
    "test" { Run-Tests }
    "restart" { Restart-App }
    "clean" { Clean-Environment }
    default { Show-Help }
} 