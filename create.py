from constants import GITHUB_ACCESS_TOKEN, GITLAB_HTTPS, GITLAB_ACCESS_TOKEN

from github import Github
import gitlab
import sys

def main():
    folderName = str(sys.argv[1])
    
    if len(sys.argv) == 3:
        codebase = str(sys.argv[2])
    
    if codebase == "gh" and GITHUB_ACCESS_TOKEN:
        user = Github(GITHUB_ACCESS_TOKEN).get_user()
        repo = user.create_repo(folderName)
        print("Succesfully created repository {}".format(folderName))
    elif codebase == "gl" and (GITLAB_HTTPS or GITLAB_ACCESS_TOKEN):
        gl = gitlab.Gitlab(GITLAB_HTTPS, private_token=GITLAB_ACCESS_TOKEN)
        repo = gl.projects.create({'name': folderName})
        print("Succesfully created repository {}".format(folderName))
    else:
        print("No remote repository created! Your variable is not valid or one of your constants isn't set!")

if __name__ == '__main__':
    main()