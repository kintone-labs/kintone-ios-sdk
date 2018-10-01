// Copyright (c) 2018 Cybozu, Inc.

public class AbstractSelectionField: AbstractInputField {
    internal var options: [String: OptionData]
    
    enum AbstractSelectionCodingKeys: CodingKey {
        case options
    }
    
    public override init() {
        self.options = [String: OptionData]()
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbstractSelectionCodingKeys.self)
        self.options = try container.decode([String: OptionData].self, forKey: AbstractSelectionCodingKeys.options)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AbstractSelectionCodingKeys.self)
        if(self.options.count > 0){
            try container.encode(self.options, forKey: AbstractSelectionCodingKeys.options)
        }
        try super.encode(to: encoder)
    }
    
    public func getOptions() -> [String: OptionData] {
        return self.options
    }
    
    public func setOptions(_ options: [String: OptionData]) {
        self.options = options
    }
    
    public func addOption(_ option: OptionData?) -> Bool {
        if (option == nil || option!.getLabel().isEmpty) {
            return false
        }
        self.options[option!.getLabel()] = option
        return true
    }
    
    public func removeOption(_ option: OptionData?) -> Bool {
        if (option == nil || option!.getLabel().isEmpty) {
            return false
        }
        self.options[option!.getLabel()] = nil
        return true
    }
}
