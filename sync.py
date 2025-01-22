import sys
import os
import shutil

# global vars
src = "/etc/nixos/"
srcl = [ 
    "/etc/nixos/" 
    "~/.config/kitty/"
    "~/.config/fastfetch/"
    "~/.config/nushell/"
]

# args
destinc = sys.argv[1]
sds = sys.argv[2]

if destinc == 'desktop':
	dest = "~/GitRepos/QDOS/nix-config/"

elif destinc == 'laptop':
	dest = "~/GitRepos/QDOS/laptop/nix-config/" 

else:
	print('ERROR: Invalid Input')

# actual magic
if sds == 'sync':
    src_files = os.listdir(src)

    for file_name in src_files:
        full_file_name = os.path.join(src, file_name)
    if os.path.isfile(full_file_name):
        shutil.copy(full_file_name, dest)

elif sds == 'desync':
    src_files = os.listdir(src)

    for file_name in src_files:
        full_file_name = os.path.join(dest, file_name)
    if os.path.isfile(full_file_name):
        shutil.copy(full_file_name, src)

else:
	print('ERROR: Invalid Input')
