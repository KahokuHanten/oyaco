module QuestionHelper
  def selected_birthday(key)
    cookies.signed[key] ? Date.parse(cookies.signed[key]) : nil
  end
end
