# usage:
#
# it { should permit_params(:email, :name) }
# it { should permit_params(:email, :name).for_class(SpecialUser) }
# it { should permit_params(:name).params_method(:my_params_method) }

module StrongParameterMatcher
  class PermitMatcher
    attr_reader :permitted_params, :errors_protected, :errors_permitted

    def initialize(permitted_params)
      @permitted_params = permitted_params
      @errors_protected = []
      @errors_permitted = []
    end

    def for_class(klass)
      @klass_name = klass.name
      @model = klass
      self
    end

    def params_method(name)
      @params_method = name
      self
    end

    def matches?(controller)
      @klass_name     ||= controller.class.name.gsub("Controller", "").classify
      @model          ||= @klass_name.constantize
      @params_method  ||= "#{@klass_name.underscore}_params".to_sym

      protected_params.each do |param|
        controller.params = action_controller_parameters(param)
        errors_protected << param if controller.send(@params_method)[param.to_sym]
      end

      permitted_params.each do |param|
        controller.params = action_controller_parameters(param)
        errors_permitted << param unless controller.send(@params_method).has_key?(param)
      end

      return errors_protected.empty? && errors_permitted.empty?
    end

    def failure_message
      msg = "expected "
      if !errors_protected.empty?
        msg << "#{errors_protected} to be protected but is permitted"
      else
        msg << "#{errors_permitted} to be permitted but is not"
      end
    end

    def description
      "permit #{permitted_params} through :#{@params_method}"
    end

    private
      def protected_params
        @model.column_names - permitted_params.map(&:to_s)
      end

      def action_controller_parameters(param)
        ActionController::Parameters.new(@klass_name.underscore.to_sym => {param => "random"})
      end
  end

  def permit_params(*keys)
    PermitMatcher.new(keys)
  end
end

RSpec.configure do |config|
  config.include(StrongParameterMatcher)
end