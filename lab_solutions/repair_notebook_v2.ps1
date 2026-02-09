$path = "c:/Users/jihun/OneDrive/Desktop/coding/MLE/master/lab_solutions/Lab 1a - Linear Models for Regression Solution.ipynb"
$content = [IO.File]::ReadAllText($path)

# Find the last occurrence of `"cell_type":`
$lastCellTypeIndex = $content.LastIndexOf("""cell_type"":")

if ($lastCellTypeIndex -gt 0) {
    # Scan backwards from there to find the opening brace `{`
    $openingBraceIndex = $content.LastIndexOf("{", $lastCellTypeIndex)
    
    # We want to keep everything BEFORE this cell, so check for comma before brace
    # It should be something like `}, {` or `, {` depending on formatting.
    # We'll search backwards for `,` before the brace.
    $commaIndex = $content.LastIndexOf(",", $openingBraceIndex)
    
    if ($commaIndex -gt 0) {
        # Valid truncation point found
        $newContent = $content.Substring(0, $commaIndex)
        
        # Append standard footer (closing array and main object)
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
    }
    else {
        Write-Output "Found cell_type but no preceding comma. Maybe first cell?"
    }
}
else {
    Write-Output "Could not find 'cell_type' key in file."
}
