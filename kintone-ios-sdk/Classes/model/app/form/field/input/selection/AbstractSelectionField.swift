//
//  AbstractSelectionField.swift
//  kintone-ios-sdk
//
//  Created by Pham Anh Quoc Phien on 9/19/18.
//  Copyright © 2018 Cybozu. All rights reserved.
//

public class AbstractSelectionField: AbstractInputField {
    internal var options: [String: OptionData]
    
    public override init() {
        self.options = [String: OptionData]()
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
         self.options = [String: OptionData]()
         super.init()
    }
    /**
     * @return the options
     */
    public func getOptions() -> [String: OptionData] {
        return self.options
    }
    
    /**
     * @param options
     *            the options to set
     */
    public func setOptions(_ options: [String: OptionData]) {
        self.options = options
    }
    
    /**
     * @param option
     */
    public func addOption(_ option: OptionData?) -> Bool {
        if (option == nil || option!.getLabel().isEmpty) {
            return false
        }
        self.options[option!.getLabel()] = option
        return true
    }
    
    /**
     * @param option
     */
    public func removeOption(_ option: OptionData?) -> Bool {
        if (option == nil || option!.getLabel().isEmpty) {
            return false
        }
        self.options[option!.getLabel()] = nil
        return true
    }
}
