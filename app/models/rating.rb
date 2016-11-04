class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.get_top_rating(number)
    sql = 'SELECT item_id AS id, name, detail_review, SUM(ratings.rate)/count(item_id) AS value, image
            FROM ratings LEFT JOIN items ON items.id = item_id
            GROUP BY item_id
            ORDER BY (SUM(ratings.rate)/count(item_id)) DESC LIMIT 8';
    items = ActiveRecord::Base.connection.execute(sql);
    return items;
  end
end
