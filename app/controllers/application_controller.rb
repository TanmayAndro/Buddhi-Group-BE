class ApplicationController < ActionController::API
    def to_boolean(value)
        case value.to_s.strip
        when '1' then true
        when '2' then false
        else nil
        end
    end
      
end
