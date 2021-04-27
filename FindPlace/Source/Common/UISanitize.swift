//
//  UISanitize.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 27.04.2021.
//

import Foundation

func UISanitize(_ sanitationBlock: @escaping ()->()) {
    Thread.isMainThread ? sanitationBlock() : DispatchQueue.main.async {
        sanitationBlock()
    }
}
