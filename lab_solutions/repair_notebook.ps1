$path = "c:/Users/jihun/OneDrive/Desktop/coding/MLE/master/lab_solutions/Lab 1a - Linear Models for Regression Solution.ipynb"
$content = [IO.File]::ReadAllText($path)

# Find the last occurrence of a cell start.
# Cells start with indented brace. Typically 3 spaces or more.
# Let's search for the pattern `,   {` which separates cells in the array.
$lastCellIndex = $content.LastIndexOf(",   {")

if ($lastCellIndex -eq -1) {
    # Maybe only one cell? Or different formatting.
    # Try searching for just `{` indented?
    # Or assume formatting `  {` (2 spaces).
    $lastCellIndex = $content.LastIndexOf(",  {")
}

if ($lastCellIndex -gt 0) {
    # Truncate content up to that index
    $newContent = $content.Substring(0, $lastCellIndex)
    
    # Append closing structure
    $newContent += "
 ],
 ""metadata"": {
  ""kernelspec"": {
   ""display_name"": ""Python 3"",
   ""language"": ""python"",
   ""name"": ""python3""
  },
  ""language_info"": {
   ""codemirror_mode"": {
    ""name"": ""ipython"",
    ""version"": 3
   },
   ""file_extension"": "".py"",
   ""mimetype"": ""text/x-python"",
   ""name"": ""python"",
   ""nbconvert_exporter"": ""python"",
   ""pygments_lexer"": ""ipython3"",
   ""version"": ""3.8.5""
  }
 },
 ""nbformat"": 4,
 ""nbformat_minor"": 4
}"
    
    $fixPath = "c:/Users/jihun/OneDrive/Desktop/coding/MLE/master/lab_solutions/Lab 1a - Linear Models for Regression Solution_repaired.ipynb"
    [IO.File]::WriteAllText($fixPath, $newContent)
    Write-Output "Repaired notebook saved to $fixPath"
} else {
    Write-Output "Could not find a valid cell separator to truncate at."
}
