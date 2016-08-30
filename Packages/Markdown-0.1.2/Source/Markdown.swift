import Foundation

/// Markdown utility class
public class Markdown {
	
	private let chars = "\\w\\ \\.\\,\\'\\’\\?\\-\\_\\[\\]\\(\\)\\:\\/"
	
	public init() {
		
	}
	
	/**
		Convert Markdown to HTML
	
		- Parameter text: Markdown text
	
		- Returns: Converted HTML
	*/
	public func toHTML(text: String) -> String {
		var parsedText: String
		
		parsedText = parseH1(text)
		parsedText = parseH2(parsedText)
		parsedText = parseH3(parsedText)
		parsedText = parseP(parsedText)
		parsedText = parseUL(parsedText)
		parsedText = parseA(parsedText)
		
		return parsedText
	}
	
	/// Parse H1 tag
	private func parseH1(text: String) -> String {
		return regexReplace(text, pattern: "^\\# ([" + chars + "]+)$", replace: "\n<header><h1>$1</h1></header>")
	}
	
	/// Parse H2 tag
	private func parseH2(text: String) -> String {
		return regexReplace(text, pattern: "^\\# ([" + chars + "]+)$", replace: "\n<h2>$1</h2>")
	}
	
	/// Parse H3 tag
	private func parseH3(text: String) -> String {
		return regexReplace(text, pattern: "^\\#\\# ([" + chars + "]+)$", replace: "\n<h3>$1</h3>")
	}
	
	/// Parse P tag
	private func parseP(text: String) -> String {
		return regexReplace(text,
				pattern: "\\n^([" + chars + "]+)\\n", replace: "\n<p>$1</p>")
	}
	
	/// Parse UL tag
	private func parseUL(text: String) -> String {
		let parsedText = regexReplace(text,
				pattern: "^\\ \\ \\*\\ ([" + chars + "]+)$", replace: "<ul>\n<li>$1</li>\n</ul>")

		return regexReplace(parsedText,
				pattern: "^(\\<\\/ul\\>\n\\<ul\\>\n)", replace: "")
	}
	
	/// Parse A tag
	private func parseA(text: String) -> String {
		let parsedText = regexReplace(text,
				pattern: "\\[([\\w\\ ]*)\\]\\((http[\\w\\/\\:\\.\\-]*)\\)",
				replace: "\\<a\\ target\\=\\_blank\\ href\\=\"$2\"\\>$1\\<\\/a\\>")

		return regexReplace(parsedText,
				pattern: "\\[([\\w\\ ]*)\\]\\((\\/[\\w\\/\\:\\.\\-]*)\\)",
				replace: "\\<a\\ href\\=\"$2\"\\>$1\\<\\/a\\>")
	}
	
	/**
		Function to replace content in string according to regular expression
	
		- Parameter text: Text to be parsed
		- Parameter pattern: Regular expression search pattern
		- Parameter replace: Regular expression replace pattern
	
		- Returns: Parsed text
	*/
	private func regexReplace(text: String, pattern: String, replace: String) -> String{
		do {
			let regex:NSRegularExpression = try NSRegularExpression(pattern: pattern,
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
