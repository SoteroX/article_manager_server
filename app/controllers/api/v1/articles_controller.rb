module Api::V1
  class ArticlesController < ApplicationController
    # Create a new article 
    def create
      @accounts = Account.where(user_id: params[:userId])
      @data = []
      @accounts.each do |account|
        if account.url.include? 'dev.to'
          @article_fetcher = DevToScraper.new
          @data.concat @article_fetcher.grab(account)
        else 
          puts "Cant get anything else besides dev.to at the moment"
        #  elsif params[:url].include? 'twitter'
        #   @article_fetcher = TwitterScraper.new
        end
      end
        
      if @data
        @data.each do |title|
          puts "data return #{title[:title]}"
          @article = Article.new(title: title[:title], link: title[:link], avatar: title[:avatar], time: title[:time],account_id: title[:account_id], user_id: params[:userId])
          if @article.save
            puts "article has been saved"
          else
            puts "couldn't save article #{@article.errors.full_messages}"       
          end
        end
        render json: {msg: 'Successful'}
      else
        render json: {msg: 'Unsuccessful'}
      end
    end

    def show
      @articles = Article.where(user_id: params[:id])
      if @articles
        render json: {msg: 'Articles found', data: @articles}
      else
        render json: {msg: 'No articles found', data: []}
      end
    end

    def index
      @article = Article.all
      render json: @article
    end
  end
end