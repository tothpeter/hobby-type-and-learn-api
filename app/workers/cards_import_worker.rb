class CardsImportWorker
  include Sidekiq::Worker

  def perform cards, user_id
    Card.import cards, user_id
    NotifyBrowserService.notify "cards.import.finished", {user_id: user_id}
  end
end