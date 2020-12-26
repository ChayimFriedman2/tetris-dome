import "random" for Random as RandomClass
import "graphics" for Color, Canvas

import "./size_helpers" for SizeHelpers
import "./position" for BrickPosition

var Colors = [
  Color.blue,
  Color.darkblue,
  Color.orange,
  Color.yellow,
  Color.green,
  Color.purple,
  Color.red,
]

// We have a virtual board of size 4x4. We place our tetrominos on this board
// in all of their different conditions. The tetrominos should be kept centered
// as much as possible.
//
// +----------+----------+----------+----------+
// |          |          |          |          |
// |  -2, -2  |  -1, -2  |   0, -2  |   1, -2  |
// |          |          |          |          |
// +----------+----------+----------+----------+
// |          |          |          |          |
// |  -2, -1  |  -1, -1  |   0, -1  |   1, -1  |
// |          |          |          |          |
// +----------+----------+----------+----------+
// |          |          |          |          |
// |   -2, 0  |   -1, 0  |   0, 0   |   1, 0   |
// |          |          |          |          |
// +----------+----------+----------+----------+
// |          |          |          |          |
// |   -2, 1  |   -1, 1  |   0, 1   |   1, 1   |
// |          |          |          |          |
// +----------+----------+----------+----------+
var Tetriminos = [
  // I
  [
    [
      BrickPosition.new(-2, 0),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(0, -2),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
    ],
    [
      BrickPosition.new(-2, 0),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(0, -2),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
    ],
  ],
  // O
  [
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
    ],
  ],
  // T
  [
    [
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
      BrickPosition.new(0, 1),
    ],
    [
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
      BrickPosition.new(-1, 0),
    ],
    [
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
      BrickPosition.new(0, -1),
    ],
    [
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
      BrickPosition.new(1, 0),
    ],
  ],
  // J
  [
    [
      BrickPosition.new(0, -2),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(-1, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(0, -1),
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(-1, 1),
    ],
    [
      BrickPosition.new(-2, -1),
      BrickPosition.new(-1, -1),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
    ],
  ],
  // L
  [
    [
      BrickPosition.new(0, -2),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(-1, 1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(0, -1),
      BrickPosition.new(1, -1),
      BrickPosition.new(1, 0),
      BrickPosition.new(1, 1),
    ],
    [
      BrickPosition.new(-2, 1),
      BrickPosition.new(-1, 1),
      BrickPosition.new(0, 1),
      BrickPosition.new(0, 0),
    ],
  ],
  // S
  [
    [
      BrickPosition.new(1, -1),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(-1, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
    ],
    [
      BrickPosition.new(1, -1),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(-1, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
    ],
  ],
  // Z
  [
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(1, -1),
      BrickPosition.new(1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(0, -1),
      BrickPosition.new(0, 0),
      BrickPosition.new(1, 0),
    ],
    [
      BrickPosition.new(-1, -1),
      BrickPosition.new(-1, 0),
      BrickPosition.new(0, 0),
      BrickPosition.new(0, 1),
    ],
  ],
]

var Random = RandomClass.new()

class Tetrimino {
  construct new() {
    _color = Random.sample(Colors)

    _y = -2
    _x = (SizeHelpers.width / 2).floor

    _shape = Random.sample(Tetriminos)
    _stateIndex = 0
  }

  color { _color }

  rotateRight() {
    _stateIndex = (_stateIndex + 1) % 4
  }
  rotateLeft() {
    _stateIndex = (_stateIndex - 1) % 4
  }
  goUp() {
    _y = _y - 1
  }
  goDown() {
    _y = _y + 1
  }
  goLeft() {
    _x = _x - 1
  }
  goRight() {
    _x = _x + 1
  }

  drawBrick_(pos) {
    pos = pos.toReal
    Canvas.rectfill(pos.x, pos.y, SizeHelpers.brickSize, SizeHelpers.brickSize, _color)
  }

  currentState_ { _shape[_stateIndex] }
  
  position_ { BrickPosition.new(_x, _y) }

  draw() {
    for (brick in currentState_) {
      drawBrick_(brick + position_)
    }
  }

  drawPreview() {
    var previewColor = Color.rgb(_color.r, _color.g, _color.b, 100)
    var initialPos = BrickPosition.new(100, 150)
    for (brick in currentState_) {
      var pos = brick.toPreview + initialPos
      Canvas.rectfill(pos.x, pos.y, SizeHelpers.previewBrickSize, SizeHelpers.previewBrickSize, previewColor)
    }
  }

  bricks { currentState_.map {|brick|
    brick = brick + position_
    brick = BrickPosition.new(brick.x, SizeHelpers.height - brick.y)
    return brick
  } }
}
