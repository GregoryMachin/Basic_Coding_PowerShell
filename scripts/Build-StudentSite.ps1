[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

$lessons = @(
    [pscustomobject]@{ Number = 1; Slug = '01-welcome'; Title = 'Welcome to Signal Academy'; Focus = 'Output, variables, and your first script'; Image = 'PowerShell-Variables-and-Data-Types.png' }
    [pscustomobject]@{ Number = 2; Slug = '02-calculations'; Title = 'Power-Up Calculations'; Focus = 'Input, numbers, and useful calculations'; Image = 'PowerShell-Comparison-Operators.png' }
    [pscustomobject]@{ Number = 3; Slug = '03-decisions'; Title = 'Mission Decisions'; Focus = 'Boolean logic and branching'; Image = 'PowerShell-IF-Statements.png' }
    [pscustomobject]@{ Number = 4; Slug = '04-loops'; Title = 'Patrol Patterns'; Focus = 'Repeat work safely with loops'; Image = 'PowerShell-Loops.png' }
    [pscustomobject]@{ Number = 5; Slug = '05-collections'; Title = 'Team Rosters'; Focus = 'Arrays, hashtables, objects, and pipelines'; Image = 'PowerShell-Pipeline.png' }
    [pscustomobject]@{ Number = 6; Slug = '06-functions'; Title = 'Reusable Mission Tools'; Focus = 'Functions, parameters, and testing'; Image = 'PowerShell-Functions-Quick-Guide-v2.png' }
    [pscustomobject]@{ Number = 7; Slug = '07-files'; Title = 'Clue Files'; Focus = 'Read, transform, and save data'; Image = 'PowerShell-Reading-and-Writing-Files.png' }
    [pscustomobject]@{ Number = 8; Slug = '08-errors'; Title = 'Safe Operations'; Focus = 'Validation and useful error handling'; Image = 'PowerShell-Error-Handling.png' }
    [pscustomobject]@{ Number = 9; Slug = '09-data'; Title = 'City Data Network'; Focus = 'JSON, trustworthy data, and sorting'; Image = 'PowerShell-Export-and-Import.png' }
    [pscustomobject]@{ Number = 10; Slug = '10-command-centre'; Title = 'Hero Command Centre'; Focus = 'Plan, combine, test, and explain'; Image = 'PowerShell-Cheat-Sheet-A1.png' }
)

function ConvertTo-InlineHtml {
    param([string]$Text)

    $encoded = [System.Net.WebUtility]::HtmlEncode($Text)
    $encoded = $encoded -replace '&lt;br\s*/?&gt;', ''
    $encoded = [regex]::Replace($encoded, '\[([^\]]+)\]\(([^)]+)\)', {
            param($match)
            $label = $match.Groups[1].Value
            $href = $match.Groups[2].Value
            $href = $href -replace 'README\.md', 'index.html'
            if ($href -eq '../../index.html') { $href = '../../index.html' }
            '<a href="{0}">{1}</a>' -f $href, $label
        })
    $encoded = [regex]::Replace($encoded, '`([^`]+)`', '<code>$1</code>')
    $encoded = [regex]::Replace($encoded, '\*\*([^*]+)\*\*', '<strong>$1</strong>')
    $encoded
}

function ConvertFrom-CourseMarkdown {
    param([Parameter(Mandatory)][string]$Markdown)

    $lines = $Markdown -split "`r?`n"
    $html = New-Object System.Collections.Generic.List[string]
    $paragraph = New-Object System.Collections.Generic.List[string]
    $listType = $null
    $inCode = $false
    $codeLanguage = ''
    $codeLines = New-Object System.Collections.Generic.List[string]

    function Close-Paragraph {
        if ($paragraph.Count -gt 0) {
            $joined = ($paragraph -join ' ').Trim()
            if ($joined) { $html.Add('<p>' + (ConvertTo-InlineHtml $joined) + '</p>') }
            $paragraph.Clear()
        }
    }

    function Close-List {
        if ($listType) {
            $html.Add("</$listType>")
            Set-Variable -Name listType -Value $null -Scope 1
        }
    }

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $trimmed = $line.Trim()

        if ($inCode) {
            if ($trimmed -eq '```') {
                $code = [System.Net.WebUtility]::HtmlEncode($codeLines -join "`n")
                $className = if ($codeLanguage) { ' class="language-' + $codeLanguage + '"' } else { '' }
                $html.Add("<pre><code$className>$code</code></pre>")
                $codeLines.Clear()
                $inCode = $false
                $codeLanguage = ''
            }
            else {
                $codeLines.Add($line.TrimStart())
            }
            continue
        }

        if ($trimmed -match '^```(.*)$') {
            Close-Paragraph
            Close-List
            $inCode = $true
            $codeLanguage = $Matches[1].Trim()
            continue
        }

        if ($trimmed -match '^(#{1,6})\s+(.+)$') {
            Close-Paragraph
            Close-List
            $level = $Matches[1].Length
            $heading = ConvertTo-InlineHtml $Matches[2]
            $id = (($Matches[2].ToLowerInvariant() -replace '[^a-z0-9\s-]', '') -replace '\s+', '-').Trim('-')
            $html.Add(('<h{0} id="{1}">{2}</h{0}>' -f $level, $id, $heading))
            continue
        }

        if ($i + 1 -lt $lines.Count -and $trimmed.StartsWith('|') -and $lines[$i + 1].Trim() -match '^\|?\s*:?-+') {
            Close-Paragraph
            Close-List
            $tableRows = New-Object System.Collections.Generic.List[object]
            while ($i -lt $lines.Count -and $lines[$i].Trim().StartsWith('|')) {
                $cells = @($lines[$i].Trim().Trim('|').Split('|') | ForEach-Object { $_.Trim() })
                $tableRows.Add($cells)
                $i++
            }
            $i--
            $headers = $tableRows[0]
            $html.Add('<div class="table-wrap"><table><thead><tr>')
            foreach ($cell in $headers) { $html.Add('<th>' + (ConvertTo-InlineHtml $cell) + '</th>') }
            $html.Add('</tr></thead><tbody>')
            for ($rowIndex = 2; $rowIndex -lt $tableRows.Count; $rowIndex++) {
                $html.Add('<tr>')
                foreach ($cell in $tableRows[$rowIndex]) { $html.Add('<td>' + (ConvertTo-InlineHtml $cell) + '</td>') }
                $html.Add('</tr>')
            }
            $html.Add('</tbody></table></div>')
            continue
        }

        if ($trimmed -match '^[-*]\s+(.+)$') {
            Close-Paragraph
            if ($listType -ne 'ul') { Close-List; $listType = 'ul'; $html.Add('<ul>') }
            $html.Add('<li>' + (ConvertTo-InlineHtml $Matches[1]) + '</li>')
            continue
        }

        if ($trimmed -match '^\d+\.\s+(.+)$') {
            Close-Paragraph
            if ($listType -ne 'ol') { Close-List; $listType = 'ol'; $html.Add('<ol>') }
            $html.Add('<li>' + (ConvertTo-InlineHtml $Matches[1]) + '</li>')
            continue
        }

        if (-not $trimmed) {
            Close-Paragraph
            Close-List
            continue
        }

        $paragraph.Add($trimmed)
    }

    Close-Paragraph
    Close-List
    $html -join "`n"
}

