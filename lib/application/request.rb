module Application
  class Request
    def initialize(request_lines, client)
      @http_method = nil
      @full_path   = nil
      @protocol    = nil
      @client = client
      @request_info, *@header_pairs = request_lines
    end

    [:http_method, :full_path, :protocol].each_with_index do |name, index|
      define_method(name) do
        instance_variable_get("@#{name}") ||
          instance_variable_set("@#{name}", request_info.split[index])
      end
    end

    %w[Accept User-Agent Host Port Origin Content-Length].each do |name|
      define_method(name.downcase.tr('-', '_')) do
        headers.fetch(name, nil)
      end
    end

    def base_path
      @base_path ||= full_path.split('?').first
    end

    def params
      @params ||= params_hash(full_path.split('?').last)
    end

    def headers
      @headers ||= header_pairs_hash
    end

    def route_name
      @route_name ||= begin
                        if base_path == '/'
                          :root
                        else
                          base_path.tr('/', '').tr('-', '_')
                        end
                      end
    end

    def body
      return nil unless content_length.to_i > 0
      @body ||= client.read(content_length.to_i)
    end

    def format
      if accept.match?(/^application\/json/i)
        :json
      else
        :html
      end
    end

    def shutdown?
      base_path == '/shutdown'
    end

    private

    attr_reader :request_info, :header_pairs, :client

    def header_pairs_hash
      header_pairs.each_with_object({}) do |pair, hash|
        key, value = pair.split
        hash.store(key.tr(':', ''), value)
      end
    end

    def params_hash(query_string)
      query_string.split('&').each_with_object({}) do |param, hash|
        key, value = param.split('=')
        hash.store(key, value)
      end
    end
  end
end
