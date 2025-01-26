import SwiftUI

class MockImage: UIImage, @unchecked Sendable {
    func drawRect() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 600, height: 400))
        let img = renderer.image { rendererContext in
            rendererContext.cgContext.setFillColor(UIColor.blue.cgColor)
            rendererContext.cgContext.setStrokeColor(UIColor.blue.cgColor)
            rendererContext.cgContext.setLineWidth(10)

            let rectangle = CGRect(x: 0, y: 0, width: 600, height: 400)
            rendererContext.cgContext.addRect(rectangle)
            rendererContext.cgContext.drawPath(using: .fillStroke)
        }
        return img
    }
}
