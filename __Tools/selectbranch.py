
import subprocess


class WriteHead():
    def __init__(self, line, num_lines):
        self._line = line
        self._line_prev = line
        self.tail = num_lines

    @property
    def line(self):
        return abs(self._line) % self.tail


    def move_head(self, incr):
        self._line_prev = self._line
        self._line+=incr
        self._line = self.line
        if self._line < 0:
            self._line = self.tail - incr + 1

    @property
    def line_distance(self):
        return self.line - self._line_prev


def _quit():...

def _get_branches():
    # Run shell command
    output = subprocess.check_output("git branch", shell=True)

    # Decode byte string to UTF-8 string
    output_str = output.decode("utf-8")
    return output_str.strip().replace("*", "").split()

def _initial_render(branches):
    print(*branches, sep="\n")
    move_cursor_up(len(branches))

def run():...

import sys
def move_cursor_up(n=1):
    sys.stdout.write(f'\033[{n}A')
    sys.stdout.flush()

def move_cursor_down(n=1):
    sys.stdout.write(f'\033[{n}B')
    sys.stdout.flush()

def move_cursor_right(n=1):
    sys.stdout.write(f'\033[{n}C')
    sys.stdout.flush()

def move_cursor_left(n=1):
    sys.stdout.write(f'\033[{n}D')
    sys.stdout.flush()

import msvcrt
import subprocess
def main():
    branches = _get_branches()
    if branches is None:
        return
    _initial_render(branches)
    wh = WriteHead(0, len(branches))
    while True:
        key = ord(msvcrt.getch())

        if key == 224:  # Indicates that an arrow key was pressed
            key = ord(msvcrt.getch())

            if key == 72:
                wh.move_head(-1)


            elif key == 80:
                wh.move_head(1)

        elif key == 13:  # Enter key
            subprocess.check_call(f"git checkout {branches[wh.line]}")
            break

        jump = wh.line_distance
        if jump < 0:
            move_cursor_up(n=abs(jump))
        elif jump > 0:
            move_cursor_down(n=jump)

if __name__ == "__main__":
    main()



