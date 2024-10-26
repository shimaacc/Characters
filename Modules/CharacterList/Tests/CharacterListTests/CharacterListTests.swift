import XCTest
import Common
@testable import CharacterList

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel!
    var mockUseCase: MockFetchCharacterListUseCase!
    var mockNavigation: MockNavigation!
    
    let character = CharacterDomainModel(
        id: 1,
        name: "name",
        status: "alive",
        species: "species",
        gender: .male,
        image: "image",
        location: "location"
    )
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchCharacterListUseCase()
        mockNavigation = MockNavigation()
        viewModel = CharacterListViewModel(useCase: mockUseCase, navigation: mockNavigation)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockNavigation = nil
        super.tearDown()
    }
    
    func testFetchItems_Success() async {
        // Given
        let paginatedOutput = PaginatedOutput(output: [character], next: "next")
        mockUseCase.fetchCharactersResult = .success(paginatedOutput)

        // When
        await viewModel.fetchItems()

        // Then
        XCTAssertEqual(viewModel.characterListDomainModels.count, 1)
        XCTAssertEqual(viewModel.uiModel.characterList.count, 1)
        XCTAssertEqual(viewModel.characterListDomainModels.first, character)
    }

    
    func testFetchItems_Failure() async {
        // Given
        mockUseCase.fetchCharactersResult = .failure(NetworkError.serverError)

        // When
        await viewModel.fetchItems()

        // Then
        XCTAssertEqual(viewModel.characterListDomainModels.count, 0)
        XCTAssertEqual(viewModel.uiModel.characterList.count, 0)
    }

    func testReachEndOfPage_whenNextPageIsNotAvailable_fetchItemsNotCalled() async {
        // Given
        let paginatedOutput = PaginatedOutput(output: [character], next: nil)
        mockUseCase.fetchCharactersResult = .success(paginatedOutput)

        // When
        await viewModel.fetchItems()
        await viewModel.checkIfReachedEndOfPage(for: 1)

        // Then
        XCTAssertEqual(mockUseCase.fetchCharactersCallCount, 1)
        XCTAssertEqual(viewModel.characterListDomainModels.count, 1)
        XCTAssertEqual(viewModel.uiModel.characterList.count, 1)
    }

    
    func testReachEndOfPage_whenNextPageIsAvailable_fetchItemsCalled() async {
        // Given
        let paginatedOutput = PaginatedOutput(output: [character, character] , next: "next")
        mockUseCase.fetchCharactersResult = .success(paginatedOutput)

        // When
        await viewModel.fetchItems()
        await viewModel.checkIfReachedEndOfPage(for: 1)
        // Then
        // called twice and 2 items
        XCTAssertEqual(mockUseCase.fetchCharactersCallCount, 2)
        XCTAssertEqual(viewModel.characterListDomainModels.count, 4)
        XCTAssertEqual(viewModel.uiModel.characterList.count, 4)
    }

    
    func testDidSelectItem_NavigateToDetails_hasArguments() {
        // Given
        viewModel.characterListDomainModels = [character]

        // When
        viewModel.didSelctItem(at: 0)

        // Then
        XCTAssertEqual(mockNavigation.didNavigateTo, "characterDetails")
        XCTAssertNotNil(mockNavigation.didNavigateWithArguments)
        let featureModel = mockNavigation.didNavigateWithArguments as? CharacterDetailsFeatureModel
        XCTAssertEqual(featureModel?.character.name, "name")
    }

    func testCheckIfReachedEndOfPage_IncreasePage() async  {
        // Given
        viewModel.uiModel.characterList = [
            CharacterListViewModel.CharaterItemUIModel(
                title: "name",
                image: "",
                species: "species"
            ),
            CharacterListViewModel.CharaterItemUIModel(
                title: "name",
                image: "",
                species: "species"
            )
        ]

        // When
        await viewModel.checkIfReachedEndOfPage(for: 1)

        // Then
        XCTAssertEqual(viewModel.page, 2)
    }

    func testDidApplyFilterType_ResetPage_ResetListData() async {
        // When
        viewModel.didApplyFilterType()

        // Then
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewModel.characterListDomainModels.count, 0)
        XCTAssertEqual(viewModel.uiModel.characterList.count, 0)
    }
    
    func testMapItemUIModel() {
        // Given
        let characterList = [character]

        // When
        let uiModels = viewModel.mapItemUIModel(from: characterList)

        // Then
        XCTAssertEqual(uiModels.count, 1)
        XCTAssertEqual(uiModels.first?.title, "name")
        XCTAssertEqual(uiModels.first?.species, "species")
    }
}

extension CharacterDomainModel: Equatable {
    public static func == (lhs: CharacterDomainModel, rhs: CharacterDomainModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.status == rhs.status &&
               lhs.species == rhs.species &&
               lhs.gender == rhs.gender &&
               lhs.image == rhs.image &&
               lhs.location == rhs.location
    }
}

