# Setup and troubleshooting

## Student setup

### 1. Check PowerShell

Open the Start menu, search for **Windows PowerShell**, and run:

```powershell
$PSVersionTable.PSVersion
```

The first number should be `5` or higher. This course is tested with Windows PowerShell 5.1.

### 2. Install VS Code

Download VS Code from <https://code.visualstudio.com/>. In VS Code:

1. Select the Extensions icon.
2. Search for **PowerShell** by Microsoft.
3. Select **Install**.
4. Use **File > Open Folder** to open the extracted course folder.

### 3. Open the terminal

Use **Terminal > New Terminal**. If the prompt does not say PowerShell, use the arrow beside the plus button and choose **Windows PowerShell**.

### 4. Run a script

From the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\01-welcome\examples\hero-id.ps1
```

For an interactive script, use the same pattern and answer its prompts.

## Common problems

### “Running scripts is disabled”

Use the course command shown above. It launches a child PowerShell process with a temporary bypass. Do not change a school computer's permanent policy without permission.

### “The term ... is not recognized”

Check spelling and confirm the terminal is in the repository root:

```powershell
Get-Location
Get-ChildItem
```

Change location with quotes if the path contains spaces:

```powershell
Set-Location "C:\path\to\Signal Academy"
```

### The terminal is waiting and appears frozen

The script may be waiting for `Read-Host` input. Read the last prompt and type an answer. Press `Ctrl+C` to stop a running script safely.

### Strange quotation marks or dash errors

Code needs straight quotes (`"`) and normal hyphens (`-`). Retype characters copied from a formatted document.

### Reset generated lesson data

Lesson scripts write only inside their lesson folders or the system temporary folder. Delete generated `.csv`, `.json`, or `.txt` files named in the lesson and rerun the starter script.

## Optional Git setup

Git is not included with every Windows installation. Ask a teacher/guardian before installing it. Check with:

```powershell
git --version
```

If it is installed, set a non-sensitive display name and email appropriate for the class environment. Never commit passwords, API keys, home addresses, or other private data.

