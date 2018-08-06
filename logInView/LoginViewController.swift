//
//  ViewController.swift
//  logInView
//
//  Created by popCorn on 2018/08/05.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let shaperLayer = CAShapeLayer()
    //pulsatingLayer effect for circle view
    
    var n: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = UIColor.white
        let greenView = UIView()
        greenView.backgroundColor = UIColor.green
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        
        //percentage label here
        
        let percentageLabel: UILabel = {
            let label = UILabel()
            label.text = "Start"
            label.textAlignment = .center
            label.textColor = UIColor.black
            return label
        }()
        
        //time circle
        let center = view.center
        //track circle
        let trackCircle = CAShapeLayer()
        let pulsatingCircle = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackCircle.path = circularPath.cgPath
        
        trackCircle.strokeColor = UIColor.lightGray.cgColor
        trackCircle.lineWidth = 10
        trackCircle.fillColor = UIColor.clear.cgColor
        trackCircle.lineCap = kCALineCapRound
        view.layer.addSublayer(trackCircle)
        
        shaperLayer.path = circularPath.cgPath
        shaperLayer.strokeColor = UIColor.green.cgColor
        shaperLayer.lineWidth = 10
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.lineCap = kCALineCapRound
        shaperLayer.strokeEnd = 0
        
        pulsatingCircle.strokeColor = UIColor.clear.cgColor
        pulsatingCircle.fillColor = UIColor.red.cgColor
        pulsatingCircle.lineCap = kCALineCapRound
        view.layer.addSublayer(pulsatingCircle)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingCircle.add(animation, forKey: "pulsing")
        
        
        //add view array to our mainview
        [greenView, blueView, redView].forEach { view.addSubview($0) }
        
        //notes: top equal to view.safearealayoutguide.topanchor
        greenView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 100, height: 0))
        greenView.heightAnchor.constraint(equalTo: greenView.widthAnchor).isActive = true
        
        //notes: top equal to greenview.bottomanchor,
        blueView.anchor(top: greenView.bottomAnchor, leading: nil, trailing: greenView.trailingAnchor, bottom: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        blueView.anchorSize(to: greenView)
        
        //notes: topAnchor equal greenView.top. leftAnchor equal view.safeAreaLayoutGuide. rightAnchor equal to greenView.leading, bottomAnchor equal to blueView.bottomAnchor. -> easy to understand!
        redView.anchor(top: greenView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: greenView.leadingAnchor, bottom: blueView.bottomAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15))
        
        view.layer.addSublayer(shaperLayer)
        blueView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        //add percentage layer
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    //pulsating effect function
    private func animatePulsate() {
        
    }
    //create pulsating circle layer
    func createPulatingCircle() {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    @objc func handleTap() {
        n = n + 1
        print("tap detected \(n)")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 3
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shaperLayer.add(basicAnimation, forKey: "turnMagic")
    }
}
extension UIView {
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    //set auto layout with anchor function
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        //this line below to set autolayout for our view
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            //them dau - de cach mep phia ben trai
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
    
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}

