public extension SequenceType {

	typealias Value = Generator.Element

		func group<U : Hashable>(@noescape closure: Value -> U) -> [U : [Value]] {
			var result: [U: [Value]] = [:]
				for element in self {
					let key = closure(element)

						if result[key]?.append(element) == nil {
							result[key] = [element]
						}
				}
			return result
		}
}
