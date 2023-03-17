# GIT SCRIPTS

This script is a Git assistant designed to make the use of Git more intuitive and user-friendly for beginners. It provides a menu-based interface that guides the user through the most common Git commands.

## Usage
To use this script, simply run it in a Git repository directory:

./git-scripts.sh

The script will check if a .git directory exists in the current directory. If it doesn't, it will create a new repository.

The script will then display a menu of options for the user to choose from. The options include:

- View the repository status (git status)
- Add and/or update files in the origin folder and view their status
- Create a commit for the project (git commit -m "commit message")
- View the history of all commits (git log)
- Link the local repository with an online repository (git remote add origin)
- Push changes to the remote repository (git push -u origin)
- Create a new branch (git branch -M)
- View existing branches (git branch -a)
- Move to a specified branch (git checkout)
- Delete the local repository

The user can select an option by entering the corresponding number.

## Notes
- This script assumes that Git is already installed and configured on the user's machine.
- The script does not cover all of Git's functionality and is intended for beginners.
- The script is created by Paolo Troni, and you can find his Github profile on the script output and here: https://github.com/PaoloTroni.

Enjoy using this Git assistant!




