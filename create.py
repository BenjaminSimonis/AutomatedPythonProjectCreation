from constants import ACCESS_TOKEN, GITLAB_URL, GITLAB_ACCESS_TOKEN

from github import Github
import gitlab
import sys

def main():
    folderName = str(sys.argv[1])
    
    if len(sys.argv) == 3:
        codebase = str(sys.argv[2])
    
    if codebase == "gh":
        user = Github(ACCESS_TOKEN).get_user()
        repo = user.create_repo(folderName)
        print("Succesfully created repository {}".format(folderName))
    elif codebase == "gl":
        gl = gitlab.Gitlab(GITLAB_URL, private_token=GITLAB_ACCESS_TOKEN)
        repo = gl.projects.create({'name': folderName})
        print("Succesfully created repository {}".format(folderName))
    else:
        print("No remote repository created!")

if __name__ == '__main__':
    main()