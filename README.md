# Project 2 - *Yelp*

**Yelp** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **16.5** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Search results page
   - [X] Table rows should be dynamic height according to the content height.
   - [X] Custom cells should have the proper Auto Layout constraints.
   - [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states.
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [X] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [ ] Implement map view of restaurant results.
- [ ] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [ ] Distance filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [ ] Implement the restaurant detail page.

The following **additional** features are implemented:

- [X] Save the state of the filters that were previously selected.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Better ways to save the state of the filters
2. Optimized way of handling dynamic table cell actions

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/0JgISDP.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I'm curious about the best way to handle keeing track of the saved filters. The info bubbles up to the BusinessCellVC but the best way I could think to keep the data was to pass it back to the filtersVC. 

Handling the actions of the different cells in each section was tricky. The way I handled it was very sloppy and I didn't leave myself with enough time to optimize it but I know it can be done. 

I'm curious about how to get the filtersVC to look exactly like the mock gif. is that a 3rd party library for custom formatting tableviewCells?


### Basic Yelp client

This is a headless example of how to implement an OAuth 1.0a Yelp API client. The Yelp API provides an application token that allows applications to make unauthenticated requests to their search API.

### Next steps

- Check out `BusinessesViewController.swift` to see how to use the `Business` model.

### Sample request

**Basic search with query**

```
Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
    self.businesses = businesses
    
    for business in businesses {
        print(business.name!)
        print(business.address!)
    }
})
```

**Advanced search with categories, sort, and deal filters**

```
Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in

    for business in businesses {
        print(business.name!)
        print(business.address!)
    }
}
```

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
