//
//  CPDialRing.swift
//  CPDialRing
//
//  Created by Pai Peng on 2024/4/8.
//

import UIKit

public class CPDialRing: UIView {
    var dialRingView: CPDialRingView?

    public init(frame: CGRect, shutterSpeed: CGFloat) {
        super.init(frame: frame)
        self.initView(shutterSpeed: shutterSpeed)
    }
    // for using in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView(shutterSpeed: 1)
    }
    
    // for using in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView(shutterSpeed: 1)
    }
    
    private func initView(shutterSpeed: CGFloat) {
        let bundle = Bundle(for: CPDialRing.self)
        let image = UIImage(named: "dialring_mask", in: bundle, compatibleWith: nil)!
        
        dialRingView = CPDialRingView(frame: CGRectMake(0, 0, 100, 100))
        dialRingView!.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dialRingView!.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        dialRingView!.backgroundColor = UIColor.yellow
        dialRingView!.setImage(image: image)
        
        
        
        

        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        //stackView.spacing   = 16.0

        stackView.addArrangedSubview(dialRingView!)
        //stackView.addArrangedSubview(textLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)

        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.backgroundColor = .blue
    }
    
    open func setDelegate(delegate: CPDialRingDelegate) {
        self.dialRingView!.delegate = delegate
    }
}
