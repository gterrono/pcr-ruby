require 'json'
require 'open-uri'
require 'pcr/department'
require 'pcr/coursehistory'

#PCR class handles token and api url, so both are easily changed
module PCR
  class Client
    attr_reader :token

    def initialize(token, api_endpt = "http://api.penncoursereview.com/v1/")
      @token = token
      @api_endpt = api_endpt
    end

    def get_json(path)
      #TODO: Error handling for bad/no token
      raise ArgumentError.new 'Token was not set' unless @token
      JSON.parse(open("#{@api_endpt + path}?token=#{@token}").read)
    end

    def coursehistory(course_code)
      CourseHistory.new(course_code)
    end

    def instructor(id)
      raise NotImplementedError.new("Instructors have not yet been implemented.")
    end

    def department(code)
      Department.new code
    end
  end

  class << self
    attr_accessor :token

    def client
      @client = PCR::Client.new(token) unless @client && token == @client.token
      @client
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

    private
    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
