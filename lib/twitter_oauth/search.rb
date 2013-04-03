require 'open-uri'

module TwitterOAuth
  class Client

    def search(q, options={})
      options[:q] = ERB::Util.url_encode(q)
      args = options.map{|k,v| "#{k}=#{v}"}.join('&')
      get("/search/tweets.json?#{args}")
    end

    # Returns the current top 10 trending topics on Twitter.
    def current_trends
      search_get("/trends/current.json")
    end

    # Returns the top 20 trending topics for each hour in a given day.
    def daily_trends
      search_get("/trends/daily.json")
    end

    # Returns the top 30 trending topics for each day in a given week.
    def weekly_trends
      search_get("/trends/weekly.json")
    end

    private
      def search_get(path)
        response = open("http://#{@search_host}" + path, 'User-Agent' => "twitter_oauth gem v#{TwitterOAuth::VERSION}")
        JSON.parse(response.read)
      end
  end
end