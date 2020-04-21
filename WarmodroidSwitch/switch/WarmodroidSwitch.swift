//
//  WarmodroidSwitch.swift
//  WarmodroidSwitch
//
//  Created by Mohit Agrawal on 20/04/20.
//  Copyright © 2020 Mohit Agrawal. All rights reserved.
//

import UIKit

/**
 This is main callback function where you can logic for what to be done when switch in ON/OFF
 */
protocol WarmodroidSwitchDelegate {
    func didTapSwitch(isON: Bool)
}

@IBDesignable
class WarmodroidSwitch: UIView {
    
    private var containerView: UIView!
    private var elipticalView: UIView!
    private var thumb: UIView!
    private var thumbTrailingConstraint: NSLayoutConstraint!
    var delegate: WarmodroidSwitchDelegate?
    var isOn = false
    var onThumbColor = UIColor.green
    var offThumbColor = UIColor.darkGray
    var onBackgroundColor = UIColor.gray
    var offBackgroungColor = UIColor.gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        self.commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    private func commonInit() {
        let padding = frame.size.height*0.15
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        elipticalView = UIView()
        //elipticalView.backgroundColor = UIColor.gray
        elipticalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(elipticalView)
        elipticalView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        elipticalView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        elipticalView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        elipticalView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        elipticalView.layer.cornerRadius = (frame.size.height - padding*2)/2
        
        thumb = UIView()
        //thumb.backgroundColor = UIColor.green
        thumb.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumb)
        thumbTrailingConstraint = thumb.trailingAnchor.constraint(equalTo: trailingAnchor)
        thumbTrailingConstraint.isActive = true
        setState()
        thumb.heightAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        thumb.widthAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        thumb.layer.cornerRadius = frame.size.height/2
        let thumbTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnThumb))
        thumb.addGestureRecognizer(thumbTapGesture)
    }
    
    @objc private func didTapOnThumb() {
        isOn = isOn ? false : true
        setState()
        delegate?.didTapSwitch(isON: isOn)
    }
    
    /**
     It gives nice animation to thumb when switched ON or OFF.
     Changes the color.
     */
    private func setState() {
        if isOn {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.thumbTrailingConstraint.constant = 0
                self.layoutIfNeeded()
            }, completion: nil)
            elipticalView.backgroundColor = onBackgroundColor
            thumb.backgroundColor = onThumbColor
        } else {
            UIView.animate(withDuration: 0.2,delay: 0.0, options: .curveEaseInOut, animations: {
                self.thumbTrailingConstraint.constant = -self.frame.size.width/2
                self.layoutIfNeeded()
            }, completion: nil)
            elipticalView.backgroundColor = offBackgroungColor
            thumb.backgroundColor = offThumbColor
        }
    }
}
