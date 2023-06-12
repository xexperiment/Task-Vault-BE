# frozen_string_literal: true

# Seeds is a class responsible for creating seed data for the application.
class Seeds
  class << self
    def call
      Rails.logger.debug '----Seeding Data ----'
      create_user
      create_task
    end

    def create_user
      User.destroy_all
      User.create!(
        first_name: 'user',
        last_name: 'one',
        email: 'johndoe@patch.com',
        password: '123456'
      )
      Rails.logger.debug '----User Created----'
    end

    def create_task
      Task.destroy_all
      Task.create!(
        title: 'to_do app',
        description: 'create app with seed data',
        status: 2,
        priority: 1,
        deadline: '2023-06-02 20:05:51',
        user_id: User.first.id
      )
    end
  end
end

Seeds.call
