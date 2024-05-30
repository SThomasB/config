
import sys
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