function Get-NavigationHtml {
    param([string]$Prefix, [int]$CurrentLesson = 0)

    $items = foreach ($lesson in $lessons) {
        $active = if ($lesson.Number -eq $CurrentLesson) { ' aria-current="page" class="active"' } else { '' }
        '<a{0} href="{1}lessons/{2}/index.html"><span>{3:00}</span>{4}</a>' -f $active, $Prefix, $lesson.Slug, $lesson.Number, $lesson.Title
    }
    $items -join "`n"
}

function New-PageShell {
    param(
        [Parameter(Mandatory)][string]$Title,
        [Parameter(Mandatory)][string]$Description,
        [Parameter(Mandatory)][string]$Body,
        [string]$Prefix = '',
        [int]$CurrentLesson = 0,
        [string]$Aside = ''
    )

    $navigation = Get-NavigationHtml -Prefix $Prefix -CurrentLesson $CurrentLesson
    @"
<!doctype html>
<html lang="en-NZ">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="$Description">
  <title>$Title | Signal Academy</title>
  <link rel="stylesheet" href="${Prefix}assets/course.css">
</head>
<body>
  <a class="skip-link" href="#lesson-content">Skip to lesson</a>
  <header class="site-header">
    <a class="brand" href="${Prefix}index.html"><span>PS&gt;</span> Signal Academy</a>
    <button class="nav-toggle" type="button" aria-expanded="false" aria-controls="course-nav">Lessons</button>
    <nav class="utility-nav" aria-label="Course links">
      <a href="${Prefix}setup.html">Setup</a>
      <a href="${Prefix}references.html">Visual references</a>
    </nav>
  </header>
  <div class="course-layout">
    <aside class="course-nav" id="course-nav" aria-label="Course lessons">
      <p class="eyebrow">Your training path</p>
      $navigation
    </aside>
    <main id="lesson-content" class="content-shell">
      $Aside
      <article class="lesson-content">
        $Body
      </article>
    </main>
  </div>
  <footer><span>PS&gt;</span> Learn clearly. Test safely. Help your city.</footer>
  <script src="${Prefix}assets/course.js"></script>
</body>
</html>
"@
}

$lessonCards = foreach ($lesson in $lessons) {
    @"
<a class="lesson-card" href="lessons/$($lesson.Slug)/index.html">
  <span class="lesson-number">$($lesson.Number.ToString('00'))</span>
  <h2>$($lesson.Title)</h2>
  <p>$($lesson.Focus)</p>
  <span class="card-action">Start lesson &rarr;</span>
</a>
"@
}

