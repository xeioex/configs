#! /usr/bin/python

import subprocess as sp
from inspect import isfunction
import functools as ft
import sys, os

def dump():
    return  sp.check_output("pacmd dump".split(" "))

def dump_volumes():
    return sp.check_output("pacmd dump-volumes".split(" "))

def muted(name):
    for l in dump().split("\n"):
        s = l.split()
        if len(s) == 3 and \
            s[0] == 'set-sink-mute' and s[1] == name:
            return {"yes" : True, "no" : False}[s[2]]

    raise Exception("Unknown name: {}".format(name))


def volume(index):
    for l in dump_volumes().split("\n"):
        s = l.lstrip(">").split()
        s = map(lambda x: x.rstrip(":%"), s)

        if len(s) >= 6 and \
            s[0] == 'Sink' and s[1] == str(index):
            return int(s[5])

    raise Exception("Unknown index: {}".format(index))

def cmd(template, *args):
    def lazy_wrap():
        ar = [x() if isfunction(x) else x for x in args]
        sp.check_call(template.format(*ar), shell = True)

    return lazy_wrap

name = "alsa_output.usb-ESI_Audiotechnik_GmbH_Dr._DAC_nano-01-nano.analog-stereo"

def main():
    cmds = {
        "plus" : cmd("pactl set-sink-volume {} +5%", name),
        "minus" : cmd("pactl set-sink-volume {} -- -5%", name),
        "mutetoggle" : cmd("pactl set-sink-mute {} {}", name, 
                           lambda: 0 if muted(name) else 1),
        "mutestatus" : lambda: "MUTED" if muted(name) else "",
        "volume" : lambda: "{}".format(volume(1))
    }

    def usage(msg):
        print msg
        print "Possible arguments are: {}".format(cmds.keys())
        return 1

    if len(sys.argv) < 2:
        return usage("Too few args")

    sp.check_call("pacmd set-default-sink {}".format(name),
                  stdout=open(os.devnull, 'wb'), shell=True)

    try:
        o = cmds[sys.argv[1]]()

        if o:
            print o

        return 0

    except KeyError as e:
        return usage("Unknown command: {}".format(sys.argv[1]))

if __name__ == "__main__":
    main()
