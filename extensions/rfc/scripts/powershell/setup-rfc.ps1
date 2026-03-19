#!/usr/bin/env pwsh
# Setup RFC document for a feature (extension version)

[CmdletBinding()]
param(
    [switch]$Json,
    [switch]$Help
)

$ErrorActionPreference = 'Stop'

# Show help if requested
if ($Help) {
    Write-Output "Usage: ./setup-rfc.ps1 [-Json] [-Help]"
    Write-Output "  -Json     Output results in JSON format"
    Write-Output "  -Help     Show this help message"
    exit 0
}

# Load common functions from core spec-kit
. "$PSScriptRoot/../../../../scripts/powershell/common.ps1"

# Get all paths and variables from common functions
$paths = Get-FeaturePathsEnv

# Check if we're on a proper feature branch (only for git repos)
if (-not (Test-FeatureBranch -Branch $paths.CURRENT_BRANCH -HasGit $paths.HAS_GIT)) {
    exit 1
}

# Ensure the feature directory exists
New-Item -ItemType Directory -Path $paths.FEATURE_DIR -Force | Out-Null

# Derive RFC path
$rfcFile = Join-Path $paths.FEATURE_DIR "rfc.md"

# Resolve template: extension's own template first, then core
$extTemplate = Join-Path $PSScriptRoot "../../templates/rfc-template.md"
$coreTemplate = Resolve-Template -TemplateName 'rfc-template' -RepoRoot $paths.REPO_ROOT

if (Test-Path $extTemplate) {
    Copy-Item $extTemplate $rfcFile -Force
    Write-Output "Copied RFC template to $rfcFile"
} elseif ($coreTemplate -and (Test-Path $coreTemplate)) {
    Copy-Item $coreTemplate $rfcFile -Force
    Write-Output "Copied RFC template to $rfcFile"
} else {
    Write-Warning "RFC template not found"
    New-Item -ItemType File -Path $rfcFile -Force | Out-Null
}

# Output results
if ($Json) {
    $result = [PSCustomObject]@{
        FEATURE_SPEC = $paths.FEATURE_SPEC
        RFC_FILE = $rfcFile
        SPECS_DIR = $paths.FEATURE_DIR
        BRANCH = $paths.CURRENT_BRANCH
        HAS_GIT = $paths.HAS_GIT
    }
    $result | ConvertTo-Json -Compress
} else {
    Write-Output "FEATURE_SPEC: $($paths.FEATURE_SPEC)"
    Write-Output "RFC_FILE: $rfcFile"
    Write-Output "SPECS_DIR: $($paths.FEATURE_DIR)"
    Write-Output "BRANCH: $($paths.CURRENT_BRANCH)"
    Write-Output "HAS_GIT: $($paths.HAS_GIT)"
}
