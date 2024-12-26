import os
import shutil

# global vars
src = "/etc/nixos/"

# destinction
destinction = input('Desktop or Laptop? (D or L)' )

if destinction == 'D':
	dest = "/home/quentin/GitRepos/QDOS/nix-config/"

elif destinction == 'L':
	dest = "/home/quentin/GitRepos/QDOS/laptop/nix-config/" 

else:
	print('ERROR: Invalid Input')

# actual magic
src_files = os.listdir(src)

for file_name in src_files:
    full_file_name = os.path.join(src, file_name)
    if os.path.isfile(full_file_name):
        shutil.copy(full_file_name, dest)
