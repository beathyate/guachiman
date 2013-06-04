module Guachiman
  module Params
    attr_reader :read_allowed_params, :write_allowed_params

    [:read, :write].each do |action|
      ivar = "@#{action}_allowed_params"

      define_method "allow_#{action}_param" do |resources, attributes|
        instance_variable_set(ivar, {}) unless instance_variable_get ivar
        Array(resources).each do |resource|
          instance_variable_get(ivar)[resource] ||= []
          instance_variable_get(ivar)[resource] += Array(attributes)
        end
      end

      define_method "allow_#{action}_param?" do |resource, attribute|
        if instance_variable_get :@allow_all
          true
        elsif instance_variable_get(ivar) && instance_variable_get(ivar)[resource]
          instance_variable_get(ivar)[resource].include? attribute
        end
      end
    end

    def allowed_params
      read_allowed_params & write_allowed_params
    end

    def allow_param resources, attributes
      allow_read_param  resources, attributes
      allow_write_param resources, attributes
    end

    def allow_param? resource, attribute
      allow_write_param?(resource, attribute) && allow_read_param?(resource, attribute)
    end

    def permit_params! params
      if @allow_all
        params.permit!
      elsif write_allowed_params
        write_allowed_params.each do |resource, attributes|
          params[resource] = params[resource].permit(*attributes) if params[resource]
        end
      end
    end
  end
end