$homeBody = @"
<section class="hero">
  <div>
    <p class="eyebrow">PowerShell hero training &middot; Ages 13+</p>
    <h1>Learn to code.<br>Clear the signal.</h1>
    <p class="lede">Ten practical missions take you from your first variable to a complete interactive Command Centre. You will write real scripts, make choices, test ideas, and build something you can explain.</p>
    <div class="hero-actions">
      <a class="button primary" href="lessons/01-welcome/index.html">Begin Lesson 1</a>
      <a class="button secondary" href="setup.html">Set up your computer</a>
    </div>
  </div>
  <a class="hero-reference" href="Images/Final%20images/PowerShell-Cheat-Sheet-A1.png">
    <img src="Images/Final%20images/PowerShell-Cheat-Sheet-A1.png" alt="Signal Academy PowerShell cheat sheet">
    <span>Open the full cheat sheet &nearr;</span>
  </a>
</section>
<section class="start-here" aria-labelledby="start-title">
  <p class="eyebrow">How the course works</p>
  <h2 id="start-title">One mission at a time</h2>
  <div class="steps">
    <div><strong>1</strong><h3>Read</h3><p>Meet one programming idea through a short example.</p></div>
    <div><strong>2</strong><h3>Run</h3><p>Use the supplied script and predict what will change.</p></div>
    <div><strong>3</strong><h3>Build</h3><p>Complete the challenge, test it, and explain your choices.</p></div>
  </div>
</section>
<section aria-labelledby="missions-title">
  <p class="eyebrow">Course map</p>
  <h2 id="missions-title">Choose your next mission</h2>
  <div class="lesson-grid">$($lessonCards -join "`n")</div>
</section>
"@

$homePage = New-PageShell -Title 'PowerShell Hero Training' -Description 'A student-focused, beginner-friendly PowerShell coding course in ten practical lessons.' -Body $homeBody
Set-Content -LiteralPath (Join-Path $repoRoot 'index.html') -Value $homePage -Encoding UTF8

$setupMarkdown = Get-Content -LiteralPath (Join-Path $repoRoot 'setup.md') -Raw -Encoding UTF8
$setupBody = ConvertFrom-CourseMarkdown -Markdown $setupMarkdown
$setupPage = New-PageShell -Title 'Setup and troubleshooting' -Description 'Prepare Windows and VS Code for Signal Academy.' -Body $setupBody
Set-Content -LiteralPath (Join-Path $repoRoot 'setup.html') -Value $setupPage -Encoding UTF8

foreach ($lesson in $lessons) {
    $lessonFolder = Join-Path (Join-Path $repoRoot 'lessons') $lesson.Slug
    $markdown = Get-Content -LiteralPath (Join-Path $lessonFolder 'README.md') -Raw -Encoding UTF8
    $body = ConvertFrom-CourseMarkdown -Markdown $markdown
    $imageUrl = '../../Images/Final%20images/' + $lesson.Image.Replace(' ', '%20')
    $aside = @"
<section class="lesson-banner">
  <div><p class="eyebrow">Lesson $($lesson.Number) of 10</p><p>$($lesson.Focus)</p></div>
  <a href="$imageUrl"><img src="$imageUrl" alt="PowerShell reference for $($lesson.Title)"><span>Open reference image &nearr;</span></a>
</section>
"@
    $page = New-PageShell -Title $lesson.Title -Description $lesson.Focus -Body $body -Prefix '../../' -CurrentLesson $lesson.Number -Aside $aside
    Set-Content -LiteralPath (Join-Path $lessonFolder 'index.html') -Value $page -Encoding UTF8
}

$imageFolder = Join-Path $repoRoot 'Images\Final images'
$galleryCards = foreach ($imageFile in Get-ChildItem -LiteralPath $imageFolder -File -Filter '*.png' -Recurse | Sort-Object FullName) {
    $relativeImagePath = $imageFile.FullName.Substring($imageFolder.Length + 1).Replace('\', '/')
    $encodedName = (($relativeImagePath -split '/') | ForEach-Object { [uri]::EscapeDataString($_) }) -join '/'
    $displayName = [System.IO.Path]::GetFileNameWithoutExtension($imageFile.Name) -replace '-', ' '
    $relativeFolder = Split-Path $relativeImagePath -Parent
    if ($relativeFolder) { $displayName += ' (' + $relativeFolder.Replace('\', ' / ') + ')' }
    $layoutClass = if ($imageFile.Name -like '*Cheat-Sheet*') { ' reference-landscape' } else { '' }
    @"
<a class="reference-card$layoutClass" href="Images/Final%20images/$encodedName">
  <img src="Images/Final%20images/$encodedName" alt="$displayName reference poster" loading="lazy">
  <span>$displayName</span>
</a>
"@
}
$referenceBody = @"
<p class="eyebrow">Linked course material</p>
<h1>PowerShell visual references</h1>
<p class="lede">Use these posters while you work. Select any image to open the full-resolution version. The lesson text and runnable scripts remain the source of truth for code.</p>
<div class="reference-grid">$($galleryCards -join "`n")</div>
"@
$referencePage = New-PageShell -Title 'Visual references' -Description 'Linked PowerShell reference posters for Signal Academy students.' -Body $referenceBody
Set-Content -LiteralPath (Join-Path $repoRoot 'references.html') -Value $referencePage -Encoding UTF8

Write-Host "Built index.html, setup.html, references.html, and $($lessons.Count) lesson pages." -ForegroundColor Green
