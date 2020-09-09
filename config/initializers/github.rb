require "graphql/client/http"

class Github
  HTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      # TODO: Change to Rails secrets enc
      unless token = context[:access_token] || ENV['GITHUB_ACCESS_TOKEN']
        fail "Missing GitHub access token"
      end

      {
        "Authorization" => "Bearer #{token}"
      }
    end
  end

  Client = GraphQL::Client.new(
    schema: Rails.root.join("db/github_schema.json").to_s,
    execute: HTTPAdapter
  )
end