    enum dataExamples: String, CaseIterable {
        case image = "https://cataas.com/cat?width=250"
        case gif = "https://cataas.com/cat/gif"
        case fact = "https://cat-fact.herokuapp.com/facts/random?amount=1"
    }

    struct Fact:Decodable {
        let _id: String?
        let __v: Int?
        let text: String
        let updateAt: String?
        let deleted: Bool?
        let source: String?
        let sentCount: Int?
    }
