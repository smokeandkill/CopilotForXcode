import CopilotForXcodeKit
import Foundation
import ConversationServiceProvider
import BuiltinExtension
import Workspace
import LanguageServerProtocol

public final class GitHubCopilotConversationService: ConversationServiceType {
    public func notifyChangeTextDocument(fileURL: URL, content: String, version: Int, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else { return }
        try await service.notifyChangeTextDocument(fileURL: fileURL, content: content, version: version)
    }

    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }

    private func getWorkspaceFolders(workspace: WorkspaceInfo) -> [WorkspaceFolder] {
        let projects = WorkspaceFile.getProjects(workspace: workspace)
        return projects.map { project in
            WorkspaceFolder(uri: project.uri, name: project.name)
        }
    }
    
    private func getMessageContent(_ request: ConversationRequest) -> MessageContent {
        let contentImages = request.contentImages
        let message: MessageContent
        if contentImages.count > 0 {
            var chatCompletionContentParts: [ChatCompletionContentPart] = contentImages.map {
                .imageUrl($0)
            }
            chatCompletionContentParts.append(.text(ChatCompletionContentPartText(text: request.content)))
            message = .messageContentArray(chatCompletionContentParts)
        } else {
            message = .string(request.content)
        }
        
        return message
    }

    public func createConversation(_ request: ConversationRequest, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else { return }
        
        let message = getMessageContent(request)
        
        return try await service.createConversation(message,
                                                    workDoneToken: request.workDoneToken,
                                                    workspaceFolder: workspace.projectURL.absoluteString,
                                                    workspaceFolders: getWorkspaceFolders(workspace: workspace),
                                                    activeDoc: request.activeDoc,
                                                    skills: request.skills,
                                                    ignoredSkills: request.ignoredSkills,
                                                    references: request.references ?? [],
                                                    model: request.model,
                                                    turns: request.turns,
                                                    agentMode: request.agentMode,
                                                    userLanguage: request.userLanguage)
    }
    
    public func createTurn(with conversationId: String, request: ConversationRequest, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else { return }
        
        let message = getMessageContent(request)
        
        return try await service.createTurn(message,
                                            workDoneToken: request.workDoneToken,
                                            conversationId: conversationId,
                                            turnId: request.turnId,
                                            activeDoc: request.activeDoc,
                                            ignoredSkills: request.ignoredSkills,
                                            references: request.references ?? [],
                                            model: request.model,
                                            workspaceFolder: workspace.projectURL.absoluteString,
                                            workspaceFolders: getWorkspaceFolders(workspace: workspace),
                                            agentMode: request.agentMode)
    }
    
    public func cancelProgress(_ workDoneToken: String, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else { return }
        
        await service.cancelProgress(token: workDoneToken)
    }
    
    public func rateConversation(turnId: String, rating: ConversationRating, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else { return }
        try await service.rateConversation(turnId: turnId, rating: rating)
    }
    
    public func copyCode(request: CopyCodeRequest, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else { return }
        try await service.copyCode(turnId: request.turnId, codeBlockIndex: request.codeBlockIndex, copyType: request.copyType, copiedCharacters: request.copiedCharacters, totalCharacters: request.totalCharacters, copiedText: request.copiedText)
    }

    public func templates(workspace: WorkspaceInfo) async throws -> [ChatTemplate]? {
        guard let service = await serviceLocator.getService(from: workspace) else { return nil }
        return try await service.templates()
    }

    public func models(workspace: WorkspaceInfo) async throws -> [CopilotModel]? {
        guard let service = await serviceLocator.getService(from: workspace) else { return nil }
        return try await service.models()
    }
    
    public func notifyDidChangeWatchedFiles(_ event: DidChangeWatchedFilesEvent, workspace: WorkspaceInfo) async throws {
        guard let service = await serviceLocator.getService(from: workspace) else {
            return
        }
        
        return try await service.notifyDidChangeWatchedFiles(.init(workspaceUri: event.workspaceUri, changes: event.changes))
    }
    
    public func agents(workspace: WorkspaceInfo) async throws -> [ChatAgent]? {
        guard let service = await serviceLocator.getService(from: workspace) else { return nil }
        return try await service.agents()
    }
}

