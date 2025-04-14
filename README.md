# OneDrive Force Link

A PowerShell script to create symbolic links between OneDrive User directory and local User directory, enabling seamless synchronization of user settings and configurations.

## Features

- Creates symbolic links for files from OneDrive to local directory
- Maintains directory structure without creating directory links
- Automatically backs up existing files with .bak extension
- Provides detailed logging of operations
- Handles errors gracefully

## Prerequisites

- Windows 10/11
- PowerShell 3.0 or later
- Administrator privileges
- OneDrive installed and configured

## Directory Structure

```
Source: %USERPROFILE%\OneDrive\Users
Target: C:\Users
```

## Usage

1. Open Windows Terminal as Administrator
2. Navigate to script directory
3. Run the script:
```powershell
.\onedrive_forcelink.ps1
```

## Common Issues

1. Execution Policy
```powershell
# Run as administrator to allow script execution
Set-ExecutionPolicy RemoteSigned
```

2. File Extension
Make sure the script has .ps1 extension (not .psl)

3. Access Denied
Run Windows Terminal as Administrator

## Backup

- Original files are automatically backed up with .bak extension
- Example: `config.json` → `config.json.bak`

## Notes

- Only files are linked, directories are created normally
- Existing symbolic links are preserved
- Script requires administrator privileges
- Designed for Windows environments

## Related Projects

- VSCode settings sync
- Cursor settings sync
- Windows Terminal settings sync

## License

MIT
