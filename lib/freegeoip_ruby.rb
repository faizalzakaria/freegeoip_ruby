require "freegeoip_ruby/version"

module FreegeoipRuby
  class Configuration
    attr_accessor :endpoint, :options

    def initialize
      self.endpoint = nil
      self.options = {}
      set_defaults
    end

    def set_defaults
      options[:verbose] ||= false
      options[:read_timeout] ||= 30
      options[:use_ssl] ||= false
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.ip_for(ip)
    connection.get do |req|
      req.url "/json/#{ip}"
      req.headers = headers_json
    end
  end

  private

  def self.connection
    @connection ||= Faraday.new(url: configuration.endpoint) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.headers_json
    {
      'User-Agent'        => 'Freegeoip Ruby SDK',
      'Content-Type'      => 'application/json'
    }
  end
end
