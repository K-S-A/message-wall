module CommentsHelper
  def nested_tree_for(comments)
    comments.map do |comment, nested_comments|
      rendered_comment = render(partial: 'message', object: comment)
      group = rendered_group(nested_comments) unless comment.post?

      content_tag(:div, rendered_comment + group, class: 'comments')
    end.join.html_safe
  end

  def class_for(message)
    message.post? ? 'panel-heading' : 'panel-body'
  end

  def panel_class_for(message)
    message.post? ? 'panel-info' : 'panel-default'
  end

  def user_date_label
    "#{current_user_name} on #{@message.datestamp}: "
  end

  def rendered_group(nested_comments)
    content_tag(:div,
                (nested_tree_for(nested_comments) if nested_comments.try(:any?)),
                class: 'comments-group')
  end
end
