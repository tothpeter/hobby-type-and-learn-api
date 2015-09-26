class CardsImportWorker
  include Sidekiq::Worker

  def perform cards, user_id
    Card.import cards, user_id
  end
end