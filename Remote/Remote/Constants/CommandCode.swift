// This file was generated by build.rs

enum CommandCode: UInt8 {
    case mouseMoveTo = 0;
    case mouseMoveRelative = 1;
    case mouseDown = 2;
    case mouseUp = 3;
    case mouseClick = 4;
    case mouseNthClick = 5;
    case mouseScrollX = 6;
    case mouseScrollY = 7;
    case keyDown = 8;
    case keyUp = 9;
    case keyClick = 10;
    case keyClickFlags = 11;
}