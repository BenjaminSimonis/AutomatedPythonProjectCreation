from constants import ACCESS_TOKEN

from github import Github
import sys

def main():
    folderName = str(sys.argv[1])
    user = Github(ACCESS_TOKEN).get_user()
    repo = user.create_repo(folderName)
    print("Succesfully created repository {}".format(folderName))

if __name__ == '__main__':
    main()