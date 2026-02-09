import json
import os

file_path = "c:/Users/jihun/OneDrive/Desktop/coding/MLE/master/lab_solutions/Lab 1a - Linear Models for Regression Solution.ipynb"

try:
    with open(file_path, 'r', encoding='utf-8') as f:
        nb = json.load(f)
    
    found_error = False
    for i, cell in enumerate(nb.get('cells', [])):
        if cell.get('cell_type') == 'code':
            outputs = cell.get('outputs', [])
            for output in outputs:
                if output.get('output_type') == 'error':
                    found_error = True
                    print(f"Error found in cell {i}:")
                    print(f"Ename: {output.get('ename')}")
                    print(f"Evalue: {output.get('evalue')}")
                    traceback = output.get('traceback', [])
                    print("Traceback:")
                    for line in traceback:
                        print(line)
                    print("-" * 20)
    
    if not found_error:
        print("No recorded errors found in notebook outputs.")
        
except Exception as e:
    print(f"Failed to read or parse notebook: {e}")
