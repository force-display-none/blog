class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  # ある記事を削除したら、その記事に関連付けられているコメントも一緒に削除する必要があります。そうしないと、コメントがいつまでもデータベース上に残ってしまいます。Railsでは関連付けにdependentオプションを指定することでこれを実現しています
  validates :title, presence: true,
                    length: { minimum: 5 }
end
