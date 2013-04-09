module Guachiman
  module StrongParameters
    attr_reader :allowed_params

    def allow_param resources, attributes
      @allowed_params ||= {}
      Array(resources).each do |resource|
        allowed_params[resource] ||= []
        allowed_params[resource] += Array(attributes)
      end
    end

    def allow_param?(resource, attribute)
      if @allow_all
        true
      elsif @allowed_params && @allowed_params[resource]
        @allowed_params[resource].include? attribute
      end
    end

    def permit_params! params
      if @allow_all
        params.permit!
      elsif allowed_params
        allowed_params.each do |resource, attributes|
          if params[resource].respond_to? :permit
            params[resource] = params[resource].permit(*attributes)
          end
        end
      end
    end
  end
end
