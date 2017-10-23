
// jsonからのデータ変換
struct Entry {
    var title: String
    var desc: String // なくてもいい
    var link: String
    
    init(title: String, desc: String?, link: String) {
        self.title = Entry.trim(title)
        
        if let _desc = desc {
            self.desc = Entry.trim(_desc)
        } else {
            self.desc = ""
        }
        
        self.link = link
    }
    
    // なんか適当感が否めない. http://swift.tecc0.com/?p=141
    static func trim(_ s: String) -> String {
        return s.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
