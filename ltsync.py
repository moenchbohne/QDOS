import os
import shutil

# sync nix
src = "/etc/nixos/"
dest = "/home/quentin/GitRepos/QDOS/laptop/nix-config/"

src_files = os.listdir(src)

for file_name in src_files:
    full_file_name = os.path.join(src, file_name)
    if os.path.isfile(full_file_name):
        shutil.copy(full_file_name, dest)