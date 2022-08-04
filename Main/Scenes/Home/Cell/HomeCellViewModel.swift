import Core
import RxSwift
import RxCocoa

// MARK: - Class

final class HomeCellViewModel {

    // MARK: - Internal variables

    let post: Post
    let service = HomeService(service: ServiceManager())
    var media: Media?
    let mediaObserver: PublishSubject<Media> = PublishSubject()

    init(post: Post) {
        self.post = post
    }
}

// MARK: - Extension

extension HomeCellViewModel {

    func fetchImage(completion: @escaping(Result<Media, ResponseError>) -> Void) {
        if media == nil {
            service.getMedia(post: post, completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.media = response
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    func setImg() {
        if media == nil {
            service.getMedia(post: post, completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.media = response
                    self.mediaObserver.onNext(response)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
