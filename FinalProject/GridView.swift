import UIKit

public protocol GridViewDataSource {
    var size: Int { get }
    subscript (row: Int, col: Int) -> CellState { get set }
}

@IBDesignable class GridView: UIView {
    
    @IBInspectable var fillColor = UIColor.lightGray
    @IBInspectable var emptyFillColor = UIColor.white
    @IBInspectable var aliveFillColor = UIColor.green
    @IBInspectable var bornFillColor = UIColor.blue
    @IBInspectable var diedFillColor = UIColor.red
    @IBInspectable var strokeColor = UIColor.darkGray
    @IBInspectable var gridSize: Int = 10
    @IBInspectable var inset = CGFloat(2.0)
    @IBInspectable var lineWidth = CGFloat(2.0)
    
    var gridDataSource: GridViewDataSource?
    
    override func draw(_ rect: CGRect) {
        gridSize = gridDataSource?.size ?? 3
        let rect = CGRect(
            x: rect.origin.x + (lineWidth/2.0),
            y: rect.origin.y + (lineWidth/2.0),
            width: rect.size.width - lineWidth,
            height: rect.size.height - lineWidth
        )
        // Drawing code
        let cellSize = CGSize(
            width: rect.size.width / CGFloat(gridSize),
            height: rect.size.height / CGFloat(gridSize)
        )
        (0 ..< gridSize).forEach { row in
            (0 ..< gridSize).forEach { col in
                let subRect = CGRect(
                    x: rect.origin.x + (CGFloat(col) * cellSize.width) + inset + (lineWidth / 2.0),
                    y: rect.origin.y + (CGFloat(row) * cellSize.height) + inset + (lineWidth / 2.0),
                    width: cellSize.width - ((2.0 * inset) + (lineWidth)),
                    height: cellSize.height - ((2.0 * inset) + (lineWidth))
                )
                let path = UIBezierPath(ovalIn: subRect)
                var color = emptyFillColor
                switch gridDataSource?[col, row] ?? .empty {
                case .alive: color = aliveFillColor
                case .died: color = diedFillColor
                case .born: color = bornFillColor
                case .empty: color = emptyFillColor
                }
                color.setFill()
                path.fill()
            }
        }
        (0 ... gridSize).forEach { col in
            let fromPoint = CGPoint(
                x: CGFloat(rect.origin.x + (CGFloat(col) * cellSize.width)),
                y: CGFloat(rect.origin.y)
            )
            let toPoint = CGPoint(
                x: CGFloat(rect.origin.x + (CGFloat(col) * cellSize.width)),
                y: CGFloat(rect.origin.y + rect.size.height)
            )
            let verticalPath = UIBezierPath()
            verticalPath.lineWidth = lineWidth
            verticalPath.move(to: fromPoint)
            verticalPath.addLine(to: toPoint)
            strokeColor.setStroke()
            verticalPath.stroke()
        }
        (0 ... gridSize).forEach { row in
            let fromPoint = CGPoint(
                x: CGFloat(rect.origin.x),
                y: CGFloat(rect.origin.y + (CGFloat(row) * cellSize.height))
            )
            let toPoint = CGPoint(
                x: CGFloat(rect.origin.x + rect.size.width),
                y: CGFloat(rect.origin.y + (CGFloat(row) * cellSize.height))
            )
            let horizontalPath = UIBezierPath()
            horizontalPath.lineWidth = lineWidth
            horizontalPath.move(to: fromPoint)
            horizontalPath.addLine(to: toPoint)
            strokeColor.setStroke()
            horizontalPath.stroke()
        }
    }
    
    var lastTouchedPosition: Position? = nil
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1 else { return }
        let touch = touches.first!
        let pos = convert(touch: touch)
        if let state = gridDataSource?[pos.col, pos.row] {
            gridDataSource![pos.col, pos.row] = state.isAlive ? .empty : .alive
            lastTouchedPosition = pos
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1 else { return }
        guard touches.count == 1 else { return }
        let touch = touches.first!
        let pos = convert(touch: touch)
        guard pos.row != lastTouchedPosition?.row || pos.col != lastTouchedPosition?.col else { return }
        if let state = gridDataSource?[pos.col, pos.row] {
            gridDataSource![pos.col, pos.row] = state.isAlive ? .empty : .alive
            lastTouchedPosition = pos
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1 else { return }
        lastTouchedPosition = nil
    }
    
    func convert(touch: UITouch) -> Position {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(gridSize)
        
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(gridSize)
        
        return Position(row: Int(row), col: Int(col))
    }
}
