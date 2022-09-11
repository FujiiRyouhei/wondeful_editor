module Api
  module V1
    class ArticlesController < BaseApiController
      protect_from_forgery
      skip_before_action :verify_authenticity_token
      # before_action :set_article, only: %i[show update destroy]

      # GET /articles
      # GET /articles.json
      def index
        @articles = Article.all.order(updated_at: :desc)
        render json: @articles, each_serializer: Api::V1::ArticlePreviewSerializer
      end

      # GET /articles/1
      # GET /articles/1.json
      def show
        @article = Article.find(params[:id])
        render json: @article, serializer: Api::V1::ArticleSerializer
      end

      # POST /articles
      # POST /articles.json
      def create
        @article = current_user.articles.create!(article_params)
        render json: @article, serializer: Api::V1::ArticleSerializer
      end

      # PATCH/PUT /articles/1
      # PATCH/PUT /articles/1.json
      def update
        @article = current_user.articles.find(params[:id])
        @article.update!(article_params)
        render json: @article, serializer: Api::V1::ArticleSerializer
      end

      # DELETE /articles/1
      # DELETE /articles/1.json
      def destroy
        @article.destroy
      end

      private

        # Use callbacks to share common setup or constraints between actions.
        # def set_article
        # @article = Article.find(params[:id])
        # @article = current_user.articles.find(params[:id])
        # end

        # Only allow a list of trusted parameters through.
        def article_params
          params.require(:article).permit(:title, :body)
        end
    end
  end
end
