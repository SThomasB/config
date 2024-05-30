
import os
import sys
import cui
import writehead
PORTALS = "C:\\devil\\__Tools\\.blink\\portals"

def portals(arg=None):

    with open(PORTALS, "r") as fd:
        if arg == "full":
            print(*fd.readlines())
        else:
            print(*(s.split("\\")[-1] for s in fd.readlines()))


def new_portal(arg=None):
    with open(PORTALS, "r") as fdread:
        portals = [s.strip() for s in fdread.readlines()]

    if (directory:=os.getcwd()) in portals:
        print(f"\033[32mportal for {directory} already exists\033[0m")
        return
    with open(PORTALS, "w") as fdwrite:
        print(directory)
        portals.append(directory)
        print(*portals, sep="\n", file=fdwrite)

    print(f"\033[32mportal created in {directory}\033[0m")


def clear_portals(*args):

    with open(PORTALS, "r") as fd:
        portals = [s.strip() for s in  fd.readlines()]

    with open(PORTALS, "w") as fd:
        new_portals = []
        for portal in portals:
            if not portal in args:
                new_portals.append(portal)
        print(*new_portals, sep="\n", file= fd)




def blink():
    with open(PORTALS, "r") as fd:
        portals = [s.strip() for s in fd.readlines()]
        print(*(s.split("\\")[-1] for s in portals), sep="\n")

    cui.move_cursor_up(len(portals))
    wh = writehead.WriteHead(0, num_lines=len(portals))

    def up():
        wh.move_head(-1)

    def down():
        wh.move_head(1)

    def move_cursor():
        if wh.line_distance < 0:
            cui.move_cursor_up(abs(wh.line_distance))
        elif wh.line_distance > 0:
            cui.move_cursor_down(wh.line_distance)

    with open(os.path.abspath("C:\\devil\\__Tools\\.blink\\to"), "w") as fd:
        ui = cui.Keys(
            render = move_cursor,
            exit_key=cui.Keys.Enter,
            callbacks = {
                cui.Keys.N: up,
                cui.Keys.T : down,
                cui.Keys.Up: up,
                cui.Keys.Down: down,
                cui.Keys.Enter : lambda: print(portals[wh.line], file=fd)
            }
        )
        ui.run()


if __name__=="__main__":
    match sys.argv:
        case [_, "portals", *args]:
            portals(*args)
        case [_, "new", *args]:
            new_portal(*args)
        case [_, "clear", *args]:
            clear_portals(*args)

        case [_, "blink"]:
            blink()

        case _:
            print("action undefined")





