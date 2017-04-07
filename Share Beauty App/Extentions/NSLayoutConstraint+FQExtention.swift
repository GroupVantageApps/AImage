//
//  NSLayoutConstraint+FQExtention.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/05.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    class func findEqualRelation(_ constraints: [NSLayoutConstraint], item: AnyObject, toItem: AnyObject?, firstattribute: NSLayoutAttribute, secondattribute: NSLayoutAttribute, constant: CGFloat? = nil) -> NSLayoutConstraint? {
        for constraint in constraints {
            if constraint.firstItem === item &&
                constraint.secondItem === toItem &&
                constraint.relation == .equal &&
                constraint.firstAttribute == firstattribute &&
                constraint.secondAttribute == secondattribute {
                    if constant == nil {
                        return constraint
                    } else {
                        if constant == constraint.constant {
                            return constraint
                        }
                    }
            }
        }
        return nil
    }

    class func findEqualRelation(_ constraints: [NSLayoutConstraint], constraint: NSLayoutConstraint) -> NSLayoutConstraint? {
        return self.findEqualRelation(constraints, item: constraint.firstItem, toItem: constraint.secondItem, firstattribute: constraint.firstAttribute, secondattribute: constraint.secondAttribute, constant: constraint.constant)
    }

    class func findEqualLeft(_ constraints: [NSLayoutConstraint], item: AnyObject, toItem: AnyObject?) -> NSLayoutConstraint? {
        return findEqualRelation(constraints, item: item, toItem: toItem, firstattribute: .left, secondattribute: .left, constant: nil)
    }
    class func findEqualRight(_ constraints: [NSLayoutConstraint], item: AnyObject, toItem: AnyObject?) -> NSLayoutConstraint? {
        return findEqualRelation(constraints, item: item, toItem: toItem, firstattribute: .right, secondattribute: .right)
    }
    class func findEqualTop(_ constraints: [NSLayoutConstraint], item: AnyObject, toItem: AnyObject?) -> NSLayoutConstraint? {
        return findEqualRelation(constraints, item: item, toItem: toItem, firstattribute: .top, secondattribute: .top)
    }
    class func findEqualBottom(_ constraints: [NSLayoutConstraint], item: AnyObject, toItem: AnyObject?) -> NSLayoutConstraint? {
        return findEqualRelation(constraints, item: item, toItem: toItem, firstattribute: .bottom, secondattribute: .bottom)
    }

    class func findWidth(_ constraints: [NSLayoutConstraint], item: AnyObject, constant: CGFloat? = nil) -> NSLayoutConstraint? {
        return findEqualRelation(constraints, item: item, toItem: nil, firstattribute: .width, secondattribute: .notAnAttribute, constant: constant)
    }

    class func findHeight(_ constraints: [NSLayoutConstraint], item: AnyObject, constant: CGFloat? = nil) -> NSLayoutConstraint? {
        return findEqualRelation(constraints, item: item, toItem: nil, firstattribute: .height, secondattribute: .notAnAttribute, constant: constant)
    }
}

public extension NSLayoutConstraint {
    class func makeEqualEdgeConstraintWithSpace(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute, space: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: attribute, multiplier: 1.0, constant: space)
    }
    class func makeEqualEdgeConstraint(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute, space: CGFloat) -> NSLayoutConstraint {
        return makeEqualEdgeConstraintWithSpace(item: item, toItem: toItem, attribute: attribute, space: space)
    }
    class func equalLeftEdge(item: AnyObject, toItem: AnyObject, space: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqualEdgeConstraint(item: item, toItem: toItem, attribute: .left, space: space)
    }
    class func equalRightEdge(item: AnyObject, toItem: AnyObject, space: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqualEdgeConstraint(item: item, toItem: toItem, attribute: .right, space: space)
    }
    class func equalTopEdge(item: AnyObject, toItem: AnyObject, space: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqualEdgeConstraint(item: item, toItem: toItem, attribute: .top, space: space)
    }
    class func equalBottomEdge(item: AnyObject, toItem: AnyObject, space: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqualEdgeConstraint(item: item, toItem: toItem, attribute: .bottom, space: space)
    }
}

public extension NSLayoutConstraint {
    class func makeConnectEdgeConstraintWithSpace(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute, space: CGFloat) -> NSLayoutConstraint {
        var toAttribute: NSLayoutAttribute!
        switch attribute {
        case .top:
            toAttribute = .bottom
        case .bottom:
            toAttribute = .top
        case .left:
            toAttribute = .right
        case .right:
            toAttribute = .left
        default: break
        }
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: 1.0, constant: space)
    }
    class func makeConnectEdgeConstraint(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return makeConnectEdgeConstraintWithSpace(item: item, toItem: toItem, attribute: attribute, space: 0)
    }
    class func connectLeftRightEdge(item: AnyObject, toItem: AnyObject, space: CGFloat) -> NSLayoutConstraint {
        return makeConnectEdgeConstraintWithSpace(item: item, toItem: toItem, attribute: .left, space: space)
    }
    class func connectTopBottomEdge(item: AnyObject, toItem: AnyObject, space: CGFloat) -> NSLayoutConstraint {
        return makeConnectEdgeConstraintWithSpace(item: item, toItem: toItem, attribute: .top, space: space)
    }
}

public extension NSLayoutConstraint {
    class func makeEqualSizeConstraintWithScale(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: attribute, multiplier: multiplier, constant: 0)
    }
    class func makeSize(item: AnyObject, attribute: NSLayoutAttribute, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
    }
    class func makeEqualSizeConstraint(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return makeEqualSizeConstraintWithScale(item: item, toItem: toItem, attribute: attribute, multiplier: 1.0)
    }
    class func equalWidth(item: AnyObject, toItem: AnyObject) -> NSLayoutConstraint {
        return makeEqualSizeConstraint(item: item, toItem: toItem, attribute: .width)
    }
    class func equalWidth(item: AnyObject, toItem: AnyObject, multiplier: CGFloat) -> NSLayoutConstraint {
        return makeEqualSizeConstraintWithScale(item: item, toItem: toItem, attribute: .width, multiplier: multiplier)
    }
    class func equalHeight(item: AnyObject, toItem: AnyObject) -> NSLayoutConstraint {
        return makeEqualSizeConstraint(item: item, toItem: toItem, attribute: .height)
    }
    class func makeWidth(item: AnyObject, constant: CGFloat) -> NSLayoutConstraint {
        return makeSize(item: item, attribute: .width, constant: constant)
    }
    class func makeHeight(item: AnyObject, constant: CGFloat) -> NSLayoutConstraint {
        return makeSize(item: item, attribute: .height, constant: constant)
    }
}
