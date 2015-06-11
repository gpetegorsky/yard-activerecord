require_relative 'singular_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class HasFeatureHandler < SingularHandler
    handles method_call(:has_feature)

    def group_name
      'Has feature'
    end

    private
    def return_description
      ''
    end
  end
end
