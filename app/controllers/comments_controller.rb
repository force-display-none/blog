class CommentsController < ApplicationController

    http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
  	# コメント関連のリクエストでは、コメントが追加される先の記事がどれであったかを忘れないようにしておく必要があります。そこで、Articleモデルのfindメソッドを最初に呼び出し、リクエストで言及されている記事(のオブジェクト)を取得して@articleに保存しています
  	@article = Article.find(params[:article_id])
  	# @article.commentsに対してcreateメソッドを実行することで、コメントの作成と保存を同時に行っています(訳注: buildメソッドにすれば作成のみで保存は行いません)。この方法でコメントを作成すると、コメントと記事が自動的にリンクされ、指定された記事に対してコメントが従属するようになります
  	@comment = @article.comments.create(comment_params)
  	redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment) .permit(:commenter, :body)
    end
end
