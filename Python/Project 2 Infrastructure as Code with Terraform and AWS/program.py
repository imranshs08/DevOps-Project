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

def terraform_destroy():
    subprocess.run(["terraform", "destroy", "-auto-approve"])
    print("Terraform Resource Deleted")

def main():
    print("Choose an action:")
    print("1. Create Resources")
    print("2. Destroy Resources")
    print("3. Create and Destroy Resources")
    choice = input("Enter your choice (1/2/3): ")

    if choice == "1":
        terraform_init()
        terraform_plan()
        terraform_apply()

    elif choice == "2":
        terraform_init()
        terraform_destroy()

    elif choice == "3":
        terraform_init()
        terraform_plan()
        terraform_apply()
        terraform_destroy()
    else:
        print("Invalid choice. Please choose 1, 2, or 3.")
if __name__ == "__main__":
    main()