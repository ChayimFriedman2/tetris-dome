import "graphics" for Canvas

import "./size_helpers" for SizeHelpers
import "./position" for BrickPosition

class Lines {
  construct new() {
    _lines = []
    _clearedCount = 0
  }

  setAt(pos, color) {
    if (pos.y >= _lines.count) {
      var missingLinesCount = pos.y - _lines.count + 1
      for (i in 0...missingLinesCount) {
        _lines.add(List.filled(SizeHelpers.width, null))
      }
    }

    _lines[pos.y][pos.x] = color
    if (_lines[pos.y].all {|brick| brick != null }) {
      _lines.removeAt(pos.y)
      _clearedCount = _clearedCount + 1
    }
  }

  [pos] { 0 <= pos.y && pos.y < _lines.count &&
    0 <= pos.x && pos.x < SizeHelpers.width &&
    _lines[pos.y][pos.x] != null }
  
  drawBrick_(x, y, color) {
    var pos = BrickPosition.new(x, SizeHelpers.height - y).toReal
    Canvas.rectfill(pos.x, pos.y, SizeHelpers.brickSize, SizeHelpers.brickSize, color)
  }

  draw() {
    var y = 0
    var x = 0
    for (line in _lines) {
      for (brick in line) {
        if (brick) {
          drawBrick_(x, y, brick)
        }

        x = x + 1
      }

      x = 0
      y = y + 1
    }
  }

  gameOver { _lines.count >= SizeHelpers.height }

  clearedCount { _clearedCount }
}
