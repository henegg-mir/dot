import json
import subprocess
import os
import sys

output = subprocess.run(['swaymsg', '-t', 'get_outputs'],stdout=subprocess.PIPE)

res = json.loads(output.stdout.decode('utf-8'))
val = 0
arg = sys.argv[1]
current_monitor = res[0]
for monitor in res:
    if monitor['name'] == str(arg):
        current_monitor = monitor
        break

  
if current_monitor['active'] == True:
    os.system("swaymsg output " + str(sys.argv[1]) + " disable")
else:
    os.system("swaymsg output " + str(sys.argv[1]) + " enable")
