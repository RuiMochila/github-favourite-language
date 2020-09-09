class GuessFavouriteLanguageJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(username)
    language = GuessFavouriteLanguage.call(username)

    language_html = ApplicationController.renderer.render(
      partial: "pages/language",
      locals: { language: language }
    )

    cable_ready["github:github_channel"].inner_html(
      selector: "#favourite_language",
      html: language_html
    )
 
    cable_ready.broadcast
  end
end
