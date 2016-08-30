import Foundation

class Markdown {
	
	let chars = "\\w\\ \\.\\,\\'\\’\\?\\-\\_\\[\\]\\(\\)\\:\\/"
	
	func toHTML(text: String) -> String {
		var parsedText = parseH1(text)
		parsedText = parseH2(parsedText)
		parsedText = parseH3(parsedText)
		parsedText = parseP(parsedText)
		parsedText = parseUL1(parsedText)
		parsedText = parseUL2(parsedText)
		parsedText = parseA1(parsedText)
		parsedText = parseA2(parsedText)
		
		return parsedText
	}
	
	func parseH1(text: String) -> String {
		return regexReplace(text, pattern: "^\\# ([" + chars + "]+)$", replace: "\n<header><h1>$1</h1></header>")
	}
	func parseH2(text: String) -> String {
		return regexReplace(text, pattern: "^\\# ([" + chars + "]+)$", replace: "\n<h2>$1</h2>")
	}
	
	func parseH3(text: String) -> String {
		return regexReplace(text, pattern: "^\\#\\# ([" + chars + "]+)$", replace: "\n<h3>$1</h3>")
	}
	
	func parseP(text: String) -> String {
		return regexReplace(text,
				pattern: "\\n^([" + chars + "]+)\\n", replace: "\n<p>$1</p>")
	}
	
	func parseUL1(text: String) -> String {
		return regexReplace(text,
				pattern: "^\\ \\ \\*\\ ([" + chars + "]+)$", replace: "<ul>\n<li>$1</li>\n</ul>")
	}
	
	func parseUL2(text: String) -> String {
		return regexReplace(text,
				pattern: "^(\\<\\/ul\\>\n\\<ul\\>\n)", replace: "")
	}
	
	func parseA1(text: String) -> String {
		return regexReplace(text,
				pattern: "\\[([\\w\\ ]*)\\]\\((http[\\w\\/\\:\\.\\-]*)\\)",
				replace: "\\<a\\ target\\=\\_blank\\ href\\=\"$2\"\\>$1\\<\\/a\\>")
	}
	
	func parseA2(text: String) -> String {
		return regexReplace(text,
				pattern: "\\[([\\w\\ ]*)\\]\\((\\/[\\w\\/\\:\\.\\-]*)\\)",
				replace: "\\<a\\ href\\=\"$2\"\\>$1\\<\\/a\\>")
	}
	
	func regexReplace(text: String, pattern: String, replace: String) -> String{
		do {
			let regex:NSRegularExpression = try NSRegularExpression(
										pattern: pattern,
										options: [NSRegularExpressionOptions.CaseInsensitive,
												NSRegularExpressionOptions.AnchorsMatchLines])
		
			let modText = regex.stringByReplacingMatchesInString(
						text,
						options: .WithTransparentBounds,
						range: NSMakeRange(0, text.characters.count),
						withTemplate: replace)
		
						return modText
		} catch {
			return ""
		}
	}
	

}
