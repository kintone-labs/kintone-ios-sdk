//
//  Comment.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/19.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

public class Comment: NSObject, Codable {
    
    private var id: Int?
    private var text: String?
    private var createdAt:Date?
    private var creator: Member?
    private var mentions: [CommentMention]?
    

    /// get the ID of comment
    ///
    /// - Returns: the ID of comment
    public func getId() -> Int? {
        return self.id;
    }
    
    /// set the ID of comment
    ///
    /// - Parameter id: the ID of comment
    public func setId(_ id: Int?) {
        self.id = id;
    }
    
    /// get the comment content including line feed codes
    ///
    /// - Returns: the comment content including line feed codes
    public func getText() -> String? {
        return self.text;
    }

    /// set the comment content including line feed codes
    ///
    /// - Parameter text: the comment content including line feed codes
    public func setText(_ text: String) {
        self.text = text
    }

    /// get the created date and time of the comment
    ///
    /// - Returns: he created date and time of the comment
    public func getCreatedAt() -> Date? {
        return self.createdAt
    }

    /// set he created date and time of the comment
    ///
    /// - Parameter createAt: he created date and time of the comment
    public func setCreatedAt(_ createAt: Date) {
        self.createdAt = createAt
    }

    /// get an Object including infomation of the comment creator
    ///
    /// - Returns: an Object including infomation of the comment creator
    public func getCreator() -> Member? {
        return self.creator
    }

    /// set an Object including infomation of the comment creator
    ///
    /// - Parameter creator: an Object including infomation of the comment creator
    public func setCreator(_ creator: Member) {
        self.creator = creator
    }

    /// get an Array including infomation of the comment creator
    ///
    /// - Returns: an Array cluding infomation of the comment creator
    public func getMentions() -> [CommentMention]? {
        return self.mentions
    }
    
    /// set an Array including infomation of the comment creator
    ///
    /// - Parameter mentions: an Object including infomation of the comment creator
    public func setMentions(_ mentions: [CommentMention]) {
        self.mentions = mentions;
    }

}
