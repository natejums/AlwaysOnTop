import win32gui
import win32con
import keyboard

def always_on_top(hwnd, lParam):
    if keyboard.is_pressed("ctrl + space"):
        win32gui.SetWindowPos(hwnd, win32con.HWND_TOPMOST, 0, 0, 0, 0, win32con.SWP_NOMOVE + win32con.SWP_NOSIZE)

win32gui.EnumWindows(always_on_top, None)
