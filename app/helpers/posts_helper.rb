module PostsHelper
  def render_vote post
    add_vote = link_to "+", vote_post_path(post, vote: true), method: :post
    deduct_vote = link_to "-", vote_post_path(post, vote: false), method: :post
    raw("(") + add_vote + raw(" #{post.total_votes} ") + deduct_vote + raw(")")
  end
end
