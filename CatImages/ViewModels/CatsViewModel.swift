import Foundation
import Combine

final class CatsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var cats: [Cat] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        getAllCats()
    }
    
    // MARK: - Methods
    
    func getAllCats() {
        guard let url = URL(string: "https://cataas.com/api/cats?tags=cute&limit=10") else {
            log("\(URLError.badURL)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(SessionManager.handleOutput)
            .decode(type: [Cat].self, decoder: JSONDecoder())
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
                guard let self = self else { return }
                self.cats = $0
            }
            .store(in: &cancellables)

    }
    
}
