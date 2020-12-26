import "dome" for Window
import "graphics" for Canvas, Color, Font
import "input" for Keyboard

import "./tetriminos" for Tetrimino
import "./lines" for Lines
import "./size_helpers" for SizeHelpers

class Game {
  static init() {
    Canvas.resize(1440, 1080)

    Window.title = "Tetris!"

    Font.load("Pacifico", "Pacifico/Pacifico-Regular.ttf", 40)
    Font["Pacifico"].antialias = true
    Canvas.font = "Pacifico"
    Font.load("Pacifico-big", "Pacifico/Pacifico-Regular.ttf", 130)
    Font["Pacifico-big"].antialias = true

    __tetrimino = Tetrimino.new()
    __nextTetrimino = Tetrimino.new()
    __lines = Lines.new()

    __counter = 0

    __gameOver = false
  }

  static keyPressedTimes_(key, times) { (key.repeats % times) == 1 }

  static update() {
    if (Keyboard["Up"].justPressed) tryRotateRight()
    if (keyPressedTimes_(Keyboard["Left"], 10)) tryGoLeft()
    if (keyPressedTimes_(Keyboard["Right"], 10)) tryGoRight()
    if (keyPressedTimes_(Keyboard["Down"], 10)) tryGoDown()

    __counter = __counter + 1
    if (__counter == 15) {
      __counter = 0
      nextTurn()
    }
  }

  // Brings the tetrimino down and destroys it if we met the floor.
  static nextTurn() {
    __tetrimino.goDown()

    if (tetriminoInInvalidState()) {
      __tetrimino.goUp()

      for (brick in __tetrimino.bricks) __lines.setAt(brick, __tetrimino.color)

      if (__lines.gameOver) __gameOver = true
      
      __tetrimino = __nextTetrimino
      __nextTetrimino = Tetrimino.new()
    }
  }

  static tryRotateRight() {
    __tetrimino.rotateRight()
    if (tetriminoInInvalidState()) __tetrimino.rotateLeft()
  }
  static tryGoLeft() {
    __tetrimino.goLeft()
    if (tetriminoInInvalidState()) __tetrimino.goRight()
  }
  static tryGoRight() {
    __tetrimino.goRight()
    if (tetriminoInInvalidState()) __tetrimino.goLeft()
  }
  static tryGoDown() {
    __tetrimino.goDown()
    if (tetriminoInInvalidState()) __tetrimino.goUp()
  }

  static isOutOfBoard(brick) { brick.x < 0 || brick.y < 0 ||
    brick.x >= SizeHelpers.width }

  // Returns true if the current tetrimino is in invalid state - crossing
  // board boundaries or overlapping other bricks.
  static tetriminoInInvalidState() { __tetrimino
    .bricks
    .any {|brick| __lines[brick] || isOutOfBoard(brick) } }
  
  static draw(alpha) {
    if (__gameOver) {
      Canvas.cls()
      Canvas.print("Game Over!", 350, 350, Color.white, "Pacifico-big")
    } else {
      Canvas.cls(Color.white)

      Canvas.print("Lines cleared: %(__lines.clearedCount)", 10, 10, Color.black)

      __nextTetrimino.drawPreview()

      __lines.draw()
      __tetrimino.draw()
    }
  }
}
