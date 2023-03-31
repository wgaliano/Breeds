<div align="center">
  <h1>Breeds</h1>
  <br />
	
</div>
  <br />

<details open="open">
<summary>Table of Contents</summary>

- [About](#about)
- [Combine](#combine)
  - [Network](#network)
  - [RandomDogViewModel](#random-dog-view-model)
  - [FindBreedViewModel](#find-breed-view-model)
  - [DogDetailViewModel]
- [Authors & contributors](#authors--contributors)

</details>

---
<br />

## About

This project is a simple SwiftUI app that demonstrates how to use Combine to retrieve images of dogs from "TheDogAPI.com". The app fetches a list of dog breeds from the API and displays them in a scrollable list. When a breed is selected, the app retrieves a random image of a dog of that breed and displays it in a SwiftUI Image view.

The app is built using the MVVM (Model-View-ViewModel) architecture pattern, with the ViewModel using Combine to handle the network requests and data processing. The code is written entirely in Swift, and uses Swift Package Manager to manage dependencies.

This project is a great starting point for anyone looking to learn Combine in SwiftUI, or for those looking to build a simple app that uses network requests to fetch data from an API.

## Combine
Combine is a powerful framework provided by Apple that allows you to work with asynchronous programming and event handling in a more concise and readable way. It is designed to help you write reactive code, which is especially useful when working with API requests.
If you are working on an app that requires frequent API requests or complex data flows, using Combine can help you write more efficient, expressive, and maintainable code.

## Network
```Swift
import Foundation
import Combine

class Network: NSObject {
    
    /// Create a single instance on Network class
    static let shared = Network()
    
    /// Create a urlSession object, use this to perform requests
    let session: URLSession = URLSession(configuration: .default)
    
    /// URLComponents, use this to create and manipulate endpoints
    var urlComponent = URLComponents(string: "https://api.thedogapi.com/v1")
    
    /// Decoder for JSON `Data`.
    lazy var decoder = JSONDecoder()
    
    /// Encoder for JSON `Data`.
    lazy var encoder = JSONEncoder()
    
    func fetchRandomDog(path: String) -> AnyPublisher<[DogElement], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "limit",
                    value: "\(10)"
                )
            ]
        )
        return perform(request: request, decoder: decodeDogs(from:))
    }
    
    func fetchBreeds(path: String) -> AnyPublisher<[Breed], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "limit",
                    value: "\(180)"
                )
            ]
        )
        return perform(request: request, decoder: decodeBreeds(from:))
    }
    
    func fetchDogsPerBreed(path: String, breedId: Int) -> AnyPublisher<[DogElement], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "breed_ids",
                    value: "\(breedId)"
                )
            ]
        )
        return perform(request: request, decoder: decodeDogs(from:))
    }
    
    func fetchBreedByText(path: String, breedName: String) -> AnyPublisher<[SearchedBreedElement], NetworkError> {
        let request = buildRequest(
            method: "GET",
            path: path,
            queryItems: [
                URLQueryItem(
                    name: "name",
                    value: "\(breedName)"
                )
            ]
        )
        return perform(request: request, decoder: decodeSearchedBreeds(from:))
    }
    
}
```

  <p>This is a Swift class that uses the Combine framework to perform network requests. It is designed to interact with the <a href="https://thedogapi.com/">The Dog API</a>.</p>
  <h3>Properties</h3>
  <ul>
    <li><code>shared</code>: a static instance of the Network class, used to access the singleton.</li>
    <li><code>session</code>: a URLSession object used to perform network requests.</li>
    <li><code>urlComponent</code>: a URLComponents object used to manipulate API endpoints.</li>
    <li><code>decoder</code>: a JSONDecoder object used to decode JSON data.</li>
    <li><code>encoder</code>: a JSONEncoder object used to encode JSON data.</li>
  </ul>
  <h3>Methods</h3>
  <ul>
    <li><code>fetchRandomDog(path:)</code>: a method that fetches a random dog image from the API. The <code>path</code> parameter is a string representing the API endpoint.</li>
    <li><code>fetchBreeds(path:)</code>: a method that fetches a list of dog breeds from the API. The <code>path</code> parameter is a string representing the API endpoint.</li>
    <li><code>fetchDogsPerBreed(path:breedId:)</code>: a method that fetches a list of dogs for a given breed ID from the API. The <code>path</code> parameter is a string representing the API endpoint, and the <code>breedId</code> parameter is an integer representing the breed ID.</li>
    <li><code>fetchBreedByText(path:breedName:)</code>: a method that fetches a list of dog breeds that match a given search term from the API. The <code>path</code> parameter is a string representing the API endpoint, and the <code>breedName</code> parameter is a string representing the search term.</li>
  </ul>

## RandomDogViewModel
```Swift
import Foundation
import Combine
import Network

class RandomDogViewModel: ObservableObject {
    @Published var randomDogs = [DogElement]()
    private var randomDogPath = "/images/search"
    private var observers: Set<AnyCancellable> = []
    
    func getRandomDog() {
        Network.shared.fetchRandomDog(path: randomDogPath)
            .sink {
                completion in
                switch completion {
                case .failure(let error):
                    let error = ResponseHandler.shared.mapError(error)
                    print(error.localizedDescription)
                case .finished:
                    print("\(#function) success")
                }
            } receiveValue: { [weak self] data in
                self?.randomDogs = data
            }
            .store(in: &observers)
    }
}
```
<p>The <code>RandomDogViewModel</code> class is an <code>ObservableObject</code> that provides a way to get random dog images from an external API using Combine.</p>

<h3>Properties:</h3>
<ul>
  <li><code>randomDogs</code>: An array of <code>DogElement</code> objects that will be populated with the random dog images obtained from the API.</li>
  <li><code>randomDogPath</code>: The path to the API endpoint for getting random dog images.</li>
  <li><code>observers</code>: A set of <code>AnyCancellable</code> objects used to store references to subscriptions to avoid memory leaks.</li>
</ul>

<h3>Methods:</h3>
<ul>
  <li><code>getRandomDog()</code>: A method that sends a request to the API to get random dog images and updates the <code>randomDogs</code> property with the result. It uses the <code>fetchRandomDog()</code> method from the <code>Network</code> class to perform the request and handles any errors using a <code>switch</code> statement that maps the error to a user-friendly message.</li>
</ul>


## FindBreedViewModel
```Swift
import Foundation
import Combine

class FindBreedViewModel: ObservableObject {
    @Published var allBreeds = [Breed]()
    @Published var searchedBreeds: [SearchedBreedElement] = []
    private let breedPath = "/breeds"
    private let searchBreedPath = "/breeds/search"
    private var observers: Set<AnyCancellable> = []
    
    @Published var searchText: String = ""
    
    init() {
        $searchText
            /// debounces the string publisher, such that it delays the process of sending request to remote server.
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.searchedBreeds = []
                    return nil
                }
                
                return string
            }) /// prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            /// removes the nil values so the search string does not get passed down to the publisher chain
            .compactMap{ $0 }
            .sink { (_) in
            } receiveValue: { [self] (searchField) in
                print(searchField)
                searchBreedByText(searchText: searchField)
            }.store(in: &observers)
    }
    
    func getBreeds() {
        Network.shared.fetchBreeds(path: breedPath)
            .sink {
                completion in
                switch completion {
                case .failure(let error):
                    let error = ResponseHandler.shared.mapError(error)
                    print(error.localizedDescription)
                case .finished:
                    print("\(#function) success")
                }
            } receiveValue: { [weak self] data in
                self?.allBreeds = data
            }
            .store(in: &observers)
    }
    
    func searchBreedByText(searchText: String) {
        Network.shared.fetchBreedByText(path: searchBreedPath, breedName: searchText)
            .sink {
                completion in
                switch completion {
                case .failure(let error):
                    let error = ResponseHandler.shared.mapError(error)
                    print(error.localizedDescription)
                case .finished:
                    print("\(#function) success")
                }
            } receiveValue: { [weak self] data in
                self?.searchedBreeds = data
            }
            .store(in: &observers)
    }
}
```
<p>The <code>FindBreedViewModel</code> class is a ViewModel that is responsible for managing the state and data for the Find Breed feature. It uses the Combine framework to handle the network requests and updates the state accordingly. </p>
<h3>Properties</h3>
<ul>
  <li><code>allBreeds: [Breed]</code> - An array of <code>Breed</code> objects that contains all the available dog breeds.</li>
  <li><code>searchedBreeds: [SearchedBreedElement]</code> - An array of <code>SearchedBreedElement</code> objects that contains the dog breeds searched for by the user.</li>
  <li><code>searchText: String</code> - A string that holds the search text entered by the user.</li>
</ul>
<h3>Methods</h3>
<ul>
  <li><code>getBreeds()</code> - A method that fetches all the dog breeds using the <code>fetchBreeds</code> method of the <code>Network</code> class.</li>
  <li><code>searchBreedByText(searchText: String)</code> - A method that searches for a dog breed by name using the <code>fetchBreedByText</code> method of the <code>Network</code> class.</li>
</ul>
<h3>Initialization</h3>
<p>The <code>FindBreedViewModel</code> class has an initializer that sets up the Combine pipeline to handle the search text entered by the user. It debounces the search text, removes duplicate values, and maps it to a new value. If the length of the string is less than 1, it sets the <code>searchedBreeds</code> array to an empty array. If the length of the string is greater than 1, it calls the <code>searchBreedByText</code> method to search for the dog breeds.</p>

## DogDetailViewModel
```Swift
import Foundation
import Combine

class DogDetailViewModel: ObservableObject {
    @Published var filteredDogs = [DogElement]()
    private var breedIdPath = "/images/search"
    private var observers: Set<AnyCancellable> = []
    
    func getDogsPerBreed(breedId: Int) {
        Network.shared.fetchDogsPerBreed(path: breedIdPath, breedId: breedId)
            .sink {
                completion in
                switch completion {
                case .failure(let error):
                    let error = ResponseHandler.shared.mapError(error)
                    print(error.localizedDescription)
                case .finished:
                    print("\(#function) success")
                }
            } receiveValue: { [weak self] data in
                self?.filteredDogs = data
            }
            .store(in: &observers)
    }
}
```
  <p>This is a view model class that handles API requests for dog images based on the breed ID.</p>
  <h3>Properties</h3>
  <ul>
    <li><code>filteredDogs</code>: An array of <code>DogElement</code> objects representing the filtered list of dogs for the selected breed.</li>
    <li><code>breedIdPath</code>: A string representing the API endpoint for fetching dogs based on breed ID.</li>
    <li><code>observers</code>: A set of <code>AnyCancellable</code> objects used to manage the API request.</li>
  </ul>
  <h3>Methods</h3>
  <ul>
    <li><code>getDogsPerBreed(breedId:)</code>: This method takes in an integer <code>breedId</code> as a parameter and fetches the list of dogs for that breed using the API request. Upon receiving the API response, it updates the <code>filteredDogs</code> property with the fetched data.</li>
  </ul>
  
## Authors & contributors

The original setup of this repository is by [Walter Galiano](https://github.com/wgaliano).
