import os

print("=======================================================")
print("===================arch installer======================")
print("=======================================================")

option=str(input("make the disk partition with 1 cfdisk or 2 fdisk: "))
os.system("fdisk -l")
disk=str(input("select the device ex: /dev/sda#: "))
def particiones(option):
    if option == "1":
        os.system("cfdisk ",disk)
    if option == "2":
        os.system("fdisk ",disk)
    if option != ("1" or "2"):
        print("no there are partitions repeat the process")
        particiones()
    repeat=str(input("do you need repeat the process Y/n"))
    if repeat == ("Y"or"n"):
        particiones()
    else:
        pass

def format():
    os.system("lsblk")
    while True:
        letter=str(input("device's letter: "))
        device=str(input("put the device's number"))

particiones()
      
