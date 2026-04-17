import json
import subprocess
import sys

output = subprocess.run(['swaymsg', '-t', 'get_outputs'],stdout=subprocess.PIPE)

res = json.loads(output.stdout.decode('utf-8'))
val = 0
arg = sys.argv[1]
current_monitor = res[0]
for monitor in res:
    if monitor['serial'] == str(arg):
        current_monitor = monitor
        break

if current_monitor['active'] == False:
    out = {"alt" : "active", "class" : "active"}
else:
    out = {"alt" : "deactive", "class" : "deactive"}


print(json.dumps(out),flush=True,end='')
