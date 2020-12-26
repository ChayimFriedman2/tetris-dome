import "graphics" for Canvas

class SizeHelpers {
  // The horizontal padding around the game board. It is calculated so the game board is centered.
  static horizontalPadding { (Canvas.width - (width * brickSize)) / 2 }
  // The vertical padding around the game board. It is calculated so the game board is centered.
  static verticalPadding { (Canvas.height - (height * brickSize)) / 2 }

  static brickSize { 65 }
  static previewBrickSize { 30 }

  static minPadding_ { 10 }

  // The width of the game boards, in bricks.
  static width { ((Canvas.width - (minPadding_ * 2)) / brickSize).floor }
  // The height of the game boards, in bricks.
  static height { ((Canvas.height - (minPadding_ * 2)) / brickSize).floor }
}
