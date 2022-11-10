import os

/// Logs error messages with error, file name, line number, and column number
/// - Parameters:
///   - errorMessage: error string from error or custom string error
///   - fileName: gets the file name
///   - lineNumber: gets the line number
///   - columnNumber: gets the column number
func log(_ errorMessage: String,
         fileName: String = #file,
         lineNumber: Int = #line,
         columnNumber: Int = #column) {
    let logger = Logger()
    logger.log(
        """
        Error: \(errorMessage)
        File Name: \(fileName)
        Line Number: \(lineNumber)
        Column Number: \(columnNumber)
        """
    )
}
