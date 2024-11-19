def copy_lines_between(start_text, end_text, input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        copy_lines = False
        
        for line in infile:
            if start_text in line:
                copy_lines = True  # Start copying lines
            if copy_lines:
                outfile.write(line)  # Write the current line to the output file
            if end_text in line:
                break  # Stop copying after the line containing "END"

# Usage
input_file = 'configuration.nix'  # Replace with your input file name
output_file = 'packages.txt'  # Replace with your desired output file name
copy_lines_between('# START list of packages', '# END list of packages', input_file, output_file)