require_relative 'plural_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class HasManyOrderedHandler < PluralHandler
    handles method_call(:has_many_ordered)

    def group_name
      'Has many ordered'
    end

    private
    def return_description
      ''
    end
  end
end
