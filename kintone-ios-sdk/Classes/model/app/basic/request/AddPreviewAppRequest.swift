//
//  AddPreviewAppRequest.swift
//  kintone-ios-sdk
//
//  Created by Trinh Hung Anh on 9/18/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

class AddPreviewAppRequest: NSObject {
    private var name: String?
    private var space: Int?
    private var thread: Int?
    
    public func getName() -> String? {
        return self.name
    }
    public func setName(name: String) {
        self.name = name
    }
    public func getSpace() -> Int? {
        return self.space
    }
    public func setSpace(space: Int) {
        self.space = space
    }
    public func getThread() -> Int? {
        return self.thread
    }
    public func setThread(thread: Int) {
        self.thread = thread
    }
}
