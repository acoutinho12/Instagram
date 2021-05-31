//
//  UIView.swift
//  Instagram
//
//  Created by Andre Luis Barbosa Coutinho on 30/05/21.
//

import UIKit

extension UIView {
    public var width: CGFloat{
        return frame.size.width;
    }
    public var height: CGFloat{
        return frame.size.height;
    }
    public var top: CGFloat{
        return frame.origin.y;
    }
    public var bottom: CGFloat{
        return frame.origin.y + frame.size.height;
    }
    public var left: CGFloat{
        return frame.origin.x;
    }
    public var right: CGFloat{
        return frame.size.width + frame.origin.x;
    }
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false;
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true;
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true;
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true;
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true;
    }
}
