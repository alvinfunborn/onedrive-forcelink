# This script requires administrator privileges
#Requires -RunAsAdministrator

# Define source and target directories
$sourceRoot = "$env:USERPROFILE\OneDrive\Users"
$targetRoot = "C:\Users"

# Check if source directory exists
if (-not (Test-Path $sourceRoot)) {
    Write-Error "Source directory $sourceRoot does not exist!"
    exit 1
}

# Recursive function to create symbolic links
function Create-SymLinks {
    param (
        [string]$sourcePath,
        [string]$targetPath
    )
    
    # Create target directory if it doesn't exist
    if (-not (Test-Path $targetPath)) {
        New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
    }
    
    # Get all child items
    Get-ChildItem $sourcePath -Force | ForEach-Object {
        # Build target path
        $newTargetPath = Join-Path $targetPath $_.Name
        $newSourcePath = $_.FullName
        
        if ($_.PSIsContainer) {
            # If it's a directory, recursively process its contents
            Create-SymLinks $newSourcePath $newTargetPath
        } else {
            # If it's a file
            if (Test-Path $newTargetPath) {
                # If target exists and is not a symbolic link, backup
                $item = Get-Item $newTargetPath
                if (-not $item.LinkType) {
                    $backupPath = "${newTargetPath}.bak"
                    Write-Host "Backing up existing file: $newTargetPath -> $backupPath"
                    Move-Item -Path $newTargetPath -Destination $backupPath -Force
                }
            }
            
            # Create file symbolic link
            Write-Host "Creating file link: $newTargetPath -> $newSourcePath"
            New-Item -ItemType SymbolicLink -Path $newTargetPath -Target $newSourcePath -Force
        }
    }
}

# Main execution logic
try {
    Write-Host "Starting to create symbolic links..."
    Write-Host "Source directory: $sourceRoot"
    Write-Host "Target directory: $targetRoot"
    
    # Start recursive symbolic link creation
    Create-SymLinks $sourceRoot $targetRoot
    
    Write-Host "Symbolic links creation completed!"
} catch {
    Write-Error "Error occurred: $_"
    exit 1
}
