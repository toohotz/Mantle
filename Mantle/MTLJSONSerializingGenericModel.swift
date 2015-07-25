//
//  MTLJSONSerializingGenericModel.swift
//  Mantle
//
//  Created by Kemar White on 7/14/15.
//  Copyright © 2015 GitHub. All rights reserved.
//

import Foundation

extension MTLJSONSerializing {

	/**
	Deserializes a JSON dictionary object into a generic MTLJSONSerializing model that conforms to the MTLJSONSerializing protocol generic type.

	Example
	```swift
	let deserializedModelFromJSON = myModel.deserializedGenericModelFromJSONDictionary(receivedData as? [NSObject : AnyObject], dictionaryKeyPath: "myKeyPath") as MyModel
	```
	- parameter JSONData          The JSON dictionary to deserialize.
	- parameter dictionaryKeyPath The dictionary keypath to parse for the object model.

	- returns: Returns a MTLJSONSerializing object that can be casted to the final model type for type inference.
	*/
	static func deserializeGenericModelFromJSONDictionary<T: MTLJSONSerializing>(JSONData: [NSObject : AnyObject]?, dictionaryKeyPath: String?) -> T
	{
		var modelData: T?
		do {
			if let dictKeyPath = dictionaryKeyPath {
				modelData = try MTLJSONAdapter.modelOfClass(T.self, fromJSONDictionary: JSONData![dictKeyPath] as! [NSObject : AnyObject]) as? T
			} else {
				modelData = try MTLJSONAdapter.modelOfClass(T.self, fromJSONDictionary: JSONData! as [NSObject : AnyObject]) as? T
			}
		} catch let error as NSError {
			print("An error occured creating a model for the object \(error.localizedDescription)", appendNewline: true)
		}
		return modelData!
	}

	/**
	Deserializes a JSON array of dictionary objects into a generic MTLJSONSerializing model that conforms to the MTLJSONSerializing protocol generic type.

	Example
	``` swift
	let myModel = myModelClass.deserializeGenericModelFromJSONArray(receivedData) as myModelClass
	```

	- parameter JSONData          An array of JSON dictionary objects.

	- returns: A  MTLJSONSerializing object that can be casted to the final model type for type inference.
	*/
	static func deserializeGenericModelFromJSONArray<T: MTLJSONSerializing>(JSONData: AnyObject?) -> T
	{
		return self.deserializeGenericModelFromJSONDictionary(JSONData as? [String : AnyObject], dictionaryKeyPath: nil)
	}
}
