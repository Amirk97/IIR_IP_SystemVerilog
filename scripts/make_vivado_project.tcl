# Replace with your Vivado project path
set project_path [lindex $argv 0]

# Open the project
open_project $project_path

# Elaborate the design
# This runs elaboration on the current top module set in your project
# If you need to specify a particular run, use 'launch_runs' instead
# Here, just running elaborate command:
elaborate
