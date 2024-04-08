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
    var focusRing: CGFloat = 0
    var rotate: CGFloat = 0
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
        focusRing = currentPoint.x - lastPoint.x
        //drawLine(from: lastPoint, to: currentPoint)

        if (focusRing != 0) {
            // 7
            lastPoint = currentPoint
            rotate += focusRing
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
        
        var rotateImage = self.image?.imageRotated(radians: rotate/M_PI)
        
        rotateImage!.draw(in: ringRect)
        
        if (self.delegate != nil) {
            self.delegate?.speed(shutterSpeed: rotate)
        }
    }
    
    func setDelegate(delegate: CPDialRingDelegate) {
        self.delegate = delegate
    }
}


