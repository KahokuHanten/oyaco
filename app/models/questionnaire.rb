# -*- coding: utf-8 -*-
class Questionnaire
  include ActiveModel::Model

  attr_accessor :dad, :mom, :pref_code, :wedding, :tel, :hobby, :hobby2, :hobby3

  def save # to pass render_wizard @questionnaire
    true
  end

  def assign_attributes(params)
    return if params.blank?
    begin
      if params.key?('dad(1i)') && params.key?('dad(2i)') && params.key?('dad(3i)')
        dad_year = params['dad(1i)'].to_i
        dad_month = params['dad(2i)'].to_i
        dad_day = params['dad(3i)'].to_i
        self.dad = Date.new(dad_year, dad_month, dad_day)
      end
    rescue ArgumentError
      self.dad = nil
    end

    begin
      if params.key?('mom(1i)') && params.key?('mom(2i)') && params.key?('mom(3i)')
        mom_year = params['mom(1i)'].to_i
        mom_month = params['mom(2i)'].to_i
        mom_day = params['mom(3i)'].to_i
        self.mom = Date.new(mom_year, mom_month, mom_day)
      end
    rescue ArgumentError
      self.mom = nil
    end

    begin
      if params.key?('wedding(1i)') && params.key?('wedding(2i)') && params.key?('wedding(3i)')
        wedding_year = params['wedding(1i)'].to_i
        wedding_month = params['wedding(2i)'].to_i
        wedding_day = params['wedding(3i)'].to_i
        self.wedding = Date.new(wedding_year, wedding_month, wedding_day)
      end
    rescue ArgumentError
      self.wedding = nil
    end

    self.pref_code = params[:pref_code] if params[:pref_code]
    self.tel = params[:tel] if params[:tel]
    self.hobby = params[:hobby] if params[:hobby]
    self.hobby2 = params[:hobby2] if params[:hobby2]
    self.hobby3 = params[:hobby3] if params[:hobby3]
  end

  def restore_attributes_from_cookies(cookies)
    if cookies.signed[:dad]
      self.dad = Date.parse(cookies.signed[:dad])
    end

    if cookies.signed[:mom]
      self.mom = Date.parse(cookies.signed[:mom])
    end

    if cookies.signed[:wedding]
      self.wedding = Date.parse(cookies.signed[:wedding])
    end

    self.pref_code = cookies.signed[:pref_code] || '1'
    self.tel = cookies.signed[:tel] || ''
    self.hobby = cookies.signed[:hobby] || '温泉旅行'
    self.hobby2 = cookies.signed[:hobby2] || '落語'
    self.hobby3 = cookies.signed[:hobby3] || ''
  end

  def restore_attributes_from_db(cookies, user)
    cookies.signed[:dad] = user.people.father.first.try('birthday')
    cookies.signed[:mom] = user.people.mother.first.try('birthday')
    cookies.signed[:pref_code] = user.people.father.first.try('location').to_s
    restore_attributes_from_cookies(cookies)
  end
end
