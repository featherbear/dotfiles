#!/usr/bin/python3
import os

import sys

isChange = True
if len(sys.argv) > 1 and sys.argv[1] == "-r":
  isChange = False

interface = "wlp0s20f3"

class downedInterface:
  def __init__(self, interface: str):
    self.interface = interface
  def __enter__(self):
    os.system(f"sudo ifconfig {self.interface} down")
  def __exit__(self, *_):
    os.system(f"sudo ifconfig {interface} up")

def getMAC(interface):
  os.system(f"ifconfig {interface} | grep ether | cut -d ' ' -f 10")

if isChange:
  with downedInterface(interface):
    os.system(f"sudo macchanger -r -b {interface} > /dev/null")
    getMAC(interface)
    print(f"Reset MAC address with: {sys.argv[0]} -r")
else:
  with downedInterface(interface):
    os.system(f"sudo macchanger -p {interface} > /dev/null")
    print("MAC address reset")
