import Vapor

struct Student: Codable {
    let name: String
    let age: Int
}

struct StudentsResponse: Codable {
    let students: [Student]
}

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("sample_json") { req -> String in
        let student = StudentsResponse(students: [Student(name: "John", age: 25),
                                                  Student(name: "Kim", age: 25),
                                                  Student(name: "Paul", age: 25),
                                                 ])
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(student)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
            return "invalid json"
        } catch {
            return error.localizedDescription
        }
    }
}
