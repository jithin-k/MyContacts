//
//  Logger.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//


import Foundation

class Logger {
    
    class func log(_ message: Any, file: String = #file, function: String = #function){
        
        print("=================")
        print("File: ", file.components(separatedBy: "/").last ?? "")
        print("Function: ", function)
        print("Message: ", message)
        print("=================")
    }
}
