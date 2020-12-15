import "graphics" for Canvas, Color

class Game {
  static init() {}
  static update() {}
  static draw(alpha) {
    Canvas.print("Hi from DOMEJam 2021!", 10, 10, Color.white)
    Canvas.print("alpha = %(alpha)", 10, 30, Color.purple)
  }
}
