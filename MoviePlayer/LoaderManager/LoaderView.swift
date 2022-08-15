//
//  LoaderView.swift
//  BackgroundChanger
//
//  Created by Shreeji on 01/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit


var loaderView = Bundle.main.loadNibNamed("LoaderView", owner: nil, options: nil)![0] as? LoaderView


public class lodermaster {
    
    public class func start(withProgress progress:String? = nil) {
        
        DispatchQueue.main.async(execute: {
           
            if let view = MYdevice.rootView?.view {
                loaderView?.load(inView: view, sms: progress)
            }
        })
    }
    
    public class func updateProgress(progress:String) {
        
        DispatchQueue.main.async(execute: {
            
            loaderView?.upadte(sms: progress)
        })
    }
    
    public class func stop() {
        
        DispatchQueue.main.async(execute: {
            loaderView?.unLoad()
        })
    }
}


class LoaderView: UIView {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var stringindicatorView: UIView!
    @IBOutlet weak var stringindicator: UIActivityIndicatorView!
    @IBOutlet weak var stringLable: UILabel!
    
    
    func load(inView:UIView, sms:String? = nil) {
        
        self.frame = inView.bounds
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        self.stringindicatorView.isHidden = true
        self.indicatorView.isHidden = true
        
        // without string
        if(sms == nil) {
            
            self.setIndicatorBackground(self.indicatorView)
            indicatorView.isHidden = false
            self.indicator.startAnimating()
            
            // with string
        } else {
            
            self.stringLable.text = sms
            self.setIndicatorBackground(self.stringindicatorView)
            self.stringindicator.startAnimating()
        }
        
        inView.addSubview(self)
    }
    
    
    
    func setIndicatorBackground(_ indiback:UIView)  {
        
        indiback.isHidden = false
        indiback.backgroundColor = UIColor.black.withAlphaComponent(0.90)
        indiback.layer.cornerRadius = 5
        indiback.layer.shadowOffset = CGSize(width: 0, height: 0)
        indiback.layer.shadowColor = UIColor.black.cgColor
        indiback.layer.shadowRadius = 5
        indiback.layer.shadowOpacity = 0.1
    }
    
    
    
    func upadte(sms:String) {
        
        self.stringLable.text = sms
    }
    
    
    func unLoad() {
        self.indicator.stopAnimating()
        self.stringindicator.stopAnimating()
        self.removeFromSuperview()
    }
    
}
