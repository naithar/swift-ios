extension Dictionary {

	mutating func append(other: Dictionary) {
		for (key,value) in other {
			self.updateValue(value, forKey:key)
		}
	}
}

func + <KeyType, ValueType>(first: Dictionary<KeyType, ValueType>,
		second: Dictionary<KeyType, ValueType>) -> Dictionary<KeyType, ValueType> {
	var result = first
		result.append(second)
		return result
}

func += <KeyType, ValueType> (inout first: Dictionary<KeyType, ValueType>,
		second: Dictionary<KeyType, ValueType>) {
	first.append(second)
}

