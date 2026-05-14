# AnD AI - Unified Performance Runner
# Executes Task A, Task B evaluations and both Ablation Studies
# Logs all output to evaluation.log
# 
# Usage: .\run_all_tests.ps1
# This script is self-contained and manages its own environment variables.

$LogFile = "$PSScriptRoot\evaluation.log"
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function Write-Log {
    param([string]$Message, [string]$Color = "White")
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$ts] $Message"
    Write-Host $line -ForegroundColor $Color
    Add-Content -Path $LogFile -Value $line
}

# --- ENVIRONMENT SETUP ---
function Load-Env {
    param([string]$Path)
    if (Test-Path $Path) {
        Write-Log "Loading environment from $Path..." "Cyan"
        Get-Content $Path | ForEach-Object {
            # Skip comments and empty lines
            if ($_ -match '^([^#\s][^=]+)=(.*)$') {
                $name = $matches[1].Trim()
                $value = $matches[2].Trim().Trim('"').Trim("'")
                [Environment]::SetEnvironmentVariable($name, $value, "Process")
            }
        }
    }
}

# 1. Load root .env (highest priority)
Load-Env "$PSScriptRoot\.env"

# 2. Check for required variables
if ([string]::IsNullOrEmpty([Environment]::GetEnvironmentVariable("OPENROUTER_API_KEYS", "Process"))) {
    Write-Log "[WARNING] OPENROUTER_API_KEYS not found in environment." "Yellow"
    Write-Log "Attempting to load from task-specific .env files..." "Yellow"
    Load-Env "$PSScriptRoot\AnD-task-a\.env"
    Load-Env "$PSScriptRoot\AnD-task-b\.env"
}

# Clear old log
"AnD AI Evaluation Log - Started $Timestamp" | Out-File -FilePath $LogFile
Write-Log "============================================================" "Cyan"
Write-Log "       AnD AI: CULTURALLY INTELLIGENT AI FRAMEWORK        " "Cyan"
Write-Log "                UNIFIED TEST & ABLATION RUNNER             " "Cyan"
Write-Log "============================================================" "Cyan"
Write-Log ""

# Verification
$Key = [Environment]::GetEnvironmentVariable("OPENROUTER_API_KEYS", "Process")
if ([string]::IsNullOrEmpty($Key)) {
    Write-Log "[CRITICAL] No API Keys found. Evaluations requiring LLMs will fail." "Red"
} else {
    Write-Log "Environment ready. API Keys loaded." "Green"
}

# 1. TASK A EVALUATION
Write-Log ">>> PHASE 1: Running Task A Performance Evaluation..." "Green"
try {
    $output = python AnD-task-a\evaluation\run_evals.py 2>&1
    $output | ForEach-Object { Write-Log $_ "Gray" }
    if ($LASTEXITCODE -ne 0) { Write-Log "Task A Evaluation Failed!" "Red" }
} catch {
    Write-Log "Task A Evaluation Error: $_" "Red"
}
Write-Log ""

# 2. TASK B EVALUATION
Write-Log ">>> PHASE 2: Running Task B Performance Evaluation..." "Green"
try {
    $output = python AnD-task-b\evaluation\run_evals.py 2>&1
    $output | ForEach-Object { Write-Log $_ "Gray" }
    if ($LASTEXITCODE -ne 0) { Write-Log "Task B Evaluation Failed!" "Red" }
} catch {
    Write-Log "Task B Evaluation Error: $_" "Red"
}
Write-Log ""

# 3. TASK A ABLATION STUDY
Write-Log ">>> PHASE 3: Running Task A Ablation Study (50 Cases)..." "Green"
Write-Log "(Testing: Full System, w/o Price Shock, w/o Style Fingerprint, w/o Nigerian Context)" "Gray"
try {
    # Set output dir relative to the script
    $A_Out = "$PSScriptRoot\AnD-task-a\evaluation\results"
    $output = python AnD-task-a\evaluation\ablation.py --output_dir "$A_Out" 2>&1
    $output | ForEach-Object { Write-Log $_ "Gray" }
    if ($LASTEXITCODE -ne 0) { Write-Log "Task A Ablation Failed!" "Red" }
} catch {
    Write-Log "Task A Ablation Error: $_" "Red"
}
Write-Log ""

# 4. TASK B ABLATION STUDY
Write-Log ">>> PHASE 4: Running Task B Ablation Study (50 Cases)..." "Green"
Write-Log "(Testing: Full System, w/o Location Boost, w/o Cold Start, w/o Occasion Matching)" "Gray"
try {
    $B_Out = "$PSScriptRoot\AnD-task-b\evaluation\results"
    $output = python AnD-task-b\evaluation\ablation.py --output_dir "$B_Out" 2>&1
    $output | ForEach-Object { Write-Log $_ "Gray" }
    if ($LASTEXITCODE -ne 0) { Write-Log "Task B Ablation Failed!" "Red" }
} catch {
    Write-Log "Task B Ablation Error: $_" "Red"
}
Write-Log ""

# Summary
Write-Log "============================================================" "Cyan"
Write-Log "                ALL OPERATIONS COMPLETED                   " "Cyan"
Write-Log "============================================================" "Cyan"
Write-Log "Log file: $LogFile" "Gray"
Write-Log ""