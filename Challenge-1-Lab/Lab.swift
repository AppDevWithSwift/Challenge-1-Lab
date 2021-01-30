//
//  Lab.swift
//  Challenge-1-Lab
//
//  Created by Kevin McQuown on 1/29/21.
//

import Foundation

struct Lab {
    
    // You will be supplied an array of random numbers and a single target number
    // There are 2 numbers in the array that exactly match the target number
    // Find those 2 numbers and return their product.  In other words, if you find 53 and 175 add to
    // the target number of 228, then return 9275.
    func findTwoNumbers(input: [Int], addsTo: Int) -> Int {
        // ----------Your code goes here---------------
        for i in 0 ..< input.count - 1 {
            for j in i+1 ..< input.count {
                if input[i] + input[j] == addsTo {
                    return input[i] * input[j]
                }
            }
        }
        return 0
        // -------------------------
    }
}
