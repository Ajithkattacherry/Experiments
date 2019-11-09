//
//  FLConstants.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//


struct Service {
    static let host = "https://www.flickr.com/"
    static let module = "services/rest/?method=flickr.photos.search&api_key="
    static let text = "&text="
    static let format = "&format=json&nojsoncallback=1&page="
    static let flickrKey = "0fe1aaa149e2cd9cfae6d59c927e453f"
}

struct Errors {
    static let invalidAccessErrorCode = 100
    static let invalidAPIKey = "Invalid API Key"
    static let invalidAPIKeyTitle = "Search Error"
    static let emptySearchString = "Search text is empty"
}

struct Constants {
    static let appName = "Flicks"
    static let emptyString = ""
    static let placeholderImage = "placeholder"
    static let searchBarPlaceholderText = "Search images"
    static let photoDetailsSegue = "PhotoDetailsSegue"
    static let alertDismissTitle = "Dismiss"
    static let alertTitle = "Alert"
    static let searchResultCellIdentifier = "FLSearchResultCell"
}
