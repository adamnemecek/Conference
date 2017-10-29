
import Foundation

func PassPhraseGenerator(wordCount: Int, callback: @escaping (String) -> Void) {
  DispatchQueue.global().async {
    let fileUrl = Bundle.main.url(forResource: "words", withExtension: "txt")!
    let fileContent = try! String(contentsOf: fileUrl, encoding: .utf8)
    let words = fileContent.components(separatedBy: .newlines)
    var passPhraseWords = [String]()
    while passPhraseWords.count < wordCount {
      let bound = UInt32(words.count)
      let random = RandomNumberGenerator(bound: bound)
      let index = Int(random)
      let word = words[index]
      passPhraseWords.append(word)
    }
    let passPhrase = passPhraseWords.joined(separator: "-")
    DispatchQueue.main.async {
      callback(passPhrase)
    }
  }
}
