//
//  Cubic.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Cubic: Ease {
    
    /**
     Cubic ease in.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeIn(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t = t/d
        return c*t*t*t + b
    }
    
    /**
     Cubic ease out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t = t/d-1
        return c*(t*t*t + 1) + b
    }
    
    /**
     Cubic ease in out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeInOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t = t/(d/2)
        if t < 1 {
            return c/2*t*t*t + b
        }
        
        t = t-2
        return c/2*(t*t*t + 2) + b;
    }
}