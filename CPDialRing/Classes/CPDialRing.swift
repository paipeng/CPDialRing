//
//  CPDialRing.swift
//  CPDialRing
//
//  Created by Pai Peng on 2024/4/8.
//

import UIKit

public class CPDialRing: UIView {
    var dialRingView: CPDialRingView?
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
        let bundle = Bundle(for: CPDialRing.self)
        let image = UIImage(named: "dialring_mask", in: bundle, compatibleWith: nil)!
        
        dialRingView = CPDialRingView(frame: CGRectMake(0, 0, 100, 100))
        dialRingView!.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dialRingView!.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        dialRingView!.backgroundColor = UIColor.yellow
        dialRingView!.setImage(image: image)
        
        
        
        //Text Label
        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.yellow
        textLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textLabel.text  = "Hi World"
        textLabel.textAlignment = .center

        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        stackView.addArrangedSubview(dialRingView!)
        stackView.addArrangedSubview(textLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)

        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.backgroundColor = .blue
    }
}
