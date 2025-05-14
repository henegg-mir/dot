
import sys
import subprocess




def add_empty_lines(len,line):
    l = int((len-130)/2)
    for x in range(l):
        line.insert(0,' ')
    return line




def main():
    data = sys.stdin.read()
    arr = []
    i = 0
    while(data[i] != '\n'):
        arr.append(data[i])
        i+=1
    i+=1
    data = data[i-1:]
    len = int(''.join(arr))
    arr = []
    for lines in data:
        
        if(lines == '\n'):
            add_empty_lines(len,arr)
            print(''.join(arr))
            arr = []
            continue
        arr.append(lines)

if __name__=="__main__":
    main()