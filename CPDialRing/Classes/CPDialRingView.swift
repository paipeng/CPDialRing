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
    var hide = true
    var image: UIImage?
    var dialRing: CGFloat = 0
    var rotate: CGFloat = 0
    var dialRingView: UIImageView?
    
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
        
        // Double Tap
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CPDialRingView.handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)

        doubleTap.delaysTouchesBegan = true
        
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
    
    @objc func handleDoubleTap() {
        print("Double Tap!")
        hide = !hide
        setNeedsDisplay()
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
        //hide = false
        lastPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
        guard let touch = touches.first else {
            return
        }

        // 6
        //hide = true
        let currentPoint = touch.location(in: self)
        dialRing = sqrt( (currentPoint.x - lastPoint.x) * (currentPoint.x - lastPoint.x) + (currentPoint.y - lastPoint.y) * (currentPoint.y - lastPoint.y))
        //drawLine(from: lastPoint, to: currentPoint)
        dialRing = dialRing / 1.5
        if ((currentPoint.x - lastPoint.x) < 0) {
            dialRing = -dialRing
        } else if ((currentPoint.y - lastPoint.y) >= 0) {
            dialRing = -dialRing
        }
        if (dialRing != 0) {
            // 7
            lastPoint = currentPoint
            rotate += dialRing
            setNeedsDisplay()
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        if !hide {
        // draw a single point
        //drawLine(from: lastPoint, to: lastPoint)
        }
        guard let touch = touches.first else {
            return
        }
        let currentPoint = touch.location(in: self)
        lastPoint = currentPoint
        //hide = true
        //setNeedsDisplay()
        
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

        if (hide) {
            ringRect.origin.x = 50//ringRect.size.width - (self.image?.size.width)!
        }
        let step = Double.pi/9
        var r = rotate/Double.pi - (rotate/Double.pi).truncatingRemainder(dividingBy: step)
        var s = r/(Double.pi/9)
        
        print("speed: \(s)")
        if (s > 3) {
            s = 3
        } else if (s < -11) {
            s = -11
        }
        r = s * (Double.pi/9)
        rotate = r * Double.pi
        
        let rotateImage = self.image?.imageRotated(radians: r)
        
        rotateImage!.draw(in: ringRect)
        
        if (self.delegate != nil) {
            self.delegate?.speed(shutterSpeed: rotate)
        }
    }
    
    func setDelegate(delegate: CPDialRingDelegate) {
        self.delegate = delegate
    }
}


