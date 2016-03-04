##############################################################################
# == Schema Information
#
# Table name: messages
# id                      :integer            not null, primary key
# body                      :text             null: false
# user_id                   :integer
# parent_id                 :integer
# created_at                :datetime         null: false
# updated_at                :datetime         null: false
##############################################################################
class Message < ActiveRecord::Base
  belongs_to :user

  default_scope { includes(:user) }
  # pagination (records per page)
  self.per_page = 20

  validates :body, presence: true,
                   length: { in: 1..200 },
                   uniqueness: { scope: :parent_id,
                                 message: 'can\'t have identical comments' }

  acts_as_tree dependent: :destroy, order: 'created_at'

  def comments
    descendants.hash_tree
  end

  def post?
    !parent_id
  end

  def parent
    Message.find(parent_id)
  end

  def datestamp
    created_at.strftime('%d %b %Y')
  end
end
