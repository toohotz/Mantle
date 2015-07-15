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
	let deserializedModelFromJSON = MyModel.deserializedGenericModelFromJSONDictionary(receivedData as? [NSObject : AnyObject], dictionaryKeyPath: "myKeyPath") as MyModel
	```
	- parameter JSONData          The JSON dictionary to deserialize.
	- parameter dictionaryKeyPath The dictionary keypath to parse for the object model.

	- returns: Returns an optional MTLJSONSerializing object that can be casted to the final model type for type inference.
	*/
	static func deserializeGenericModelFromJSONDictionary<T: MTLJSONSerializing>(JSONData: [NSObject : AnyObject]?, dictionaryKeyPath: String!) -> T?
	{
		var modelData: T?
		do {
			modelData = try MTLJSONAdapter.modelOfClass(T.self, fromJSONDictionary: JSONData![dictionaryKeyPath] as! [NSObject : AnyObject]) as? T
		} catch let error as NSError {
			print("An error occured creating a model for the object \(error.localizedDescription)", appendNewline: true)
		}
		catch
		{

		}
		return modelData
	}
}
