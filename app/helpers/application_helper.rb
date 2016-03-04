module ApplicationHelper
  def current_user_name
    if current_user.nickname
      "#{current_user.nickname} (#{current_user.name})"
    else
      current_user.name
    end
  end

  def user_name_for(message)
    message.user.nickname || message.user.name
  end

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
      recaptcha_error: 'alert-danger' }.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in", role: 'alert') do
        concat content_tag(:button, '&#x2715'.html_safe, class: 'close', data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end
end
