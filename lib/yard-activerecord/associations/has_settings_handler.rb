require_relative 'plural_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class HasSettingsHandler < PluralHandler
    handles method_call(:has_settings)

    def group_name
      'Has settings'
    end

    private
    def return_description
      ''
    end
  end
end
