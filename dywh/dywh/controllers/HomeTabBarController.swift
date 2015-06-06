//
//  HomeTabBarController.swift
//  dywh
//
//  Created by lotusprize on 15/6/5.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = Array()
    var iconsNormalNames:[String] = ["articleNormal","musicNormal","videoNormal","settingNormal"]
    var iconsSelectNames:[String] = ["articlePressed","musicPressed","videoPressed","settingPressed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containers = createViewContainers()
        
        createCustomIcons(containers)
        
    }
    
    func createCustomIcons(containers : NSDictionary) {
        
        if let items = tabBar.items {
            let itemsCount = tabBar.items!.count as Int - 1
            var index = 0
            for item in self.tabBar.items as! [RAMAnimatedTabBarItem] {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                
                var container : UIView = containers["container\(itemsCount-index)"] as! UIView
                container.tag = index
                
                var icon = UIImageView(image: item.image)
                icon.setTranslatesAutoresizingMaskIntoConstraints(false)
                //icon.tintColor = UIColor.clearColor()
                
                // text
                var textLabel = UILabel()
                textLabel.text = item.title
                //textLabel.backgroundColor = UIColor.clearColor()
                textLabel.textColor = UIColor.whiteColor()
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                container.addSubview(icon)
                createConstraints(icon, container: container, size: item.image!.size, yOffset: -5)
                
                container.addSubview(textLabel)
                let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBar.items!.count) - 5.0
                createConstraints(textLabel, container: container, size: CGSize(width: textLabelWidth , height: 10), yOffset: 16)
                
                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                if 0 == index { // selected first elemet
                    item.selectedState(icon, textLabel: textLabel)
                    icon.image = UIImage(named: iconsSelectNames[0])
                }
                
                item.image = nil
                item.title = ""
                index++
                tabBar.addSubview(container)
            }
        }
    }
    
    func createConstraints(view:UIView, container:UIView, size:CGSize, yOffset:CGFloat) {
        
        var constX = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1,
            constant: 0)
        container.addConstraint(constX)
        
        var constY = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1,
            constant: yOffset)
        container.addConstraint(constY)
        
        var constW = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.width)
        view.addConstraint(constW)
        
        var constH = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.height)
        view.addConstraint(constH)
    }
    
    func createViewContainers() -> NSDictionary {
        
        var containersDict = NSMutableDictionary()
        let itemsCount : Int = tabBar.items!.count as Int - 1
        
        for index in 0...itemsCount {
            var viewContainer = createViewContainer()
            containersDict.setValue(viewContainer, forKey: "container\(index)")
        }
        
        var keys = containersDict.allKeys
        
        var formatString = "H:|-(0)-[container0]"
        for index in 1...itemsCount {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        var  constranints = NSLayoutConstraint.constraintsWithVisualFormat(formatString,
            options:NSLayoutFormatOptions.DirectionRightToLeft,
            metrics: nil,
            views: containersDict as [NSObject : AnyObject])
        view.addConstraints(constranints)
        
        return containersDict
    }
    
    func createViewContainer() -> UIView {
        var viewContainer = UIView();
        viewContainer.backgroundColor = UIColor.clearColor() // for test
        viewContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(viewContainer)
        
        // add gesture
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapHandler:")
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)
        
        // add constrains
        var constY = NSLayoutConstraint(item: viewContainer,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 0)
        
        view.addConstraint(constY)
        
        var constH = NSLayoutConstraint(item: viewContainer,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: tabBar.frame.size.height)
        viewContainer.addConstraint(constH)
        
        return viewContainer
    }
    
    // MARK: actions
    
    func tapHandler(gesture:UIGestureRecognizer) {
        
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        
        let currentIndex = gesture.view!.tag
        if selectedIndex != currentIndex {
            var animationItem : RAMAnimatedTabBarItem = items[currentIndex]
            animationItem.animation = RAMBounceAnimation()
            var icon = iconsView[currentIndex].icon
            
            icon.image = UIImage(named: iconsSelectNames[currentIndex])
            var textLabel = iconsView[currentIndex].textLabel
            animationItem.playAnimation(icon, textLabel: textLabel)
            
            let deselelectIcon = iconsView[selectedIndex].icon
            let deselelectTextLabel = iconsView[selectedIndex].textLabel
            let deselectItem = items[selectedIndex]
            deselelectIcon.image = UIImage(named: iconsNormalNames[selectedIndex])
            //deselectItem.deselectAnimation(deselelectIcon, textLabel: deselelectTextLabel)
            
            selectedIndex = gesture.view!.tag
        }
    }
}
