import sys
import msvcrt
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

class Keys:
    ARROW = 224
    Up = 72
    Down = 80
    Enter = 13
    T = 116
    N = 110

    def __init__(self, handle_input=lambda: ord(msvcrt.getch()), render=lambda: None, exit_key=13, callbacks={}):
        self.handle_input = handle_input
        self.exit_key = exit_key
        self.callbacks = callbacks
        self.render = render

    def run(self):
        while True:
            key = self.handle_input()

            if key == Keys.ARROW:
                key = self.handle_input()

            try:
                self.callbacks[key]()
            except:
                ...

            if key == self.exit_key:
                return
            self.render()



if __name__ == "__main__":
    keys = Keys(
            callbacks={Keys.Up:lambda: print("up"), Keys.Down:lambda: print("down"), Keys.Enter:lambda: print("exit")}
    )
    keys.run()



