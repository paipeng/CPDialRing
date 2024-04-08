//
//  CPDialRingView.swift
//  CPDialRing
//
//  Created by Pai Peng on 2024/4/8.
//

import UIKit

class CPDialRingView: UIView {
    weak var delegate: CPDialRingDelegate? = nil
    
    var lastPoint = CGPoint.zero
    var swiped = false
    var image: UIImage?
    var focusRing: CGFloat = 0
    var focus: CGFloat = 0
    var focusRingView: UIImageView?
    
    // for using in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    // for using in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    private func initView() {
        print("initView: \(self.frame)")
        //imageView.backgroundColor = UIColor.yellow
        /*
        let bundle = Bundle(for: CPDialRingView.self)
        let image = UIImage(named: "FocusRing", in: bundle, compatibleWith: nil)!
        
        focusRingView = UIImageView(image: image)
        focusRingView!.frame = self.frame;
        //imageView.image = image
        //imageView.contentMode = .scaleToFill
        //focusRingView!.backgroundColor = .cyan
        self.addSubview(focusRingView!)
         */
    }
    
    public func setImage(image: UIImage) {
        print("setImage: \(image.size.width)-\(image.size.height)")
        self.image = image
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesMoved")
        guard let touch = touches.first else {
            return
        }

        // 6
        swiped = true
        let currentPoint = touch.location(in: self)
        focusRing = currentPoint.x - lastPoint.x
        //drawLine(from: lastPoint, to: currentPoint)

        if (focusRing != 0) {
            // 7
            lastPoint = currentPoint
            focus += focusRing
            setNeedsDisplay()
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        if !swiped {
        // draw a single point
        //drawLine(from: lastPoint, to: lastPoint)
        }
        guard let touch = touches.first else {
            return
        }
        let currentPoint = touch.location(in: self)
        lastPoint = currentPoint
        
      /*
      // Merge tempImageView into mainImageView
      UIGraphicsBeginImageContext(mainImageView.frame.size)
      mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
      tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
      mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
        
      tempImageView.image = nil
       */
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var ringRect: CGRect = rect
        //print("function draw is called: \(focus) \(ringRect.size.height * self.image!.size.width / self.image!.size.height)")

        // Drawing code
        ringRect.size.width = ringRect.size.height * self.image!.size.width / self.image!.size.height

        if (focus > 0) {
            focus = 0
        } else if (focus < -(ringRect.size.width-self.frame.width)) {
            focus = -(ringRect.size.width-self.frame.width)
        }
        ringRect.origin.x = focus
        
        self.image!.draw(in: ringRect)
        

        if (self.delegate != nil) {
            self.delegate?.speed(shutterSpeed: focus)
        }
    }
    
    func setDelegate(delegate: CPDialRingDelegate) {
        self.delegate = delegate
    }
}


