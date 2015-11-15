//: Playground - noun: a place where people can play

// Obtained from:
//
// http://stackoverflow.com/questions/27327067/append-text-or-data-to-text-file-in-swift
//
// Minor modifications made by R. Gordon on 15-11-15.

import Cocoa

extension String {
    func appendLineToURL(fileURL: NSURL) throws {
        try self.stringByAppendingString("\n").appendToURL(fileURL)
    }
    
    func appendToURL(fileURL: NSURL) throws {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        try data.appendToURL(fileURL)
    }
}

extension NSData {
    func appendToURL(fileURL: NSURL) throws {
        if let fileHandle = try? NSFileHandle(forWritingToURL: fileURL) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.writeData(self)
        }
        else {
            try writeToURL(fileURL, options: .DataWritingAtomic)
        }
    }
}

// Get path to the Documents folder
let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString

// Append folder name of Shared Playground Data folder
let sharedDataPath = documentPath.stringByAppendingPathComponent("Shared Playground Data")

// Append file name to folder path string
let filePath = sharedDataPath + "/output.txt"

// Test
do {
    let url = NSURL(fileURLWithPath: filePath)
    try "Test \(NSDate())".appendLineToURL(url)
    let result = try String(contentsOfURL: url)
}
catch {
    print("Could not write to file")
}

// Test writing an "1" to file
do {
    let url = NSURL(fileURLWithPath: filePath)
    try "1".appendToURL(url)
    let result = try String(contentsOfURL: url)
}
catch {
    print("Could not write to file")
}

// Test writing a "2" to file
do {
    let url = NSURL(fileURLWithPath: filePath)
    try "2".appendToURL(url)
    let result = try String(contentsOfURL: url)
}
catch {
    print("Could not write to file")
}

// Test writing a "3 and new line" to file
do {
    let url = NSURL(fileURLWithPath: filePath)
    try "3".appendLineToURL(url)
    let result = try String(contentsOfURL: url)
}
catch {
    print("Could not write to file")
}