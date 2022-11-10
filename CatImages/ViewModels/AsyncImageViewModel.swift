import SwiftUI
import Combine

final class AsyncImageViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let imageCacheManager = ImageCacheFileManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    let imageUrl: String
    let imageKeyId: String
    
    // MARK: - Init
    
    init(urlString: String, catIdKey: String) {
        imageUrl = urlString
        imageKeyId = catIdKey
        getCatImage()
    }
    
    // MARK: - Methods
    
    func getCatImage() {
        if let cachedImage = imageCacheManager.get(key: imageKeyId) {
            image = cachedImage
        } else {
            do {
                try downloadImage()
            } catch let error {
                log(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - Private Methods

extension AsyncImageViewModel {
    
    private func downloadImage() throws {
        guard let url = URL(string: "https://cataas.com/cat/\(imageUrl)") else {
            isLoading = false
            throw URLError(.badURL)
        }
        
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(SessionManager.handleOutput)
            .map { UIImage(data: $0) }
            .sink { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .failure(let error):
                    self.isLoading = false
                    log(error.localizedDescription)
                case .finished:
                    self.isLoading = false
                    break
                }
            } receiveValue: { [weak self] in
                guard let self = self,
                      let returnedImage = $0 else {
                    return
                }
                self.image = returnedImage
                self.imageCacheManager.add(key: self.imageKeyId,
                                           image: returnedImage)
            }
            .store(in: &cancellables)

    }
    
}
