import "./size_helpers" for SizeHelpers

class BrickPosition {
  construct new(x, y) {
    _x = x
    _y = y
  }

  x { _x }
  y { _y }

  +(other) { BrickPosition.new(x + other.x, y + other.y) }

  toReal { BrickPosition.new(
    (x * SizeHelpers.brickSize) + SizeHelpers.horizontalPadding,
    (y * SizeHelpers.brickSize) - SizeHelpers.verticalPadding
  ) }

  toPreview { BrickPosition.new(
    x * SizeHelpers.previewBrickSize,
    y * SizeHelpers.previewBrickSize
  ) }

  // For debugging purposes
  toString { "BrickPosition(x = %(_x), y = %(_y))" }
}
