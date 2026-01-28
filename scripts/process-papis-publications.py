#! python

import yaml
import subprocess
import os
import shutil

def process_papis_publications():
    # Configuration
    template_path = "typ/templates/publication-post.typ"
    typst_output_dir = "content/publication"
    yaml_output_dir = "yaml"
    
    # Ensure directories exist
    shutil.rmtree(yaml_output_dir)
    shutil.rmtree(typst_output_dir)
    os.makedirs(typst_output_dir, exist_ok=True)
    os.makedirs(yaml_output_dir, exist_ok=True)

    # Define the shell command
    command = ["papis", "export", "--all", "--format", "yaml", "project:MyPubs"]
    
    print("Fetching data from papis...")

    try:
        # Run command and capture output
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        yaml_content = result.stdout

        if not yaml_content.strip():
            print("No data returned from papis.")
            return

        # Check if template exists
        if not os.path.exists(template_path):
            print(f"Error: Template not found at {template_path}")
            return

        # Read the template once
        with open(template_path, 'r', encoding='utf-8') as f:
            template_content = f.read()

        documents = yaml.safe_load_all(yaml_content)
        
        count = 0
        for doc in documents:
            if doc is None or 'ref' not in doc:
                continue
                
            ref = doc['ref']
            
            # File paths
            yaml_filename = f"{ref}.yaml"
            yaml_file_path = os.path.join(yaml_output_dir, yaml_filename)
            
            typst_filename = f"{ref}.typ"
            typst_file_path = os.path.join(typst_output_dir, typst_filename)

            # 1. Save the individual YAML file to the root /yaml folder
            with open(yaml_file_path, 'w', encoding='utf-8') as f:
                yaml.dump(doc, f, sort_keys=False, allow_unicode=True)
            
            # 2. Create the Typst file in content/publication/
            with open(typst_file_path, 'w', encoding='utf-8') as typ_file:
                # Path is relative from content/publication/ to the root yaml/ folder
                typ_file.write(f'#let pub = yaml("/{yaml_output_dir}/{yaml_filename}")\n')
                typ_file.write(template_content)
            
            print(f"Created: {typst_file_path} and {yaml_file_path}")
            count += 1
            
        print(f"\nSuccess! Generated {count} publication sets.")

    except subprocess.CalledProcessError as e:
        print(f"Error executing papis: {e.stderr}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

from pathlib import Path

if __name__ == "__main__":
    script_path = Path(__file__).parent.resolve()
    root_path = script_path.parent.resolve()
    os.chdir(root_path)
    print("Working Directory:", os.getcwd())
    process_papis_publications()
