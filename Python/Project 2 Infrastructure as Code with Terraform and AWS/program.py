import subprocess
import time
def terraform_init():
    subprocess.run(["terraform", "init"])
    print("Terraform Initilization Completed")
def terraform_plan():
    subprocess.run(["terraform", "plan"])
    print("Terraform Plan Completed")
def terraform_apply():
    subprocess.run(["terraform", "apply", "-auto-approve"])
    print("Terraform Resource Creation Completed")
    time.sleep(600)
def terraform_destroy():
    subprocess.run(["terraform", "destroy", "-auto-approve"])
    print("Terraform Resource Deleted")
    time.sleep(600)

if __name__ == "__main__":
    terraform_init()
    terraform_plan()
    terraform_apply()
    terraform_destroy()