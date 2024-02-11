import subprocess

def terraform_init():
    subprocess.run(["terraform", "init"])
def terraform_plan():
    subprocess.run(["terraform", "plan"])
def terraform_apply():
    subprocess.run(["terraform", "apply", "-auto approve"])
def terraform_destroy():
    subprocess.run(["terraform", "destroy", "-auto approve"])

if __name__ == "__main__":
    terraform_init()
    terraform_plan()
    terraform_apply()
    terraform_destroy()