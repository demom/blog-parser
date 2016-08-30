import Foundation
import Markdown

class BlogParser {
	 
	func run() {
		let fileList = getFileList(Config.sourceFolder)
		let markdown = Markdown()
		
		let header = readFileContent("header.html", path: Config.templateFolder)
		let footer = readFileContent("footer.html", path: Config.templateFolder)
		var index = header
		for file in fileList {
			print(file)
			
			let destinationFile = file.stringByReplacingOccurrencesOfString(" ", withString: "-").stringByReplacingOccurrencesOfString(".txt", withString: ".html").lowercaseString
			
			let mdText = readFileContent(file, path:Config.sourceFolder)
			var htmlText = markdown.toHTML(mdText)

			index += "\n<article>" + htmlText + "</article>\n"
			htmlText = header + "\n<article>" + htmlText + "</article>\n" + footer
			
			do {
			try htmlText.writeToFile(Config.destinationFolder + "/" + destinationFile, atomically: false, encoding: NSUTF8StringEncoding)
			} catch {}
		}
		

		index += footer
		do {
		try index.writeToFile(Config.destinationFolder + "/index.html", atomically: false, encoding: NSUTF8StringEncoding)
		} catch {}
	}
	
	func readFileContent(fileName: String, path: String) -> String {
		
		do {
			return try String(contentsOfFile: path + "/" + fileName, encoding: NSUTF8StringEncoding)
		} catch {
			return ""
		}
	}
	
	func getFileList(dir: String) -> [String] {
		var fileList = [String]()
		
		let filemanager:NSFileManager = NSFileManager()
		let files = filemanager.enumeratorAtPath(dir)
		while let file = files?.nextObject() {
		    fileList.append(String(file))
		}
		
		return fileList
	}
}
