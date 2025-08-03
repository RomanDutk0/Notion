//
//  ProjectViewModelTests.swift
//  NotionTests
//
//  Created by Admin on 03.08.2025.
//

import XCTest
@testable import Notion

final class ProjectViewModelTests: XCTestCase {
    
    @MainActor func testNumberOfCardsReturnsCorrectCount() {
        let project = ProjectViewModel.getInstance().projects.first!
        let count = ProjectViewModel.getInstance().numberOfCards(project: project)
        XCTAssertEqual(count, project.taskCards.count)
    }
    
    @MainActor func testGetAllFieldsReturnsFieldsFromFirstCard() {
        let viewModel = ProjectViewModel.getInstance()
        let project = viewModel.projects.first!
        let fields = viewModel.getAllFields(project)
        
        XCTAssertEqual(fields.count, project.taskCards.first?.fieldValues.count ?? 0)
        XCTAssertEqual(fields.first?.name, project.taskCards.first?.fieldValues.first?.field.name)
    }
    
    @MainActor func testAddFieldAppendsNewFieldToArray() {
        let viewModel = ProjectViewModel.getInstance()
        var fields: [Field] = []
        viewModel.addField(name: "Priority", type: .selection, optionsString: "High, Medium, Low", fields: &fields)
        
        XCTAssertEqual(fields.count, 1)
        XCTAssertEqual(fields[0].name, "Priority")
        XCTAssertEqual(fields[0].options, ["High", "Medium", "Low"])
    }
    
    @MainActor func testAddFieldWithEmptyNameDoesNothing() {
        let viewModel = ProjectViewModel.getInstance()
        var fields: [Field] = []
        viewModel.addField(name: "   ", type: .text, optionsString: "", fields: &fields)
        
        XCTAssertEqual(fields.count, 0)
    }
    
    @MainActor func testSaveProjectAppendsToProjectsList() {
        var projects: [Project] = []
        let fields: [Field] = [
            Field(name: "Name", type: .text),
            Field(name: "Progress", type: .number),
            Field(name: "Completed", type: .boolean)
        ]
        let viewModel = ProjectViewModel.getInstance()
        viewModel.saveProject(projects: &projects, fields: fields, projectIcon: "🧪", projectName: "Test Project")
        
        XCTAssertEqual(projects.count, 1)
        let saved = projects[0]
        XCTAssertEqual(saved.projectName, "Test Project")
        XCTAssertEqual(saved.icon, "🧪")
        XCTAssertEqual(saved.templateOfFieldValues.count, fields.count)
    }
    
    @MainActor func testDeleteProjectRemovesFromProjectsList() {
        var projects: [Project] = []
        let viewModel = ProjectViewModel.getInstance()
        viewModel.saveProject(projects: &projects, fields: [
            Field(name: "Name", type: .text)
        ], projectIcon: "❌", projectName: "To be deleted")
        
        XCTAssertEqual(projects.count, 1)
        let projectToDelete = projects[0]
        viewModel.deleteProject(&projects, projectToDelete)
        
        XCTAssertEqual(projects.count, 0)
    }

    @MainActor func testTemplateForTaskReturnsCorrectTemplate() {
        let viewModel = ProjectViewModel.getInstance()
        guard let project = viewModel.projects.first else {
            XCTFail("No projects found")
            return
        }
        let task = project.taskCards.first!
        
        let result = viewModel.template(forTask: task)
        XCTAssertEqual(result?.count, project.templateOfFieldValues.count)
    }
    
    @MainActor func testTemplateForNilTaskReturnsNil() {
        let viewModel = ProjectViewModel.getInstance()
        let result = viewModel.template(forTask: nil)
        XCTAssertNil(result)
    }

    @MainActor func testTemplateForNonProjectTaskReturnsNil() {
        let viewModel = ProjectViewModel.getInstance()
        let unrelatedTask = Task(fieldValues: [])
        let result = viewModel.template(forTask: unrelatedTask)
        XCTAssertNil(result)
    }
}
