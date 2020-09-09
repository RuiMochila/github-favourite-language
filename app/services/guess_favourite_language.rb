class GuessFavouriteLanguage < ApplicationService
  attr_reader :username

  def initialize(username)
    @username = username
  end

  def call
    nextPageCursor = nil
    languages = []
    
    loop do
      data = query(
        GithubQueries::Search, 
        query: "is:public user:#{username}", 
        type: "REPOSITORY", 
        numOfResults: 100, 
        nextPageCursor: nextPageCursor
      )

      break if data.search.edges.empty?

      data.search.edges.each { |edge| languages << edge.node.primary_language.name }
      nextPageCursor = end_cursor_for(data)

      break unless has_next_page_for(data)
    end

    return "Not Found" if languages.empty?
    languages.group_by(&:to_s).values.max_by(&:size).try(:first)
  end

  private
  # TODO: Refactor in case we need to reuse queries
  def query(definition, variables = {})
    response = Github::Client.query(definition, variables: variables, context: client_context)

    if response.errors.any?
      raise QueryError.new(response.errors[:data].join(", "))
    else
      response.data
    end
  end

  def client_context
    { access_token: ENV['GITHUB_ACCESS_TOKEN'] }
  end  

  def end_cursor_for(data)
    data.search.page_info.end_cursor
  end

  def has_next_page_for(data)
    data.search.page_info.has_next_page?
  end
end